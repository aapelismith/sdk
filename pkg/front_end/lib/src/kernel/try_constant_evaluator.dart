// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:kernel/ast.dart';
import 'package:kernel/target/targets.dart';
import 'package:kernel/type_environment.dart';

import '../base/problems.dart';
import '../codes/cfe_codes.dart';
import 'constant_evaluator.dart';

typedef ReportErrorFunction = void Function(
    LocatedMessage message, List<LocatedMessage>? context);

class TryConstantEvaluator extends ConstantEvaluator {
  final bool _supportReevaluationForTesting;

  @override
  final _ErrorReporter errorReporter;

  TryConstantEvaluator(
      DartLibrarySupport librarySupport,
      ConstantsBackend constantsBackend,
      Component component,
      TypeEnvironment typeEnvironment,
      ReportErrorFunction reportError,
      {Map<String, String>? environmentDefines,
      bool supportReevaluationForTesting = false})
      : this._(librarySupport, constantsBackend, component, typeEnvironment,
            new _ErrorReporter(reportError),
            environmentDefines: environmentDefines,
            supportReevaluationForTesting: supportReevaluationForTesting);

  TryConstantEvaluator._(
      DartLibrarySupport librarySupport,
      ConstantsBackend constantsBackend,
      Component component,
      TypeEnvironment typeEnvironment,
      this.errorReporter,
      {Map<String, String>? environmentDefines,
      bool supportReevaluationForTesting = false})
      : _supportReevaluationForTesting = supportReevaluationForTesting,
        super(librarySupport, constantsBackend, component,
            environmentDefines ?? const {}, typeEnvironment, errorReporter,
            enableTripleShift: true);

  @override
  // Coverage-ignore(suite): Not run.
  Constant evaluate(StaticTypeContext staticTypeContext, Expression node,
      {TreeNode? contextNode}) {
    return evaluateOrNull(staticTypeContext, node, contextNode: contextNode)!;
  }

  /// Evaluates [node] to a constant in the given [staticTypeContext].
  ///
  /// If [requireConstant] is `true`, an error is reported if [node] is not
  /// a valid constant. Otherwise, returns `null` if [node] is not a valid
  /// constant.
  Constant? evaluateOrNull(StaticTypeContext staticTypeContext, Expression node,
      {TreeNode? contextNode, bool requireConstant = true}) {
    errorReporter.requiresConstant = requireConstant;
    if (node is ConstantExpression) {
      // Coverage-ignore-block(suite): Not run.
      Constant constant = node.constant;
      // TODO(fishythefish): Add more control over what to do with
      // [UnevaluatedConstant]s.
      if (constant is UnevaluatedConstant) {
        Constant result = super.evaluate(staticTypeContext, constant.expression,
            contextNode: contextNode);
        assert(
            result is UnevaluatedConstant ||
                !(new UnevaluatedConstantFinder().visitConstant(result)),
            "Invalid constant result $result from ${constant.expression}.");
        if (!_supportReevaluationForTesting) {
          node.constant = result;
        }
        return result;
      }
      return constant;
    }
    if (requireConstant) {
      // Coverage-ignore-block(suite): Not run.
      return super.evaluate(staticTypeContext, node, contextNode: contextNode);
    } else {
      Constant constant =
          super.evaluate(staticTypeContext, node, contextNode: contextNode);
      if (constant is UnevaluatedConstant &&
          constant.expression is InvalidExpression) {
        return null;
      }
      return constant;
    }
  }
}

class _ErrorReporter implements ErrorReporter {
  final ReportErrorFunction _reportError;
  late bool requiresConstant;

  _ErrorReporter(this._reportError);

  @override
  // Coverage-ignore(suite): Not run.
  bool get supportsTrackingReportedErrors => false;

  @override
  // Coverage-ignore(suite): Not run.
  bool get hasSeenError {
    return unsupported("_ErrorReporter.hasSeenError", -1, null);
  }

  @override
  void report(LocatedMessage message, [List<LocatedMessage>? context]) {
    if (requiresConstant) {
      // Coverage-ignore-block(suite): Not run.
      _reportError(message, context);
    }
  }
}

// Coverage-ignore(suite): Not run.
/// [Constant] visitor that returns `true` if the visitor constant contains
/// an [UnevaluatedConstant].
class UnevaluatedConstantFinder extends ComputeOnceConstantVisitor<bool> {
  UnevaluatedConstantFinder();

  @override
  bool visitUnevaluatedConstant(UnevaluatedConstant node) => true;

  @override
  bool visitInstantiationConstant(InstantiationConstant node) {
    return visitConstant(node.tearOffConstant);
  }

  @override
  bool visitInstanceConstant(InstanceConstant node) {
    for (Constant value in node.fieldValues.values) {
      if (visitConstant(value)) {
        return true;
      }
    }
    return false;
  }

  @override
  bool visitSetConstant(SetConstant node) {
    for (Constant value in node.entries) {
      if (visitConstant(value)) {
        return true;
      }
    }
    return false;
  }

  @override
  bool visitListConstant(ListConstant node) {
    for (Constant value in node.entries) {
      if (visitConstant(value)) {
        return true;
      }
    }
    return false;
  }

  @override
  bool visitMapConstant(MapConstant node) {
    for (ConstantMapEntry entry in node.entries) {
      if (visitConstant(entry.key)) {
        return true;
      }
      if (visitConstant(entry.value)) {
        return true;
      }
    }
    return false;
  }

  @override
  bool visitRecordConstant(RecordConstant node) {
    for (Constant c in node.positional) {
      if (visitConstant(c)) return true;
    }
    for (Constant c in node.named.values) {
      if (visitConstant(c)) return true;
    }
    return false;
  }

  @override
  bool visitBoolConstant(BoolConstant node) => false;

  @override
  bool visitConstructorTearOffConstant(ConstructorTearOffConstant node) =>
      false;

  @override
  bool visitDoubleConstant(DoubleConstant node) => false;

  @override
  bool visitIntConstant(IntConstant node) => false;

  @override
  bool visitNullConstant(NullConstant node) => false;

  @override
  bool visitRedirectingFactoryTearOffConstant(
          RedirectingFactoryTearOffConstant node) =>
      false;

  @override
  bool visitStaticTearOffConstant(StaticTearOffConstant node) => false;

  @override
  bool visitStringConstant(StringConstant node) => false;

  @override
  bool visitSymbolConstant(SymbolConstant node) => false;

  @override
  bool visitTypeLiteralConstant(TypeLiteralConstant node) => false;

  @override
  bool visitTypedefTearOffConstant(TypedefTearOffConstant node) => false;

  @override
  bool visitAuxiliaryConstant(AuxiliaryConstant node) {
    throw new UnsupportedError(
        "Unsupported auxiliary constant ${node} (${node.runtimeType}).");
  }
}

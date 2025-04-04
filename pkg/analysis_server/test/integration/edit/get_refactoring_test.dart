// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analysis_server/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import '../support/integration_tests.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(GetRefactoringTest);
  });
}

@reflectiveTest
class GetRefactoringTest extends AbstractAnalysisServerIntegrationTest {
  Future<void> test_rename() async {
    var pathname = sourcePath('test.dart');
    var text = r'''
void foo() { }

void bar() {
  foo();
  foo();
}
''';
    writeFile(pathname, text);
    await standardAnalysisSetup();

    await analysisFinished;
    expect(currentAnalysisErrors[pathname], isEmpty);

    // expect no edits if no rename options specified
    var result = await sendEditGetRefactoring(
      RefactoringKind.RENAME,
      pathname,
      text.indexOf('foo('),
      0,
      false,
    );
    expect(result.initialProblems, isEmpty);
    expect(result.optionsProblems, isEmpty);
    expect(result.finalProblems, isEmpty);
    expect(result.potentialEdits, isNull);
    expect(result.change, isNull);

    // expect a valid rename refactoring
    result = await sendEditGetRefactoring(
      RefactoringKind.RENAME,
      pathname,
      text.indexOf('foo('),
      0,
      false,
      options: RenameOptions('baz'),
    );
    expect(result.initialProblems, isEmpty);
    expect(result.optionsProblems, isEmpty);
    expect(result.finalProblems, isEmpty);
    expect(result.potentialEdits, isNull);

    var change = result.change!;
    expect(change.edits, isNotEmpty);
    var fileEdit = change.edits.first;

    // apply the refactoring, expect that the new code has no errors
    expect(fileEdit.edits, isNotEmpty);
    for (var edit in fileEdit.edits) {
      text = text.replaceRange(edit.offset, edit.end, edit.replacement);
    }
    await sendAnalysisUpdateContent({pathname: AddContentOverlay(text)});

    await analysisFinished;
    expect(currentAnalysisErrors[pathname], isEmpty);
  }
}

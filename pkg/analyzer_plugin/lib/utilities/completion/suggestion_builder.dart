// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' hide Element;
import 'package:analyzer_plugin/utilities/completion/relevance.dart';

/// An object used to build code completion suggestions for Dart code.
abstract class SuggestionBuilder {
  /// Return a suggestion based on the given [element], or `null` if a
  /// suggestion is not appropriate for the given element.
  CompletionSuggestion? forElement(Element2 element,
      {String? completion,
      CompletionSuggestionKind kind = CompletionSuggestionKind.INVOCATION,
      int relevance = DART_RELEVANCE_DEFAULT});
}

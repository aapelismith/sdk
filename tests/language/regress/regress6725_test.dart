// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Formatting can break multitests, so don't format them.
// dart format off

// Regression test for a crash in dart2js.

library crash_6725;

part 'regress6725_part.dart'; //# 01: compile-time error

main() {
  test(); //# 01: continued
}

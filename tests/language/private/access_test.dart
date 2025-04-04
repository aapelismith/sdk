// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:expect/expect.dart';

import 'access_lib.dart';
import 'access_lib.dart' as private;

main() {
  _function();
  // [error column 3, length 9]
  // [analyzer] COMPILE_TIME_ERROR.UNDEFINED_FUNCTION
  // [cfe] Method not found: '_function'.
  private._function();
  //      ^^^^^^^^^
  // [analyzer] COMPILE_TIME_ERROR.UNDEFINED_FUNCTION
  // [cfe] Method not found: '_function'.
  new _Class();
  //  ^^^^^^
  // [analyzer] COMPILE_TIME_ERROR.CREATION_WITH_NON_TYPE
  // [cfe] Couldn't find constructor '_Class'.
  private._Class();
  //      ^^^^^^
  // [analyzer] COMPILE_TIME_ERROR.UNDEFINED_FUNCTION
  // [cfe] Method not found: '_Class'.
  new Class._constructor();
  //        ^^^^^^^^^^^^
  // [analyzer] COMPILE_TIME_ERROR.NEW_WITH_UNDEFINED_CONSTRUCTOR
  // [cfe] Couldn't find constructor 'Class._constructor'.
  new private.Class._constructor();
  //                ^^^^^^^^^^^^
  // [analyzer] COMPILE_TIME_ERROR.NEW_WITH_UNDEFINED_CONSTRUCTOR
  // [cfe] Couldn't find constructor 'Class._constructor'.
}

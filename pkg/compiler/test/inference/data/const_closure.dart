// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/*member: method1:[exact=JSUInt31|powerset=0]*/
method1() {
  return 42;
}

/*member: method2:[exact=JSUInt31|powerset=0]*/
method2(/*[exact=JSUInt31|powerset=0]*/ a) {
  // Called only via [foo2] with a small integer.
  return a;
}

const foo1 = method1;

const foo2 = method2;

/*member: returnInt1:[null|subclass=Object|powerset=1]*/
returnInt1() {
  return foo1();
}

/*member: returnInt2:[null|subclass=Object|powerset=1]*/
returnInt2() {
  return foo2(54);
}

/*member: main:[null|powerset=1]*/
main() {
  returnInt1();
  returnInt2();
}

// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class S0 {}

class S1 extends Object {}

class S2 extends S0 {}

mixin class M0 {}

mixin class M1 extends Object {}

mixin class M2 extends M0 {}
//                     ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_CLASS_DECLARATION_EXTENDS_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class C00 = S0 with M0;
class C01 = S0 with M1;
class C02 = S0 with M2;
//                  ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.
class C03 = S0 with M0, M1;
class C04 = S0 with M0, M2;
//                      ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.
class C05 = S0 with M2, M0;
//                  ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.
class C06 = S0 with M1, M2;
//                      ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.
class C07 = S0 with M2, M1;
//                  ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class C10 = S1 with M0;
class C11 = S1 with M1;
class C12 = S1 with M2;
//                  ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.
class C13 = S1 with M0, M1;
class C14 = S1 with M0, M2;
//                      ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.
class C15 = S1 with M2, M0;
//                  ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.
class C16 = S1 with M1, M2;
//                      ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.
class C17 = S1 with M2, M1;
//                  ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class C20 = S2 with M0;
class C21 = S2 with M1;
class C22 = S2 with M2;
//                  ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.
class C23 = S2 with M0, M1;
class C24 = S2 with M0, M2;
//                      ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.
class C25 = S2 with M2, M0;
//                  ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.
class C26 = S2 with M1, M2;
//                      ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.
class C27 = S2 with M2, M1;
//                  ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D00 extends S0 with M0 {}

class D01 extends S0 with M1 {}

class D02 extends S0 with M2 {}
//                        ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D03 extends S0 with M0, M1 {}

class D04 extends S0 with M0, M2 {}
//                            ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D05 extends S0 with M2, M0 {}
//                        ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D06 extends S0 with M1, M2 {}
//                            ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D07 extends S0 with M2, M1 {}
//                        ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D10 extends S1 with M0 {}

class D11 extends S1 with M1 {}

class D12 extends S1 with M2 {}
//                        ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D13 extends S1 with M0, M1 {}

class D14 extends S1 with M0, M2 {}
//                            ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D15 extends S1 with M2, M0 {}
//                        ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D16 extends S1 with M1, M2 {}
//                            ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D17 extends S1 with M2, M1 {}
//                        ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D20 extends S2 with M0 {}

class D21 extends S2 with M1 {}

class D22 extends S2 with M2 {}
//                        ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D23 extends S2 with M0, M1 {}

class D24 extends S2 with M0, M2 {}
//                            ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D25 extends S2 with M2, M0 {}
//                        ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D26 extends S2 with M1, M2 {}
//                            ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

class D27 extends S2 with M2, M1 {}
//                        ^^
// [analyzer] COMPILE_TIME_ERROR.MIXIN_INHERITS_FROM_NOT_OBJECT
// [cfe] The class 'M2' can't be used as a mixin because it extends a class other than 'Object'.

main() {
  new C00();
  new C01();
  new C02();
  new C03();
  new C04();
  new C05();
  new C06();
  new C07();

  new C10();
  new C11();
  new C12();
  new C13();
  new C14();
  new C15();
  new C16();
  new C17();

  new C20();
  new C21();
  new C22();
  new C23();
  new C24();
  new C25();
  new C26();
  new C27();

  new D00();
  new D01();
  new D02();
  new D03();
  new D04();
  new D05();
  new D06();
  new D07();

  new D10();
  new D11();
  new D12();
  new D13();
  new D14();
  new D15();
  new D16();
  new D17();

  new D20();
  new D21();
  new D22();
  new D23();
  new D24();
  new D25();
  new D26();
  new D27();
}

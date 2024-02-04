import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum MyEnum {
  enumValue1,
  enumValue2,
}

class MyClass {
  int myProperty = 42;
  int get myGetter => 0;
}

class Vehicle {
  Vehicle(this.name);
  String name;
}

void main() {
  final myVar = 45;
  'MyInterA $myVar end';

  String myStr = "hello";
  String? myOptStr = getMyOptString();

  'String interp $myStr';
  // Should generate an lint for String?
  'String? interp $myOptStr';

  final myObject = MyClass();
  myObject.myProperty;
  myObject.myGetter;

  MyEnum enum1 = MyEnum.enumValue1;
  // Should generate a lint for $enum
  'myEnum interp $enum1';
  // Should generate a lint for ${enum1.name}
  'myEnum.name ${enum1.name}';
  // Should generate a lint for ${enum1.toString()}
  'myEnum.toString ${enum1.toString()}';

  final v = Vehicle('test');
  // Should NOT generate a lint as v type is not an "enum" kind
  '${v.name}';

  Map myMap = {};
  'myMap $myMap';
  // Should generate a lint for myMap.toString()
  '${myMap.toString()}';

  final myFlutterIcon = Icon(Icons.add);
  final myFAIcon = FaIcon(Icons.add);
  Column(children: [
    Text('df'),
    myFuncIcon(),
    Icon(Icons.add),
    FaIcon(Icons.add),
  ]);
}

Icon myFuncIcon() => Icon(Icons.add);

String? getMyOptString() {
  if (1 > 2) {
    return null;
  }
  return "hi";
}

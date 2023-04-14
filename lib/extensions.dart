import 'package:flutter/material.dart';

extension RouterContext on BuildContext {
  toNamed(String routeName, {Object? args}) =>
      Navigator.of(this).pushNamed(routeName, arguments: args);

// context.toNamed(RouterName.welcome, args :{'name':'John Doe'})
}

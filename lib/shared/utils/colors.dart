import 'dart:math';

import 'package:flutter/material.dart';

Color get seedColor {
  final Random random = Random(DateTime.now().millisecondsSinceEpoch);
  final r = random.nextInt(128) + 128;
  final g = random.nextInt(128) + 128;
  final b = random.nextInt(128) + 128;
  return Color.fromRGBO(r, g, b, 1);
}

import 'dart:math';

import 'package:flutter/material.dart';

const String identifierPattern = r"[a-zA-Z_]+([a-zA-Z0-9_]*)?";

void showActionDialog<T>({
  required BuildContext context,
  required Widget Function(BuildContext context) builder,
  void Function(T data)? onData,
}) async {
  final T? data = await showDialog<T>(context: context, builder: builder);
  if (onData != null && data != null) onData(data);
}

Color get seedColor {
  final Random random = Random(DateTime.now().millisecondsSinceEpoch);
  final r = random.nextInt(128) + 128;
  final g = random.nextInt(128) + 128;
  final b = random.nextInt(128) + 128;
  return Color.fromRGBO(r, g, b, 1);
}

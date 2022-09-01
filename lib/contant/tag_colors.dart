import 'dart:math';

import 'package:flutter/material.dart';

Color tagColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length - 1)];
}

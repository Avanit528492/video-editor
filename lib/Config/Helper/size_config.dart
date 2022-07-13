import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Size _size = Size(360, 690);

extension SizeConfig on num{

  double get _sw => Get.width / _size.width;
  double get _sh => Get.height / _size.height;
  double get _st => min(_sw, _sh);

  double get w => this * _sw;
  double get h => this * _sh;
  double get sp => this * _st;

}
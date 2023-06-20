import 'package:flutter/material.dart';

abstract class SlideIndicator {
  Widget build(int currentPage, double pageDelta, int itemCount);
}

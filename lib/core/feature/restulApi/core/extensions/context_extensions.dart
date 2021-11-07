import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  double get pageWidth => MediaQuery.of(this).size.width;
  double get pageHeight => MediaQuery.of(this).size.height;
}

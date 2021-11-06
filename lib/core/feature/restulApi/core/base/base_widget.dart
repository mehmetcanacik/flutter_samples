import 'package:flutter/material.dart';

abstract class DraftPage<T extends StatefulWidget> extends State<T> {
  double get pageWidth => MediaQuery.of(context).size.width;
  double get  pageHeight => MediaQuery.of(context).size.height;
}


import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;
  final double width;
  const LoadingWidget({
    Key? key,
    this.color = Colors.grey,
    this.width = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        loadingText,
        progressIndicator(),
      ],
    );
  }

  Widget get loadingText => const Text("Lütfen Bekleyiniz...",
      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500));
  Widget progressIndicator() {
    return SizedBox(
      width: 30.0,
      height: 30.0,
      child: CircularProgressIndicator(
        strokeWidth: width,
        color: color,
      ),
    );
  }
}

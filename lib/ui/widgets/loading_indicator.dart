import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const CircularProgressIndicator(
        valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}

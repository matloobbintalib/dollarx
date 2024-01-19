import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeartWidget extends StatefulWidget {
  final bool isActive;

  const HeartWidget({super.key, required this.isActive});

  @override
  State<HeartWidget> createState() => _HeartWidgetState();
}

class _HeartWidgetState extends State<HeartWidget> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isActive = !isActive;
        });
      },
      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
      icon: SvgPicture.asset(
        isActive
            ? "assets/images/svg/ic_fav.svg"
            : "assets/images/svg/ic_unfav.svg",
        height: 16,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Countdown extends AnimatedWidget {
  const Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(180).toString()}:${(clockTimer.inSeconds.remainder(180) % 180).toString().padLeft(2, '0')}';

    return Text(
      timerText,
      style: const TextStyle(
        // height: textheight,
        // letterSpacing: letterspacing,
        fontSize: 16,
        color: Colors.green,
      ),
    );
  }
}

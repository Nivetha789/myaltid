// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Backgroundscreen extends StatefulWidget {
  final ccontainerchild;
  const Backgroundscreen({super.key, this.ccontainerchild});

  @override
  State<Backgroundscreen> createState() => _BackgroundscreenState();
}

class _BackgroundscreenState extends State<Backgroundscreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: widget.ccontainerchild,
    );
  }
}

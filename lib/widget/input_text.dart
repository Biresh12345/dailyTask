import 'package:flutter/material.dart';

class Inputtext extends StatelessWidget {
  final TextEditingController? controller;
  const new({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(controller: controller);
  }
}

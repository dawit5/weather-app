import 'package:flutter/material.dart';

class Additiona_Information extends StatelessWidget {
  final IconData icon;
  final String label;
  final String num;
  const Additiona_Information(
      {super.key, required this.icon, required this.label, required this.num});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 21,
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Text(
          '$num',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

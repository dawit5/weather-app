import 'package:flutter/material.dart';

class hourlyForcastItem extends StatelessWidget {
  final String time;
  final String temprature;
  final IconData icon;
  const hourlyForcastItem(
      {super.key,
      required this.time,
      required this.temprature,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SizedBox(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(
              time,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Icon(
              icon,
              size: 34,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              temprature,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );
  }
}

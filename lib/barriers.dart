import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;
  const MyBarrier({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          color: const Color.fromARGB(34, 76, 175, 79),
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

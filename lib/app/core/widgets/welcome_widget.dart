import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            width: double.infinity,
            child: Image.asset(
              "assets/images/top_shape.png",
              fit: BoxFit.fill,
            )),
        const Positioned(
            left: 50,
            top: 80,
            child: Text(
              "Welcome",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    );
  }
}

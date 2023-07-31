import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: const TextSpan(
              style: TextStyle(color: Color(0xFF0B0F26), fontSize: 30),
              children: [
                TextSpan(text: "Made with ❤️ by "),
                TextSpan(
                    text: "devera.vn",
                    style: TextStyle(color: Color(0xFF158443)))
              ]),
          textScaleFactor: 0.5,
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}

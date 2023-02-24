import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:whatsappclone/common/extension/custom_theme_extenstion.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'กรุณาอ่าน ',
          style: TextStyle(
            fontFamily: 'thai',
            color: context.theme.greyColor,
            height: 1.5,
          ),
          children: [
            TextSpan(
              text: 'Privacy Policy.                                ',
              style: TextStyle(
                color: context.theme.blueColor,
              ),
            ),
            const TextSpan(text: 'แตะที่ "เข้าใจ เเละ ดำเนินการต่อ" เพื่อยอมรับ         '),
            TextSpan(
              text: 'Terms of Services.',
              style: TextStyle(
                color: context.theme.blueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
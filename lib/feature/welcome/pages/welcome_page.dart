import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:whatsappclone/common/extension/custom_theme_extenstion.dart';
import 'package:whatsappclone/common/routers/routes.dart';
import 'package:whatsappclone/common/widgets/custom_elevated_button.dart';
import 'package:whatsappclone/feature/welcome/widgets/language_button.dart';
import 'package:whatsappclone/feature/welcome/widgets/privacy_and_term.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  navigateToLoginPage(context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
                child: Image.asset(
                  'assets/images/circle.png',
                  color: context.theme.circleImageColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
              child: Column(
            children: [
              const Text(
                'ยินดีต้อนรับเข้าสู่ WhatsApp',
                style: TextStyle(
                  fontFamily: 'thai',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const PrivacyAndTerms(),
              CustomElevatedButton(
                onPressed: () => navigateToLoginPage(context),
                text: 'เข้าใจ เเละ ดำเนินการต่อ',
              ),
              const SizedBox(height: 50),
              const LanguageButton(),
            ],
          ))
        ],
      ),
    );
  }
}

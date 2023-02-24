import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappclone/feature/auth/controller/auth_controller.dart';
import 'package:whatsappclone/feature/auth/widgets/custom_text_field.dart';
import 'package:whatsappclone/common/extension/custom_theme_extenstion.dart';
import 'package:whatsappclone/common/widgets/custom_icon_button.dart';

class VerificationPage extends ConsumerWidget {
  const VerificationPage({
    super.key,
    required this.smsCodeId,
    required this.phoneNumber,
  });

  final String smsCodeId;
  final String phoneNumber;

  void verifySmsCode(
    BuildContext context,
    WidgetRef ref,
    String smsCode,
  ) {
    ref.read(authControllerProvider).verifySmsCode(
          context: context,
          smsCodeId: smsCodeId,
          smsCode: smsCode,
          mounted: true,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ยืนยันเบอร์โทรศัพท์',
          style: TextStyle(
            fontFamily: 'thai',
            color: context.theme.authAppbarTextColor,
          ),
        ),
        actions: [
          CustomIconButton(
            onPressed: () {},
            icon: Icons.more_vert,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: context.theme.greyColor),
                  children: [
                    const TextSpan(
                      text:
                          "คุณได้ลองลงทะเบียนจากเบอร์ +66628600080. กรุณาตรวจสอบ SMS หรือ โทรแจ้งรหัสของคุณ.     ", style: TextStyle(fontFamily: 'thai'),
                    ),
                    TextSpan(
                      text: "เบอร์โทรศัพท์ผิด ?",
                      style: TextStyle(
                        fontFamily: 'thai',
                        color: context.theme.blueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: CustomTextField(
                hintText: "- - -  - - -",
                fontSize: 30,
                autoFocus: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.length == 6) {
                    return verifySmsCode(context, ref, value);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'ใส่รหัส 6 หลักที่คุณได้รับจาก SMS',
              style: TextStyle(color: context.theme.greyColor , fontFamily: 'thai'),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.message, color: context.theme.greyColor),
                const SizedBox(width: 20),
                Text(
                  'ส่ง SMS อีกครั้ง',
                  style: TextStyle(
                    fontFamily: 'thai',
                    color: context.theme.greyColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              color: context.theme.greyColor!.withOpacity(.2),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color: context.theme.greyColor),
                const SizedBox(width: 20),
                Text(
                  'โทรหาฉัน',
                  style: TextStyle(
                    fontFamily: 'thai',
                    color: context.theme.greyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

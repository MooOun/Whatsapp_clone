

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappclone/common/extension/custom_theme_extenstion.dart';
import 'package:whatsappclone/common/helper/show_alert_dialog.dart';
import 'package:whatsappclone/common/utils/coloors.dart';
import 'package:whatsappclone/common/widgets/custom_elevated_button.dart';
import 'package:whatsappclone/common/widgets/custom_icon_button.dart';
import 'package:whatsappclone/feature/auth/controller/auth_controller.dart';
import 'package:whatsappclone/feature/auth/widgets/custom_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  sendCodeToPhone() {
    final phoneNumber = phoneNumberController.text;
    final countryName = countryNameController.text;
    final countryCode = countryCodeController.text;

    if (phoneNumber.isEmpty) {
      return showAlertDialog(
        context: context,
        message: "กรุณาระบุหมายเลขโทรศัพท์",
      );
    } else if (phoneNumber.length < 9) {
      return showAlertDialog(
        context: context,
        message:
            'หมายเลขโทรศัพท์ที่คุณป้อนสั้นเกินไปสำหรับประเทศ: $countryName\n\n.ใส่รหัสพื้นที่ของคุณหากคุณยังไม่มี\'t',
      );
    } else if (phoneNumber.length > 10) {
      return showAlertDialog(
        context: context,
        message:
            "หมายเลขโทรศัพท์ที่คุณป้อนยาวเกินไปสำหรับประเทศ: $countryName",
      );
    }

    ref.read(authControllerProvider).sendSmsCode(
          context: context,
          phoneNumber: "+$countryCode$phoneNumber",
        );
  }

  showCountryPickerBottomSheet() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['TH'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        backgroundColor: Theme.of(context).backgroundColor,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
        textStyle: TextStyle(color: context.theme.greyColor),
        inputDecoration: InputDecoration(
          labelStyle: TextStyle(color: context.theme.greyColor),
          prefixIcon: const Icon(
            Icons.language,
            color: Coloors.greenDark,
          ),
          hintText: 'หาประเทศของคุณจากชื่อหรือรหัส',
          hintStyle: TextStyle(fontFamily: 'thai' ,color: context.theme.greyColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.greyColor!.withOpacity(.2),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Coloors.greenDark,
            ),
          ),
        ),
      ),
      onSelect: (country) {
        countryNameController.text = country.name;
        countryCodeController.text = country.phoneCode;
      },
    );
  }

  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Thailand');
    countryCodeController = TextEditingController(text: '66');
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'กรุณาใส่หมายเลขโทรศัพท์ของคุณ',
          style: TextStyle(
            fontFamily: 'thai',
            color: context.theme.authAppbarTextColor,
          ),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            onPressed: () {},
            icon: Icons.more_vert,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'WhatsApp ต้องการยืนยันตัวตนผ่านเบอร์โทรศัพท์.    ',
                style: TextStyle(
                  fontFamily: 'thai',
                  color: context.theme.greyColor,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: "เบอร์ของฉัน ?",
                    style: TextStyle(
                      fontFamily: 'thai',
                      color: context.theme.blueColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextField(
              onTap: showCountryPickerBottomSheet,
              controller: countryNameController,
              readOnly: true,
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
                color: Coloors.greenDark,
                size: 22,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: CustomTextField(
                    onTap: showCountryPickerBottomSheet,
                    controller: countryCodeController,
                    prefixText: '+',
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    controller: phoneNumberController,
                    hintText: 'เบอร์โทรศัพท์',
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'อาจเสียค่าบริการจากผู้ให้บริการเครือข่าย',
            style: TextStyle(
              fontFamily: 'thai',
              color: context.theme.greyColor,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: sendCodeToPhone,
        text: 'ถัดไป',
        buttonWidth: 90,
      ),
    );
  }
}

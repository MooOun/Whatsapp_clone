import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsappclone/common/extension/custom_theme_extenstion.dart';
import 'package:whatsappclone/common/helper/show_alert_dialog.dart';
import 'package:whatsappclone/common/utils/coloors.dart';
import 'package:whatsappclone/common/widgets/custom_elevated_button.dart';
import 'package:whatsappclone/common/widgets/custom_icon_button.dart';
import 'package:whatsappclone/common/widgets/short_h_bar.dart';
import 'package:whatsappclone/feature/auth/controller/auth_controller.dart';
import 'package:whatsappclone/feature/auth/pages/image_picker_page.dart';
import 'package:whatsappclone/feature/auth/widgets/custom_text_field.dart';



class UserInfoPage extends ConsumerStatefulWidget {
  const UserInfoPage({super.key, this.profileImageUrl});

  final String? profileImageUrl;

  @override
  ConsumerState<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  File? imageCamera;
  Uint8List? imageGallery;

  late TextEditingController usernameController;

  saveUserDataToFirebase() {
    String username = usernameController.text;
    if (username.isEmpty) {
      return showAlertDialog(
        context: context,
        message: 'กรุณาระบุชื่อผู้ใช้',
      );
    } else if (username.length < 3 || username.length > 20) {
      return showAlertDialog(
        context: context,
        message: 'ชื่อผู้ใช้ต้องมีความยาว 3-20 ตัวอักษร',
      );
    }

    ref.read(authControllerProvider).saveUserInfoToFirestore(
          username: username,
          profileImage:
              imageCamera ?? imageGallery ?? widget.profileImageUrl ?? '',
          context: context,
          mounted: mounted,
        );
  }

  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ShortHBar(),
            Row(
              children: [
                const SizedBox(width: 20),
                const Text(
                  'รูปโปรไฟล์',
                  style: TextStyle(
                    fontFamily: 'thai',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                CustomIconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icons.close,
                ),
                const SizedBox(width: 15),
              ],
            ),
            Divider(
              color: context.theme.greyColor!.withOpacity(.3),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(width: 20),
                imagePickerIcon(
                  onTap: pickmageFromCamera,
                  icon: Icons.camera_alt_rounded,
                  text: 'กล้อง',
                ),
                const SizedBox(width: 15),
                imagePickerIcon(
                  onTap: () async {
                    log('hello');
                    Navigator.pop(context);
                    final image = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ImagePickerPage(),
                      ),
                    );
                    if (image == null) return;
                    setState(() {
                      imageGallery = image;
                      imageCamera = null;
                    });
                  },
                  icon: Icons.photo_camera_back_rounded,
                  text: 'อัลบั้ม', 
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }

  pickmageFromCamera() async {
    try {
      Navigator.pop(context);
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imageCamera = File(image!.path);
        imageGallery = null;
      });
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  imagePickerIcon({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [
        CustomIconButton(
          onPressed: onTap,
          icon: icon,
          iconColor: Coloors.greenDark,
          minWidth: 50,
          border: Border.all(
            color: context.theme.greyColor!.withOpacity(.2),
            width: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'thai',
            color: context.theme.greyColor,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'โปรไฟล์',
          style: TextStyle(
            fontFamily: 'thai',
            color: context.theme.authAppbarTextColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'โปรดใส่ชื่อ เเละ รูปโปรไฟล์ของคุณ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'thai',
                color: context.theme.greyColor,
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: imagePickerTypeBottomSheet,
              child: Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.photoIconBgColor,
                  border: Border.all(
                    color: imageCamera == null && imageGallery == null
                        ? Colors.transparent
                        : context.theme.greyColor!.withOpacity(.4),
                  ),
                  image: imageCamera != null ||
                          imageGallery != null ||
                          widget.profileImageUrl != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: imageGallery != null
                              ? MemoryImage(imageGallery!)
                              : widget.profileImageUrl != null
                                  ? NetworkImage(widget.profileImageUrl!)
                                  : FileImage(imageCamera!) as ImageProvider,
                        )
                      : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3, right: 3),
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    size: 48,
                    color: imageCamera == null &&
                            imageGallery == null &&
                            widget.profileImageUrl == null
                        ? context.theme.photoIconColor
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: CustomTextField(
                    controller: usernameController,
                    hintText: 'กรอกชื่อของคุณ',
                    textAlign: TextAlign.start,
                    autoFocus: true,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: context.theme.photoIconColor,
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: saveUserDataToFirebase,
        text: 'ถัดไป',
        buttonWidth: 90,
      ),
    );
  }
}

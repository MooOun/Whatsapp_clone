import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:whatsappclone/common/extension/custom_theme_extenstion.dart';
import 'package:whatsappclone/common/utils/coloors.dart';
import 'package:whatsappclone/common/widgets/custom_icon_button.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

showBottomSheet(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                  color: context.theme.greyColor!.withOpacity(.4),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 20),
                  CustomIconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icons.close,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'ภาษาของแอพพลิเคชัน',
                    style: TextStyle(
                      fontFamily: 'thai',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(
                thickness: .5,
                color: context.theme.greyColor!.withOpacity(.3),
              ),
              RadioListTile(
                value: true,
                groupValue: true,
                onChanged: (value) {},
                activeColor: Coloors.greenDark,
                title: const Text('ภาษาไทย', style: TextStyle(fontFamily: 'thai'),),
                subtitle: Text(
                  "(ค่าเริ่มต้นภาษาจากเครื่อง)",
                  style: TextStyle(
                    fontFamily: 'thai',
                    color: context.theme.greyColor,
                  ),
                ),
              ),
              RadioListTile(
                value: true,
                groupValue: false,
                onChanged: (value) {},
                activeColor: Coloors.greenDark,
                title: const Text('English', style: TextStyle(fontFamily: 'thai'),),
                subtitle: Text(
                  "(United States)",
                  style: TextStyle(
                    fontFamily: 'thai',
                    color: context.theme.greyColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return  Material(
      color: context.theme.langBgColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => showBottomSheet(context),
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: context.theme.langHightlightColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.language,
                color: Coloors.greenDark,
              ),
              SizedBox(width: 10),
              Text(
                'ภาษาไทย',
                style: TextStyle(
                  fontFamily: 'thai',
                  color: Coloors.greenDark,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.keyboard_arrow_down,
                color: Coloors.greenDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

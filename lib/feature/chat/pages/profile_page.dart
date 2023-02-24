import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/common/extension/custom_theme_extenstion.dart';
import 'package:whatsappclone/common/helper/last_seen_message.dart';
import 'package:whatsappclone/common/models/user_model.dart';
import 'package:whatsappclone/common/utils/coloors.dart';
import 'package:whatsappclone/common/widgets/custom_icon_button.dart';
import 'package:whatsappclone/feature/chat/widgets/custom_list_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.profilePageBg,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverPersistentDelegate(user),
            pinned: true,
          ),
          // lets create a long list to make the content scrollable
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    children: [
                      Text(
                        user.username,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.phoneNumber,
                        style: TextStyle(
                          fontSize: 20,
                          color: context.theme.greyColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "อ่านเมื่อ ${lastSeenMessage(user.lastSeen)} ที่เเล้ว",
                        style: TextStyle(color: context.theme.greyColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconWithText(icon: Icons.call, text: 'โทร'),
                          iconWithText(icon: Icons.video_call, text: 'วีดีโอ'),
                          iconWithText(icon: Icons.search, text: 'ค้นหา'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 30),
                  title: const Text('สวัสดีฉันกำลังใช้งาน WhatsApp'),
                  subtitle: Text(
                    '24th February',
                    style: TextStyle(
                      color: context.theme.greyColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomListTile(
                  title: 'ปิดการเเจ้งเตือน',
                  leading: Icons.notifications,
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                const CustomListTile(
                  title: 'จัดการ การเเจ้งเตื่อน',
                  leading: Icons.music_note,
                ),
                CustomListTile(
                  title: 'ซ่อนรูปภาพ',
                  leading: Icons.photo,
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(height: 20),
                const CustomListTile(
                  title: 'เข้ารหัส',
                  subTitle:
                      'ข้อความและการโทรได้รับการเข้ารหัสจากต้นทางถึงปลายทาง แตะเพื่อยืนยัน.',
                  leading: Icons.lock,
                ),
                const CustomListTile(
                  title: 'ข้อความหายไป',
                  subTitle: 'Off',
                  leading: Icons.timer,
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: CustomIconButton(
                    onPressed: () {},
                    icon: Icons.group,
                    background: Coloors.greenDark,
                    iconColor: Colors.white,
                  ),
                  title: Text('สร้างกลุ่มกับ ${user.username}'),
                ),
                const SizedBox(height: 20),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 25, right: 10),
                  leading: const Icon(
                    Icons.block,
                    color: Color(0xFFF15C6D),
                  ),
                  title: Text(
                    'บล็อค ${user.username}',
                    style: const TextStyle(
                      color: Color(0xFFF15C6D),
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 25, right: 10),
                  leading: const Icon(
                    Icons.thumb_down,
                    color: Color(0xFFF15C6D),
                  ),
                  title: Text(
                    'รีพอร์ท ${user.username}',
                    style: const TextStyle(
                      color: Color(0xFFF15C6D),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  iconWithText({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: Coloors.greenDark,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(color: Coloors.greenDark),
          ),
        ],
      ),
    );
  }
}

class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final UserModel user;

  final double maxHeaderHeight = 180;
  final double minHeaderHeight = kToolbarHeight + 20;
  final double maxImageSize = 130;
  final double minImageSize = 40;

  SliverPersistentDelegate(this.user);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final size = MediaQuery.of(context).size;
    final percent = shrinkOffset / (maxHeaderHeight - 35);
    final percent2 = shrinkOffset / (maxHeaderHeight);
    final currentImageSize = (maxImageSize * (1 - percent)).clamp(
      minImageSize,
      maxImageSize,
    );
    final currentImagePosition = ((size.width / 2 - 65) * (1 - percent)).clamp(
      minImageSize,
      maxImageSize,
    );
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Container(
        color: Theme.of(context)
            .appBarTheme
            .backgroundColor!
            .withOpacity(percent2 * 2 < 1 ? percent2 * 2 : 1),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).viewPadding.top + 15,
              left: currentImagePosition + 50,
              child: Text(
                user.username,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white.withOpacity(percent2),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: MediaQuery.of(context).viewPadding.top + 5,
              child: BackButton(
                color:
                    percent2 > .3 ? Colors.white.withOpacity(percent2) : null,
              ),
            ),
            Positioned(
              right: 0,
              top: MediaQuery.of(context).viewPadding.top + 5,
              child: CustomIconButton(
                onPressed: () {},
                icon: Icons.more_vert,
                iconColor: percent2 > .3
                    ? Colors.white.withOpacity(percent2)
                    : Theme.of(context).textTheme.bodyText2!.color,
              ),
            ),
            Positioned(
              left: currentImagePosition,
              top: MediaQuery.of(context).viewPadding.top + 5,
              bottom: 0,
              child: Hero(
                tag: 'ผู้ใช้งาน',
                child: Container(
                  width: currentImageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(user.profileImageUrl),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderHeight;

  @override
  double get minExtent => minHeaderHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

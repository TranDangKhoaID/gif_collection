import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gif_collection/routes.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:gif_collection/screens/account/controller/account_controller.dart';
import 'package:gif_collection/screens/account/widgets/item_value_account_widget.dart';
import 'package:gif_collection/widgets/header_currency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_collection/widgets/shimmer_image.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  //controller
  final _controller = Get.put(AccountController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: _buildDrawer(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const HeaderCurrency(),
                const SizedBox(height: 10),
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 15),
                      child: Icon(Icons.settings),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBodyValues(),
                    SizedBox(
                      height: 200,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: ShareObs.avatarUser.value,
                        placeholder: (context, url) => const ShimmerImage(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('UID: ${ShareObs.user.value!.id}'),
                InkWell(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: ShareObs.user.value!.id!),
                    );
                  },
                  child: Icon(Icons.copy),
                ),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyValues() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ItemValueAccountWidget(
        //   assets: 'assets/images/icons/ruby.png',
        //   name: 'Ruby',
        //   value: ShareObs.ruby.value,
        // ),
        // SizedBox(height: 20),
        // ItemValueAccountWidget(
        //   assets: 'assets/images/icons/coin.png',
        //   name: 'Vàng',
        //   value: ShareObs.coin.value,
        // ),
        // SizedBox(height: 20),
        const ItemValueAccountWidget(
          assets: 'assets/images/icons/monster.png',
          name: 'Thẻ sỡ hữu',
          value: 0,
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoute.searchScreen);
          },
          child: Column(
            children: [
              Text('Tìm thông tin'),
              Image.asset(
                width: 50,
                'assets/images/search.png',
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Text('Bảng xếp hạng'),
              Image.asset(
                width: 50,
                'assets/images/ranking.png',
                fit: BoxFit.cover,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: ShareObs.user.value!.photoUrl ?? '',
                placeholder: (context, url) => const ShimmerImage(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            title: Text(ShareObs.user.value!.name ?? ""),
            subtitle: Text(ShareObs.user.value!.email ?? ""),
          ),
          if (kDebugMode) ...[
            Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.diamond,
                    color: Colors.red,
                  ),
                  title: Text('Làm tí ruby'),
                  onTap: () {
                    _controller.addRuby();
                  },
                ),
                Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.monetization_on,
                    color: Colors.yellow,
                  ),
                  title: Text('Làm tí vàng'),
                  onTap: () {
                    _controller.addCoin();
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Drop and Create Table'),
                  onTap: () {
                    _controller.table();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  title: Text('Delete All My Bag'),
                  onTap: () {
                    _controller.deleteAllData();
                  },
                ),
              ],
            ),
          ],
          Divider(),
          ListTile(
            title: Text('Lưu dữ liệu lên đám mây'),
            onTap: () {
              _controller.saveUserDetail();
            },
            //subtitle: Text(ShareObs.user.value?.updateAt.toString() ?? ''),
          ),
          Divider(),
          ListTile(
            title: Text('Lấy dữ liệu đã lưu về'),
            onTap: () {
              _controller.getUserDetail();
            },
          ),
          Divider(),
          ListTile(
            title: Text('Đăng xuất'),
            onTap: () {
              _controller.logout();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

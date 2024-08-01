import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tikimon_collection/common/share_colors.dart';
import 'package:tikimon_collection/common/share_obs.dart';
import 'package:tikimon_collection/screens/account/controller/account_controller.dart';
import 'package:tikimon_collection/screens/account/widgets/item_value_account_widget.dart';
import 'package:tikimon_collection/widgets/money_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikimon_collection/widgets/shimmer_image.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  //controller
  final _controller = Get.put(AccountController());
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
                Obx(
                  () => _buildHeaderCurrency(),
                ),
                SizedBox(
                  height: 10,
                ),
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
          ],
        ),
      ),
    );
  }

  Column _buildBodyValues() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemValueAccountWidget(
          assets: 'assets/images/icons/ruby.png',
          name: 'Ruby',
          value: ShareObs.ruby.value,
        ),
        SizedBox(
          height: 20,
        ),
        ItemValueAccountWidget(
          assets: 'assets/images/icons/coin.png',
          name: 'Vàng',
          value: ShareObs.coin.value,
        ),
        SizedBox(
          height: 20,
        ),
        ItemValueAccountWidget(
          assets: 'assets/images/icons/monster.png',
          name: 'Quái sỡ hữu',
          value: 0,
        ),
      ],
    );
  }

  Widget _buildHeaderCurrency() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 30),
      child: Row(
        children: [
          Expanded(
            child: MoneyAppBarWidget(
              icon: Icons.diamond,
              money: ShareObs.ruby.value,
              color: ShareColors.kColorRuby,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: MoneyAppBarWidget(
              icon: Icons.monetization_on,
              money: ShareObs.coin.value,
              color: ShareColors.kColorCoin,
            ),
          ),
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
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
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.diamond,
                color: Colors.red,
              ),
              title: Text('Làm tí ruby'),
              onTap: () {
                _controller.addRuby();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.monetization_on,
                color: Colors.yellow,
              ),
              title: Text('Làm tí vàng'),
              onTap: () {
                _controller.addCoin();
              },
            ),
          ),
          ListTile(
            title: Text('Đăng xuất'),
            onTap: () {
              _controller.logout();
            },
          ),
          ListTile(
            title: Text('Lưu dữ liệu lên đám mây'),
            onTap: () {
              _controller.saveUserDetail();
            },
          ),
          ListTile(
            title: Text('Lấy dữ liệu đã lưu về'),
            onTap: () {
              _controller.getUserDetail();
            },
          ),
        ],
      ),
    );
  }
}

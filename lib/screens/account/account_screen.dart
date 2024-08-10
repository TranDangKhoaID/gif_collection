import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gif_collection/routes.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:gif_collection/screens/account/controller/account_controller.dart';
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
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(right: 15),
                      child: const Icon(Icons.settings),
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
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
                  child: const Icon(Icons.copy),
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyValues() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Text('gift'.tr),
              Image.asset(
                width: 50,
                'assets/images/giftbox.png',
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoute.searchScreen);
          },
          child: Column(
            children: [
              Text('find_information'.tr),
              Image.asset(
                width: 50,
                'assets/images/search.png',
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Text('ranking'.tr),
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  title: const Text('Làm tí ruby'),
                  onTap: () {
                    _controller.addRuby();
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.monetization_on,
                    color: Colors.yellow,
                  ),
                  title: const Text('Làm tí vàng'),
                  onTap: () {
                    _controller.addCoin();
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Drop and Create Table'),
                  onTap: () {
                    _controller.table();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  title: const Text('Delete All My Bag'),
                  onTap: () {
                    _controller.deleteAllData();
                  },
                ),
              ],
            ),
          ],
          const Divider(),
          ListTile(
            title: Text('save_data'.tr),
            onTap: () {
              _controller.saveUserDetail();
            },
            //subtitle: Text(ShareObs.user.value?.updateAt.toString() ?? ''),
          ),
          const Divider(),
          ListTile(
            title: Text('get_data'.tr),
            onTap: () {
              _controller.getUserDetail();
            },
          ),
          const Divider(),
          ListTile(
            title: Text('sign_out'.tr),
            onTap: () {
              _controller.logout();
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_tikimon_collection/common/share_obs.dart';
import 'package:card_tikimon_collection/screens/account/controller/account_controller.dart';
import 'package:card_tikimon_collection/widgets/app_bar_global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      appBar: const AppBarGlobal(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Đây là account screen'),
          Text(ShareObs.user.value?.name ?? ''),
          Container(
            height: 300,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: ShareObs.user.value!.avatar!,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                _controller.logout();
              },
              child: Text('Log Out'),
            ),
          ),
        ],
      ),
    );
  }
}

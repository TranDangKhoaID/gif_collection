import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_tikimon_collection/common/share_colors.dart';
import 'package:card_tikimon_collection/common/share_obs.dart';
import 'package:card_tikimon_collection/screens/account/controller/account_controller.dart';
import 'package:card_tikimon_collection/screens/account/widgets/item_value_account_widget.dart';
import 'package:card_tikimon_collection/widgets/money_app_bar_widget.dart';
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
      appBar: _buildAppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
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
                value: ShareObs.coin.value,
              ),
            ],
          ),
          SizedBox(
            height: 200,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: ShareObs.user.value!.avatar!,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.free_breakfast),
              Icon(Icons.free_breakfast),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ShareColors.kSecondColor,
      title: Row(
        children: [
          SizedBox(
            width: 10,
          ),
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
          SizedBox(
            width: 10,
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}

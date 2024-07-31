import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikimon_collection/common/dialog_helper.dart';
import 'package:tikimon_collection/common/share_colors.dart';
import 'package:tikimon_collection/models/tag_model.dart';
import 'package:tikimon_collection/screens/store/controller.dart/gacha_controller.dart';

class GachaScreen extends StatefulWidget {
  const GachaScreen({super.key});

  @override
  State<GachaScreen> createState() => _GachaScreenState();
}

class _GachaScreenState extends State<GachaScreen> {
  //controller
  final _controller = Get.put(GachaController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _controller.getTag(context);

          //if (mounted) {}
        },
        child: Center(
          child: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ShareColors.kPrimaryColor,
            ),
            alignment: Alignment.center,
            child: Text('Mở Hộp'),
          ),
        ),
      ),
    );
  }
}

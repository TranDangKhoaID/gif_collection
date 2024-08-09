import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gif_collection/common/dialog_helper.dart';
import 'package:gif_collection/common/share_colors.dart';
import 'package:gif_collection/common/share_obs.dart';
import 'package:gif_collection/extensions/string.dart';
import 'package:gif_collection/models/my_tag_model.dart';
import 'package:gif_collection/models/tag_background_model.dart';
import 'package:gif_collection/models/tag_model.dart';
import 'package:gif_collection/screens/store/controller.dart/gacha_controller.dart';
import 'package:gif_collection/service/database/my_tag_db.dart';
import 'package:gif_collection/widgets/header_currency.dart';
import 'package:gif_collection/widgets/money_app_bar_widget.dart';
import 'package:gif_collection/widgets/shimmer_image.dart';

class GachaScreen extends StatefulWidget {
  const GachaScreen({super.key});

  @override
  State<GachaScreen> createState() => _GachaScreenState();
}

class _GachaScreenState extends State<GachaScreen> {
  //controller
  final _controller = Get.put(GachaController());
  //db
  final myTagDB = MyTagDB();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const HeaderCurrency(),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('character'.tr),
              ),
              Tab(
                child: Text('event'.tr),
              ),
              Tab(
                child: Text('background'.tr),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            tabStore(),
            tabEvent(),
            tabBackground(),
          ],
        ),
      ),
    );
  }

  Widget tabBackground() {
    return FutureBuilder<List<TagBackgroundModel>>(
      future: _controller.getTagsBackground(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final tagBg = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: tagBg.gif ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const ShimmerImage(),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/error_photo.png',
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return const ShimmerGridView();
      },
    );
  }

  Center tabEvent() {
    return const Center(
      child: Text('Sự kiện'),
    );
  }

  Widget tabStore() {
    return StreamBuilder(
      stream: _controller.getRealtimeTagsDB(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              final tag = MyTagModel.fromJson(snapshot.data![index]);
              return GridTile(
                child: GestureDetector(
                  onTap: () {
                    _controller.pickTag(tag);
                    DialogHelper.showWidgetOkDialog(
                      body: _builDetailTagDialog(tag),
                      context: context,
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: tag.gif ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const ShimmerImage(),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/error_photo.png',
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          print('Hello ${snapshot.error}');
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return Center(
          child: Text(
            'loading'.tr,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }

  Widget _builDetailTagDialog(MyTagModel tag) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            height: 150,
            width: 150,
            imageUrl: tag.gif ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => const ShimmerImage(),
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/error_photo.png',
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          tag.name?.capitalize ?? '',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   '${'race'.tr}: ${tag.race?.capitalize}',
              // ),
              // Text(
              //   '${'attack'.tr}: ??? (${'own_to_see'.tr})',
              // ),
              // Text(
              //   '${'defense'.tr}: ??? (${'own_to_see'.tr})',
              // ),
              Text(
                tag.description ?? 'no_description_available'.tr,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

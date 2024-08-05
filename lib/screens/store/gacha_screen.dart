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
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const HeaderCurrency(),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('Nhân vật'),
              ),
              Tab(
                child: Text('Sự kiện'),
              ),
              Tab(
                child: Text('Hình nền'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _controller.getTagsDB();
                });
              },
              child: tabStore(),
            ),
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
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
    return Center(
      child: Text('Sự kiện'),
    );
  }

  Widget tabStore() {
    return FutureBuilder<List<TagModel>>(
      future: _controller.getTagsDB(),
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
              final tag = snapshot.data![index];
              return GridTile(
                footer: GridTileBar(
                  leading: GestureDetector(
                    onTap: () {
                      DialogHelper.showWidgetDialog(
                        context: context,
                        onPressConfirm: () async {
                          await _controller.buyTag(tag);
                          setState(() {
                            _controller.getTagsDB();
                          });
                        },
                        confirmText: 'Mua',
                        body: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: _builDetailTagDialog(tag),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.error,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: tag.gif ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const ShimmerImage(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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

  Widget _builDetailTagDialog(TagModel tag) {
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
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        SizedBox(height: 10),
        Text(
          tag.name?.capitalize ?? '',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chủng tộc: ${tag.race?.capitalize}',
              ),
              Text(
                'Tấn công: ??? (Sở hữu để xem)',
              ),
              Text(
                'Phòng thủ: ??? (Sở hữu để xem)',
              ),
              Text(
                tag.description ?? 'Không có mô tả',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                'Số lượng thẻ: ${tag.quantity}',
              ),
              tag.ruby != null
                  ? Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 7),
                          width: 25,
                          child: Image.asset(
                            'assets/images/icons/ruby.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          formattedNumber(tag.ruby ?? 999999999),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 7),
                          width: 25,
                          child: Image.asset(
                            'assets/images/icons/coin.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          formattedNumber(tag.coin ?? 999999999),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        )
      ],
    );
  }
}

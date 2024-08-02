import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikimon_collection/common/dialog_helper.dart';
import 'package:tikimon_collection/common/share_colors.dart';
import 'package:tikimon_collection/common/share_obs.dart';
import 'package:tikimon_collection/models/tag_model.dart';
import 'package:tikimon_collection/screens/store/controller.dart/gacha_controller.dart';
import 'package:tikimon_collection/widgets/header_currency.dart';
import 'package:tikimon_collection/widgets/money_app_bar_widget.dart';
import 'package:tikimon_collection/widgets/shimmer_image.dart';

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
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Cửa Hàng'),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('Giới thiệu'),
              ),
              Tab(
                child: Text('Mở hộp'),
              ),
              Tab(
                child: Text('Nhân vật'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            tab_1(),
            tab_2(),
            tab_3(),
          ],
        ),
      ),
    );
  }

  Center tab_3() {
    return Center(
      child: Text('Nhân vật'),
    );
  }

  Center tab_2() {
    return Center(
      child: Text('Mở hộp'),
    );
  }

  Column tab_1() {
    return Column(
      children: [
        const HeaderCurrency(),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(15),
            itemCount: tags.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) => GridTile(
              footer: GridTileBar(
                leading: GestureDetector(
                  onTap: () {
                    DialogHelper.showWidgetDialog(
                      context: context,
                      onPressConfirm: () {},
                      confirmText: 'Mua',
                      body: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height: 150,
                                width: 150,
                                imageUrl: tags[index].gif ?? '',
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const ShimmerImage(),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              tags[index].name?.capitalize ?? '',
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
                                    'Chủng tộc: ${tags[index].race?.capitalize}',
                                  ),
                                  Text(
                                    'Tấn công: ??? (Sở hữu để xem)',
                                  ),
                                  Text(
                                    'Phòng thủ: ??? (Sở hữu để xem)',
                                  ),
                                  Text(
                                    tags[index].description ?? 'Không có mô tả',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
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
                  imageUrl: tags[index].gif ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const ShimmerImage(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

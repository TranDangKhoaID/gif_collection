import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_collection/common/share_styles.dart';
import 'package:gif_collection/screens/account/controller/account_controller.dart';
import 'package:gif_collection/screens/account/widgets/item_value_account_widget.dart';
import 'package:gif_collection/widgets/shimmer_image.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //controller
  final _controller = Get.put(AccountController());
  final TextEditingController _txtIDSearch = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.clearValueSearch();
    _txtIDSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('find_information'.tr),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              controller: _txtIDSearch,
              decoration: InputDecoration(
                focusedBorder: ShareStyles.defaultOutlineBorder,
                border: ShareStyles.defaultOutlineBorder,
                prefixIcon: const Icon(Icons.abc_outlined),
                hintText: 'enter_id_you_want_to_find'.tr,
                hintStyle: ShareStyles.boldStyle.copyWith(
                  color: Colors.black,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    _controller.getSearchUserDetail(
                      idUserSearch: _txtIDSearch.text,
                    );
                  },
                  child: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildBodyValues(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: _controller.sAvatar.value,
                              placeholder: (context, url) =>
                                  const ShimmerImage(),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/error_photo.png',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(_controller.sName.value)
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(15),
                      itemCount: _controller.slistMyTags.value.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 5,
                      ),
                      itemBuilder: (context, index) {
                        final tag = _controller.slistMyTags.value[index];
                        return GridTile(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: tag.gif ?? '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const ShimmerImage(),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/error_photo.png',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyValues() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ItemValueAccountWidget(
          assets: 'assets/images/icons/ruby.png',
          name: 'ruby'.tr,
          value: _controller.sRuby.value,
        ),
        const SizedBox(height: 20),
        ItemValueAccountWidget(
          assets: 'assets/images/icons/coin.png',
          name: 'coin'.tr,
          value: _controller.sCoin.value,
        ),
        const SizedBox(height: 20),
        ItemValueAccountWidget(
          assets: 'assets/images/icons/monster.png',
          name: 'tags'.tr,
          value: 0,
        ),
      ],
    );
  }
}

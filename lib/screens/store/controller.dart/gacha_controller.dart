import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tikimon_collection/common/dialog_helper.dart';
import 'package:tikimon_collection/models/tag_model.dart';

class GachaController extends GetxController {
  Future<void> getTag(BuildContext context) async {
    TagModel tagModel = getRandomTag(tags);
    DialogHelper.showWidgetOkDialog(
      body: Column(
        children: [
          Text('Bạn đã mở được!'),
          Text(tagModel.name.toString()),
          SizedBox(
            height: 150,
            width: 150,
            child: CachedNetworkImage(
              imageUrl: tagModel.gif.toString(),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      context: context,
    );
  }

  // Hàm lấy đối tượng ngẫu nhiên từ danh sách
  TagModel getRandomTag(List<TagModel> tags) {
    final random = Random();
    int index = random.nextInt(tags.length);
    return tags[index];
  }
}

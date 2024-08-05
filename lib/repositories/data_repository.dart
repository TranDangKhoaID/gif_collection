import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:tikimon_collection/common/configs.dart';
import 'package:tikimon_collection/locator.dart';
import 'package:tikimon_collection/models/tag_background_model.dart';
import 'package:tikimon_collection/models/tag_model.dart';
import 'package:tikimon_collection/network/rest_client.dart';
import 'package:tikimon_collection/storage/app_preference.dart';

@lazySingleton
class DataRepository implements RestClient {
  /// MARK: - Initials;
  final dio = Dio();
  late RestClient _client;
  final _appPref = locator<AppPreference>();

  DataRepository() {
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      );
    }

    /// Middleware token
    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (request, handler) async {
    //       final token = (await _appPref.getUser())?.accessToken;
    //       debugPrint('Authorization token: ${'Bearer $token'}');
    //       request.headers['Authorization'] = 'Bearer $token';
    //       request.headers['Accept'] = 'application/json';
    //       handler.next(request);
    //     },
    //   ),
    // );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          request.headers['Accept'] = 'application/json';
          request.headers['apiKey'] = Configs.kAPIKey();
          handler.next(request);
        },
      ),
    );

    _client = RestClient(dio, baseUrl: Configs.kBaseUrl());
  }

  @override
  Future<List<TagModel>> getTags() {
    return _client.getTags();
  }

  @override
  Future<List<TagBackgroundModel>> getTagsBackground() {
    return _client.getTagsBackground();
  }
}

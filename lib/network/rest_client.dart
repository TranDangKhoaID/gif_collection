import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tikimon_collection/common/configs.dart';
import 'package:tikimon_collection/models/tag_model.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  /// MARK: - Initials;
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/rest/v1/tags?select=*')
  Future<List<TagModel>> getTags();
}

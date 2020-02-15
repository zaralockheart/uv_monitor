import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:uv_assessment/model/model.dart';

part 'retrofit.g.dart';

@RestApi(baseUrl: 'https://api.openuv.io/api/v1/uv')
abstract class RestClient extends Test {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
}

abstract class Test {
  @GET('')
  Future<UvIndex> getUv(
    @Query('lat') double latitude,
    @Query('lng') double longitude,
    @Query('dt') String dateTimeIso,
  );
}

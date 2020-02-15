// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.openuv.io/api/v1/uv';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getUv(latitude, longitude, dateTimeIso) async {
    ArgumentError.checkNotNull(latitude, 'latitude');
    ArgumentError.checkNotNull(longitude, 'longitude');
    ArgumentError.checkNotNull(dateTimeIso, 'dateTimeIso');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'lat': latitude,
      'lng': longitude,
      'dt': dateTimeIso
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UvIndex.fromJson(_result.data);
    return Future.value(value);
  }
}

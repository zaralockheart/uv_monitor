import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dio = Dio()
  ..interceptors.addAll([
    InterceptorsWrapper(
        onRequest: (RequestOptions option) => option.headers
            .addAll({'x-access-token': '707a11d9393a5719b0ddd0fb9c3ba7b8'})),

    /// We don't want this logger to be used in release
    if (!kReleaseMode)
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      )
  ]);

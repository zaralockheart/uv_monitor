import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dio = Dio()
  ..interceptors.addAll([
    InterceptorsWrapper(
        onRequest: (RequestOptions option) => option.headers
            .addAll({'x-access-token': DotEnv().env['UV_TOKEN']})),

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

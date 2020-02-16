import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:uv_assessment/main.dart';
import 'package:uv_assessment/service/retrofit.dart';
import 'package:uv_assessment/utils/lib_wrapper.dart';

Widget makeTestableWidget(Widget child) => MyApp(home: child);

class RetrofitMock extends Mock implements RestClient {}

class LibWrapperMock extends Mock implements LibWrapper {}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:uv_assessment/service/dio_config.dart';
import 'package:uv_assessment/service/service.dart';
import 'package:uv_assessment/utils/lib_wrapper.dart';
import 'package:uv_assessment/utils/utils.dart';

import './bloc.dart';

class UvMonitorBloc extends Bloc<UvMonitorEvent, UvMonitorState> {
  final RestClient client;
  final LibWrapper wrapper;

  UvMonitorBloc(this.client, {this.wrapper});

  factory UvMonitorBloc.init() => UvMonitorBloc(
        RestClient(dio),
        wrapper: LibWrapper(),
      );

  @override
  UvMonitorState get initialState => UvMonitorState.initial();

  @override
  Stream<UvMonitorState> mapEventToState(
    UvMonitorEvent event,
  ) async* {
    if (event is Init) {
      add(TrackLocation());
      add(TrackTime());
      add(FetchUvData());
    }

    if (event is FetchUvData) {
      try {
        yield state.copyWith(
            uvFetchingState: const UvFetchingState(
          isFetchingData: true,
          data: null,
          error: null,
        ));

        // Check Location Permission
        await wrapper.checkPermission();

        final currentPosition = await wrapper.getCurrentLocation();
        final data = await client.getUv(
          currentPosition.latitude,
          currentPosition.longitude,
          DateTime.now().ignoreSecond().toIso8601String(),
        );

        yield state.copyWith(
          uvFetchingState: state.uvFetchingState.copyWith(
            data: data,
          ),
        );
      } on DioError catch (e) {
        yield state.copyWith(
            uvFetchingState: state.uvFetchingState.copyWith(
          error: e.response.data['error'] as String,
        ));
      } finally {
        yield state.copyWith(
            uvFetchingState: state.uvFetchingState.copyWith(
          error: null,
          isFetchingData: false,
        ));
      }
    }

    if (event is TrackLocation) {
      wrapper
          .getCurrentLocationStream()
          .listen((location) => add(UpdateLocation(location: location)));
    }

    if (event is TrackTime) {
      const tickCount = Duration(seconds: 1);

      Stream.periodic(
        tickCount,
        (_) => DateTime.now(),
      ).listen((time) => add(UpdateTime(currentTime: time)));
    }

    if (event is UpdateLocation) {
      yield state.copyWith(
        longitude: event.location.longitude,
        latitude: event.location.latitude,
      );
    }

    if (event is UpdateTime) {
      yield state.copyWith(currentTime: event.currentTime.reFormat());
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:uv_assessment/bloc/bloc.dart';
import 'package:uv_assessment/bloc/uv_monitor_state.dart';
import 'package:uv_assessment/model/model.dart';
import 'package:uv_assessment/utils/utils.dart';

import 'utilities.dart';

void main() {
  final wrapper = LibWrapperMock();

  test('Test bloc track time', () {
    final client = RetrofitMock();

    final bloc = UvMonitorBloc(client);

    expectLater(
        bloc,
        emitsInOrder([
          UvMonitorState.initial(),
          UvMonitorState(
            latitude: null,
            longitude: null,
            uvFetchingState: const UvFetchingState(
              data: null,
              isFetchingData: false,
              error: null,
            ),
            currentTime: DateTime.now().reFormat(),
          )
        ]));

    bloc.add(TrackTime());
  });

  test('Test bloc track location', () {
    when(wrapper.getCurrentLocationStream())
        .thenAnswer((_) => Stream.fromIterable([
              Position(
                latitude: 3.0515,
                longitude: 101.742,
              )
            ]));

    final client = RetrofitMock();

    final bloc = UvMonitorBloc(client, wrapper: wrapper);

    expectLater(
        bloc,
        emitsInOrder([
          UvMonitorState.initial(),
          UvMonitorState.initial().copyWith(
            latitude: 3.0515,
            longitude: 101.742,
          ),
        ]));

    bloc.add(TrackLocation());
  });

  test('Test bloc update location', () {
    final client = RetrofitMock();

    final bloc = UvMonitorBloc(client);

    expectLater(
        bloc,
        emitsInOrder([
          UvMonitorState.initial(),
          UvMonitorState.initial().copyWith(
            latitude: 3.0515,
            longitude: 101.742,
          ),
        ]));

    bloc.add(UpdateLocation(
        location: Position(
      latitude: 3.0515,
      longitude: 101.742,
    )));
  });

  test('Test bloc update time', () {
    final client = RetrofitMock();
    final bloc = UvMonitorBloc(client);

    expectLater(
        bloc,
        emitsInOrder([
          UvMonitorState.initial(),
          UvMonitorState.initial().copyWith(currentTime: 'May 20, 01:41 AM'),
        ]));

    bloc.add(UpdateTime(currentTime: DateTime(2017, 5, 20, 1, 41, 45)));
  });

  test('Test fetch data', () async {
    final now = DateTime.now().ignoreSecond();
    final client = RetrofitMock();

    when(wrapper.checkPermission()).thenAnswer(
      (_) => Future.value(GeolocationStatus.granted),
    );

    when(wrapper.getCurrentLocation()).thenAnswer(
      (realInvocation) => Future.value(
        Position(
          latitude: 10.1,
          longitude: 20.1,
        ),
      ),
    );

    const mockResponse = UvIndex(
      result: Result(uvMax: 1000.100),
    );
    when(client.getUv(10.1, 20.1, now.toIso8601String())).thenAnswer(
      (_) => Future.value(
        mockResponse,
      ),
    );

    final bloc = UvMonitorBloc(client, wrapper: wrapper);

    expectLater(
        bloc,
        emitsInOrder([
          UvMonitorState.initial(),
          UvMonitorState.initial().copyWith(
              uvFetchingState: const UvFetchingState(
            isFetchingData: true,
            data: null,
            error: null,
          )),
          UvMonitorState.initial().copyWith(
              uvFetchingState: const UvFetchingState(
            error: null,
            isFetchingData: true,
            data: UvIndex(
              result: Result(uvMax: 1000.100),
            ),
          )),
          UvMonitorState.initial().copyWith(
              uvFetchingState: const UvFetchingState(
            error: null,
            isFetchingData: false,
            data: UvIndex(
              result: Result(uvMax: 1000.100),
            ),
          )),
        ]));

    bloc.add(FetchUvData());
  });
}

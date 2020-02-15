import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uv_assessment/model/model.dart';

class UvMonitorState extends Equatable {
  final UvFetchingState uvFetchingState;
  final num longitude;
  final num latitude;
  final String currentTime;

  const UvMonitorState({
    @required this.uvFetchingState,
    @required this.longitude,
    @required this.latitude,
    @required this.currentTime,
  });

  factory UvMonitorState.initial() => const UvMonitorState(
        uvFetchingState: UvFetchingState(
          data: null,
          isFetchingData: false,
          error: null,
        ),
        longitude: null,
        latitude: null,
        currentTime: null,
      );

  UvMonitorState copyWith({
    UvFetchingState uvFetchingState,
    num longitude,
    num latitude,
    String currentTime,
  }) =>
      UvMonitorState(
        uvFetchingState: uvFetchingState ?? this.uvFetchingState,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        currentTime: currentTime ?? this.currentTime,
      );

  @override
  List<Object> get props => [
        uvFetchingState,
        latitude,
        longitude,
        currentTime,
      ];

  @override
  String toString() {
    return '''
    UvMonitorState(
        uvFetchingState: $uvFetchingState,
        longitude: $longitude,
        latitude: $latitude,
        currentTime: $currentTime,
    )
    ''';
  }
}

class UvFetchingState extends Equatable {
  final bool isFetchingData;
  final UvIndex data;
  final String error;

  const UvFetchingState({
    this.isFetchingData,
    this.data,
    this.error,
  });

  UvFetchingState copyWith({
    bool isFetchingData,
    UvIndex data,
    String error,
  }) =>
      UvFetchingState(
        isFetchingData: isFetchingData ?? this.isFetchingData,
        data: data ?? this.data,
        error: error ?? this.error,
      );

  @override
  List<Object> get props => [
        isFetchingData,
        data,
        error,
      ];

  @override
  String toString() {
    return '''
    UvFetchingState(
        isFetchingData: $isFetchingData,
        data: $data,
        error: $error,
    )
    ''';
  }
}

import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class UvMonitorEvent extends Equatable {
  const UvMonitorEvent();
}

class Init extends UvMonitorEvent {
  @override
  List<Object> get props => [];
}

class FetchUvData extends UvMonitorEvent {
  @override
  List<Object> get props => [];
}

class TrackLocation extends UvMonitorEvent {
  @override
  List<Object> get props => [];
}

class UpdateLocation extends UvMonitorEvent {
  final Position location;

  const UpdateLocation({this.location});

  @override
  List<Object> get props => [location];
}

class TrackTime extends UvMonitorEvent {
  @override
  List<Object> get props => [];
}

class UpdateTime extends UvMonitorEvent {
  final DateTime currentTime;

  const UpdateTime({this.currentTime});

  @override
  List<Object> get props => [currentTime];


}

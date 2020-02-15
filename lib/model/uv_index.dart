import 'package:equatable/equatable.dart';

class UvIndex extends Equatable {
  final Result result;

  const UvIndex({
    this.result,
  });

  factory UvIndex.fromJson(Map<String, dynamic> json) => UvIndex(
        result: json['result'] == null
            ? null
            : Result.fromJson(json['result'] as Map<String, dynamic>),
      );

  @override
  List<Object> get props => [
        result,
      ];
}

class Result extends Equatable {
  final num uv;
  final DateTime uvTime;
  final num uvMax;
  final DateTime uvMaxTime;
  final num ozone;
  final DateTime ozoneTime;
  final SafeExposureTime safeExposureTime;
  final SunInfo sunInfo;

  const Result({
    this.uv,
    this.uvTime,
    this.uvMax,
    this.uvMaxTime,
    this.ozone,
    this.ozoneTime,
    this.safeExposureTime,
    this.sunInfo,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        uv: json['uv'] == null ? null : json['uv'] as num,
        uvTime: json['uv_time'] == null
            ? null
            : DateTime.parse(json['uv_time'] as String),
        uvMax: json['uv_max'] == null ? null : (json['uv_max'] as num),
        uvMaxTime: json['uv_max_time'] == null
            ? null
            : DateTime.parse(json['uv_max_time'].toString()),
        ozone: json['ozone'] == null ? null : (json['ozone'] as num),
        ozoneTime: json['ozone_time'] == null
            ? null
            : DateTime.parse(json['ozone_time'].toString()),
        safeExposureTime: json['safe_exposure_time'] == null
            ? null
            : SafeExposureTime.fromJson(
                json['safe_exposure_time'] as Map<String, dynamic>),
        sunInfo: json['sun_info'] == null
            ? null
            : SunInfo.fromJson(json['sun_info'] as Map<String, dynamic>),
      );

  @override
  List<Object> get props => [
        uv,
        uvTime,
        uvMax,
        uvMaxTime,
        ozone,
        ozoneTime,
        safeExposureTime,
        sunInfo,
      ];
}

/// Apparently this object is there in documentation.
/// But it's a habit to similarize data from server.
class SafeExposureTime extends Equatable {
  final dynamic st1;
  final dynamic st2;
  final dynamic st3;
  final dynamic st4;
  final dynamic st5;
  final dynamic st6;

  const SafeExposureTime({
    this.st1,
    this.st2,
    this.st3,
    this.st4,
    this.st5,
    this.st6,
  });

  factory SafeExposureTime.fromJson(Map<String, dynamic> json) =>
      SafeExposureTime(
        st1: json['st1'],
        st2: json['st2'],
        st3: json['st3'],
        st4: json['st4'],
        st5: json['st5'],
        st6: json['st6'],
      );

  Map<String, dynamic> toJson() => {
        'st1': st1,
        'st2': st2,
        'st3': st3,
        'st4': st4,
        'st5': st5,
        'st6': st6,
      };

  @override
  List<Object> get props => [
        st1,
        st2,
        st3,
        st4,
        st5,
        st6,
      ];
}

class SunInfo extends Equatable {
  final SunTimes sunTimes;
  final SunPosition sunPosition;

  const SunInfo({
    this.sunTimes,
    this.sunPosition,
  });

  factory SunInfo.fromJson(Map<String, dynamic> json) => SunInfo(
        sunTimes: json['sun_times'] == null
            ? null
            : SunTimes.fromJson(json['sun_times'] as Map<String, dynamic>),
        sunPosition: json['sun_position'] == null
            ? null
            : SunPosition.fromJson(
                json['sun_position'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'sun_times': sunTimes == null ? null : sunTimes.toJson(),
        'sun_position': sunPosition == null ? null : sunPosition.toJson(),
      };

  @override
  List<Object> get props => [
        sunTimes,
        sunPosition,
      ];
}

class SunPosition extends Equatable {
  final num azimuth;
  final num altitude;

  const SunPosition({
    this.azimuth,
    this.altitude,
  });

  factory SunPosition.fromJson(Map<String, dynamic> json) => SunPosition(
        azimuth: json['azimuth'] == null ? null : (json['azimuth'] as num),
        altitude: json['altitude'] == null ? null : (json['altitude'] as num),
      );

  Map<String, dynamic> toJson() => {
        'azimuth': azimuth,
        'altitude': altitude,
      };

  @override
  List<Object> get props => [
        azimuth,
        altitude,
      ];
}

class SunTimes extends Equatable {
  final DateTime solarNoon;
  final DateTime nadir;
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime sunriseEnd;
  final DateTime sunsetStart;
  final DateTime dawn;
  final DateTime dusk;
  final DateTime nauticalDawn;
  final DateTime nauticalDusk;
  final DateTime nightEnd;
  final DateTime night;
  final DateTime goldenHourEnd;
  final DateTime goldenHour;

  const SunTimes({
    this.solarNoon,
    this.nadir,
    this.sunrise,
    this.sunset,
    this.sunriseEnd,
    this.sunsetStart,
    this.dawn,
    this.dusk,
    this.nauticalDawn,
    this.nauticalDusk,
    this.nightEnd,
    this.night,
    this.goldenHourEnd,
    this.goldenHour,
  });

  factory SunTimes.fromJson(Map<String, dynamic> json) => SunTimes(
        solarNoon: json['solarNoon'] == null
            ? null
            : DateTime.parse(json['solarNoon'].toString()),
        nadir: json['nadir'] == null
            ? null
            : DateTime.parse(json['nadir'].toString()),
        sunrise: json['sunrise'] == null
            ? null
            : DateTime.parse(json['sunrise'].toString()),
        sunset: json['sunset'] == null
            ? null
            : DateTime.parse(json['sunset'].toString()),
        sunriseEnd: json['sunriseEnd'] == null
            ? null
            : DateTime.parse(json['sunriseEnd'].toString()),
        sunsetStart: json['sunsetStart'] == null
            ? null
            : DateTime.parse(json['sunsetStart'].toString()),
        dawn: json['dawn'] == null
            ? null
            : DateTime.parse(json['dawn'].toString()),
        dusk: json['dusk'] == null
            ? null
            : DateTime.parse(json['dusk'].toString()),
        nauticalDawn: json['nauticalDawn'] == null
            ? null
            : DateTime.parse(json['nauticalDawn'].toString()),
        nauticalDusk: json['nauticalDusk'] == null
            ? null
            : DateTime.parse(json['nauticalDusk'].toString()),
        nightEnd: json['nightEnd'] == null
            ? null
            : DateTime.parse(json['nightEnd'].toString()),
        night: json['night'] == null
            ? null
            : DateTime.parse(json['night'].toString()),
        goldenHourEnd: json['goldenHourEnd'] == null
            ? null
            : DateTime.parse(json['goldenHourEnd'].toString()),
        goldenHour: json['goldenHour'] == null
            ? null
            : DateTime.parse(json['goldenHour'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'solarNoon': solarNoon == null ? null : solarNoon?.toIso8601String(),
        'nadir': nadir == null ? null : nadir?.toIso8601String(),
        'sunrise': sunrise == null ? null : sunrise?.toIso8601String(),
        'sunset': sunset == null ? null : sunset?.toIso8601String(),
        'sunriseEnd': sunriseEnd == null ? null : sunriseEnd?.toIso8601String(),
        'sunsetStart':
            sunsetStart == null ? null : sunsetStart?.toIso8601String(),
        'dawn': dawn == null ? null : dawn?.toIso8601String(),
        'dusk': dusk == null ? null : dusk?.toIso8601String(),
        'nauticalDawn':
            nauticalDawn == null ? null : nauticalDawn?.toIso8601String(),
        'nauticalDusk':
            nauticalDusk == null ? null : nauticalDusk?.toIso8601String(),
        'nightEnd': nightEnd == null ? null : nightEnd?.toIso8601String(),
        'night': night == null ? null : night?.toIso8601String(),
        'goldenHourEnd':
            goldenHourEnd == null ? null : goldenHourEnd?.toIso8601String(),
        'goldenHour': goldenHour == null ? null : goldenHour?.toIso8601String(),
      };

  @override
  List<Object> get props => [
        solarNoon,
        nadir,
        sunrise,
        sunset,
        sunriseEnd,
        sunsetStart,
        dawn,
        dusk,
        nauticalDawn,
        nauticalDusk,
        nightEnd,
        night,
        goldenHourEnd,
        goldenHour,
      ];
}

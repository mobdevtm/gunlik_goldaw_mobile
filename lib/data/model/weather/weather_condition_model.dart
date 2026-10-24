import 'package:equatable/equatable.dart';
import 'package:gunluk_goldaw_mobile/data/model/weather/localized_text_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_condition_model.g.dart';

/// The sky and weather in one word, plus Google's own icon and wording.
@JsonSerializable(explicitToJson: true)
class WeatherConditionModel extends Equatable {
  const WeatherConditionModel({this.iconBaseUri, this.description, this.type});

  final String? iconBaseUri;

  /// Not shown — see [LocalizedTextModel].
  final LocalizedTextModel? description;

  /// The condition enum, e.g. `PARTLY_CLOUDY` or `LIGHT_RAIN_SHOWERS`.
  ///
  /// Kept as a string so a value added to the API later reads as "unknown"
  /// rather than failing the whole response.
  final String? type;

  factory WeatherConditionModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherConditionModelToJson(this);

  @override
  List<Object?> get props => [iconBaseUri, description, type];
}

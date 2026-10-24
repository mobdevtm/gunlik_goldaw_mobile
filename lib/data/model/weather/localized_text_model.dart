import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'localized_text_model.g.dart';

/// A piece of text in one language.
///
/// Parsed for completeness only: Google offers no Turkmen, so the app words
/// conditions from `weatherCondition.type` through its own translations.
@JsonSerializable(explicitToJson: true)
class LocalizedTextModel extends Equatable {
  const LocalizedTextModel({this.text, this.languageCode});

  final String? text;
  final String? languageCode;

  factory LocalizedTextModel.fromJson(Map<String, dynamic> json) =>
      _$LocalizedTextModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizedTextModelToJson(this);

  @override
  List<Object?> get props => [text, languageCode];
}

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'speaker_style.freezed.dart';
part 'speaker_style.g.dart';

// TODO: 話者ごとの設定などは将来的にプリセットとして管理するため、ドメイン層に移すことを検討する
@freezed
abstract class SpeakerStyle with _$SpeakerStyle {
  const SpeakerStyle._();
  const factory SpeakerStyle({
    required String speakerName,
    required String styleName,
    required int id,
  }) = _SpeakerStyle;
  factory SpeakerStyle.fromJson(Map<String, Object?> json) =>
      _$SpeakerStyleFromJson(json);

  String get label => '$speakerName / $styleName';
}

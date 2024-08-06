// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CandidatesImpl _$$CandidatesImplFromJson(Map<String, dynamic> json) =>
    _$CandidatesImpl(
      content: json['content'] == null
          ? null
          : Content.fromJson(json['content'] as Map<String, dynamic>),
      finishedReason: json['finishedReason'] as String?,
      index: (json['index'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CandidatesImplToJson(_$CandidatesImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'finishedReason': instance.finishedReason,
      'index': instance.index,
    };

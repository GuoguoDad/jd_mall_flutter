import 'package:json_annotation/json_annotation.dart';

part 'page_args.g.dart';

@JsonSerializable()
class PageArgs {
  final String? from;
  final Object? args;

  const PageArgs({
    this.from,
    this.args,
  });

  factory PageArgs.fromJson(Map<String, dynamic> json) => _$PageArgsFromJson(json);

  Map<String, dynamic> toJson() => _$PageArgsToJson(this);
}

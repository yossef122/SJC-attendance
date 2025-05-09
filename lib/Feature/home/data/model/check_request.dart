import 'package:json_annotation/json_annotation.dart';

part 'check_request.g.dart';

@JsonSerializable()
class CheckRequest {
  double? longitude;
  double? latitude;
  @JsonKey(name: 'ip_address')
  String? ipAddress;

  CheckRequest({
    required this.longitude,
    required this.latitude,
    required this.ipAddress,
  });

  factory CheckRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckRequestToJson(this);
}

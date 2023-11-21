import '../error/failure.dart';

enum AudetyeResponseType { success, businessFailure, serverFailure, internetFailure }

class AudetyeResponse {
  final AudetyeResponseType responseType;
  final List<dynamic>? data;
  final Failure? failure;

  AudetyeResponse({required this.responseType, required this.data, required this.failure});
}

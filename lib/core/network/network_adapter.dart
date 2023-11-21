import 'package:audeyta_app/core/domain/response.dart';
import 'package:audeyta_app/core/error/failure.dart';
import 'package:dio/dio.dart';

import '../data/models/response_model.dart';

enum RequestType { get, post }

abstract class NetworkAdapter {
  Future<AudetyeResponseModel> request(RequestType requestType, String endpint, Map<String, dynamic> dat);
}

class APINetworkAdapter implements NetworkAdapter {
  final Dio _dio;
  APINetworkAdapter({required Dio dio}) : _dio = dio;

  @override
  Future<AudetyeResponseModel> request(
      RequestType requestType, String endpint, Map<String, dynamic> queryParameters) async {
    late AudetyeResponseModel response;
    late List<dynamic>? data;
    late Failure? failure;
    late String? message;
    late AudetyeResponseType responseType;
    try {
      final baseURL = "https://dev.minaini.com:2053/r/$endpint";
      late Response dioResponse;

      switch (requestType) {
        case RequestType.get:
          dioResponse = await _dio.get(baseURL, queryParameters: queryParameters);
          break;
        case RequestType.post:
          dioResponse = await _dio.post(baseURL, data: queryParameters);
          break;
      }

      if (dioResponse.statusCode == 200) {
        data = dioResponse.data['results'];
        message = dioResponse.data['message'];
        responseType = AudetyeResponseType.success;
      } else {
        responseType = AudetyeResponseType.businessFailure;
        failure = BusinessFailure(failureMessage: dioResponse.data['message']);
      }
    } catch (e) {
      failure = ServerFailure();
    }

    response = AudetyeResponseModel(data: data, failure: failure, responseType: responseType);

    return response;
  }
}

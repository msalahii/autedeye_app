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
    dynamic data;
    Failure? failure;
    String? message;
    AudetyeResponseType responseType;
    try {
      final baseURL = "https://dev.minaini.com:2053/r/$endpint";
      late Response dioResponse;
      final requestOptions = Options(headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzAwNjU1OTk5LCJpYXQiOjE3MDA1Njk1OTksImp0aSI6IjcxNDYwNjBkZjQ5NTRiYjJhNjVlNTcyOTMwYjAwZTAzIiwidXNlcl9pZCI6Mn0.CtTdoJX1F6OX7o9VDfj15SINye3duzPeZou9YZZWiZA"
      });

      switch (requestType) {
        case RequestType.get:
          dioResponse = await _dio.get(baseURL, queryParameters: queryParameters, options: requestOptions);
          break;
        case RequestType.post:
          dioResponse = await _dio.post(baseURL, data: queryParameters, options: requestOptions);
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
      responseType = AudetyeResponseType.serverFailure;
      failure = ServerFailure();
    }

    return AudetyeResponseModel(data: data, failure: failure, responseType: responseType, message: message);
  }
}

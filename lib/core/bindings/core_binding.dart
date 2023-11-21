import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../network/network_adapter.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    final dio = Dio();
    final dioLogger = PrettyDioLogger(
        requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true);
    dio.interceptors.add(dioLogger);
    Get.lazyPut<NetworkAdapter>(() => APINetworkAdapter(dio: dio));
    Get.put<Connectivity>(Connectivity());
  }
}

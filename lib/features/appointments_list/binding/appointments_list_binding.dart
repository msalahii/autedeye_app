import 'package:audeyta_app/features/appointments_list/data/data_sources/appointments_remote_data_source.dart';
import 'package:audeyta_app/features/appointments_list/domain/repositories/appointments_list_repo_abstraction.dart';
import 'package:get/get.dart';

import '../data/repositories/appointments_list_repo.dart';

class AppointmentsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentsRemoteDataSourceAbstraction>(
        () => AppointmentsRemoteDataSource(apiNetworkAdapter: Get.find()));
    Get.lazyPut<AppointmentsListRepositoryAbstraction>(
        () => AppointmentsListRepository(appointmentsRemoteDataSource: Get.find(), connectivity: Get.find()));
  }
}

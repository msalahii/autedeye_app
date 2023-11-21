import 'package:audeyta_app/core/network/network_adapter.dart';
import 'package:audeyta_app/features/appointments_list/data/models/doctor_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/domain/response.dart';
import '../../../../core/error/failure.dart';

abstract class AppointmentsRemoteDataSourceAbstraction {
  Future<Either<Failure, List<DoctorModel>>> fetchDoctorsList();
}

class AppointmentsRemoteDataSource implements AppointmentsRemoteDataSourceAbstraction {
  final NetworkAdapter _apiNetworkAdapter;

  AppointmentsRemoteDataSource({required NetworkAdapter apiNetworkAdapter}) : _apiNetworkAdapter = apiNetworkAdapter;

  @override
  Future<Either<Failure, List<DoctorModel>>> fetchDoctorsList() async {
    final response = await _apiNetworkAdapter.request(RequestType.get, "appointments", {});
    if (response.responseType == AudetyeResponseType.success) {
      return Right(DoctorModel.decodeList(response.data!));
    } else {
      return Left(response.failure!);
    }
  }
}

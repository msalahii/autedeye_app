import 'package:audeyta_app/core/error/failure.dart';
import 'package:audeyta_app/features/appointments_list/data/data_sources/appointments_remote_data_source.dart';
import 'package:audeyta_app/features/appointments_list/data/models/doctor_model.dart';
import 'package:audeyta_app/features/appointments_list/domain/repositories/appointments_list_repo_abstraction.dart';
import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AppointmentsListRepository implements AppointmentsListRepositoryAbstraction {
  final Connectivity _connectivity;
  final AppointmentsRemoteDataSourceAbstraction _appointmentsRemoteDataSource;

  AppointmentsListRepository(
      {required Connectivity connectivity,
      required AppointmentsRemoteDataSourceAbstraction appointmentsRemoteDataSource})
      : _appointmentsRemoteDataSource = appointmentsRemoteDataSource,
        _connectivity = connectivity;

  @override
  Future<Either<Failure, List<DoctorModel>>> fetchAppointmentsList() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
      return await _appointmentsRemoteDataSource.fetchDoctorsList();
    } else {
      return Left(InternetFailure());
    }
  }
}

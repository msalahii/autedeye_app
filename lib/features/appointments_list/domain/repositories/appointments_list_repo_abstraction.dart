import 'package:audeyta_app/features/appointments_list/data/models/doctor_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

abstract class AppointmentsListRepositoryAbstraction {
  Future<Either<Failure, List<DoctorModel>>> fetchAppointmentsList();
}

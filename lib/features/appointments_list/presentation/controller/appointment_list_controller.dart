import 'package:audeyta_app/core/error/failure.dart';
import 'package:audeyta_app/features/appointments_list/data/data_sources/appointments_remote_data_source.dart';
import 'package:audeyta_app/features/appointments_list/data/models/doctor_model.dart';
import 'package:get/get.dart';
import '../../../../core/mixins/alert_mixin.dart';

enum AppointmentListControllerStates { initialState, loadingState, fetchAppointmentsSuccess, fetchAppointmentsFailed }

class AppointmentsListController extends GetxController with AlertMixin {
  //Dependencies
  final AppointmentsRemoteDataSourceAbstraction _repository;

  AppointmentsListController({required AppointmentsRemoteDataSourceAbstraction repository}) : _repository = repository;

  //Data
  final doctorsList = RxList<DoctorModel>();

  //State Management
  final state = Rx<AppointmentListControllerStates>(AppointmentListControllerStates.initialState);
  final failure = Rx<Failure?>(null);

  @override
  void onReady() {
    fetchAppointments();
  }

  fetchAppointments() {
    if (state.value == AppointmentListControllerStates.loadingState) {
      return;
    } else {
      _fetchAppointmentsAPICall();
    }
  }

  _fetchAppointmentsAPICall() async {
    state.value = AppointmentListControllerStates.loadingState;
    final results = await _repository.fetchDoctorsList();
    results.fold((fetchAppointmentsFailure) {
      state.value = AppointmentListControllerStates.fetchAppointmentsFailed;
      failure.value = fetchAppointmentsFailure;
      showFailureDialog(failure: failure.value!, tryAgain: () => _fetchAppointmentsAPICall());
    }, (success) {
      state.value = AppointmentListControllerStates.fetchAppointmentsSuccess;
      doctorsList.clear();
      doctorsList.addAll(success);
    });
  }
}

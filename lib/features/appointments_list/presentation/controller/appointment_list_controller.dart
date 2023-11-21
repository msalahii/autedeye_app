import 'package:audeyta_app/core/error/failure.dart';
import 'package:get/get.dart';

enum AppointmentListControllerStates { initialState, loadingState, fetchAppointmentsSuccess, fetchAppointmentsFailed }

class AppointmentsListController extends GetxController {
  //Dependencies
  //final _repository;

  //Data
  final appointmentsList = RxList<String>();

  //State Management
  final state = Rx<AppointmentListControllerStates>(AppointmentListControllerStates.initialState);
  final failure = Rx<Failure?>(null);

  fetchAppointments() {}

  _fetchAppointmentsAPICall() async {
    state.value = AppointmentListControllerStates.loadingState;
    final results = await _repository.fetchAppointment();
    results.fold((failure) {
      state.value = AppointmentListControllerStates.fetchAppointmentsFailed;
      this.failure.value = failure;
    }, (success) {
      state.value = AppointmentListControllerStates.fetchAppointmentsSuccess;
      appointmentsList.addAll(success);
    });
  }
}

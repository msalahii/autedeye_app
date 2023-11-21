import 'package:audeyta_app/features/appointments_list/binding/appointments_list_binding.dart';
import 'package:audeyta_app/features/appointments_list/presentation/views/appointment_list_view.dart';
import 'package:get/get.dart';

class AudeyteRoutes {
  static List<GetPage> routesList = [
    GetPage(name: AppointmentListView.routeName, page: () => AppointmentListView(), binding: AppointmentsListBinding()),
  ];
}

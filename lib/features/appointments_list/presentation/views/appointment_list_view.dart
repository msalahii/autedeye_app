import 'package:audeyta_app/features/appointments_list/presentation/controller/appointment_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentListView extends StatelessWidget {
  static const routeName = '/appointmentsList';
  AppointmentListView({super.key});

  final controller = Get.put(AppointmentsListController(repository: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: Obx(
        () => controller.state.value == AppointmentListControllerStates.loadingState
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.doctorsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.doctorsList[index].doctorName),
                    subtitle: Text(controller.doctorsList[index].doctorID.toString()),
                  );
                }),
      ),
    );
  }
}

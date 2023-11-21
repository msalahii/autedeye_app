import 'package:audeyta_app/core/bindings/core_binding.dart';
import 'package:audeyta_app/core/routing/route_generator.dart';
import 'package:audeyta_app/features/appointments_list/presentation/views/appointment_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const AudeteyeApp());
}

class AudeteyeApp extends StatelessWidget {
  const AudeteyeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Audetye App',
      getPages: AudeyteRoutes.routesList,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: CoreBinding(),
      initialRoute: AppointmentListView.routeName,
    );
  }
}

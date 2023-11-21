import '../../domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel({required super.doctorID, required super.doctorName});

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      doctorID: json['id'],
      doctorName: json['doctor']['user']['name'],
    );
  }

  static List<DoctorModel> decodeList(List<dynamic> json) => json.map((e) => DoctorModel.fromJson(e)).toList();
}

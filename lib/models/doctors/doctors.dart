/// doctors : [{"experience":4,"name":"Ivan Ivanov"},{"experience":3,"name":"Petr Petrov"},{"experience":7,"name":"Lebedev Max"}]

class DoctorsList {
  List<Doctors>? _doctors;

  List<Doctors>? get doctors => _doctors;

  DoctorsList({
      List<Doctors>? doctors}){
    _doctors = doctors;
}

  DoctorsList.fromJson(dynamic json) {
      _doctors = [];
      json.forEach((v) {
        _doctors?.add(Doctors.fromJson(v));
      });
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_doctors != null) {
      map['doctors'] = _doctors?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// experience : 4
/// name : "Ivan Ivanov"

class Doctors {
  int? _experience;
  String? _name;

  int? get experience => _experience;
  String? get name => _name;

  Doctors({
      int? experience,
      String? name}){
    _experience = experience;
    _name = name;
}

  Doctors.fromJson(dynamic json) {
    _experience = json['experience'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['experience'] = _experience;
    map['name'] = _name;
    return map;
  }

}
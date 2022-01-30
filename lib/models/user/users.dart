class UsersList {
  List<Users>? _users;

  List<Users>? get users => _users;

  UsersList({
      List<Users>? users}){
    _users = users;
}

  UsersList.fromJson(Map<dynamic, dynamic> json) {
      _users = [];
      json.forEach((v, _) {
        _users?.add(Users.fromJson(_));
      });
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_users != null) {
      map['users'] = _users?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Users {
  bool? _admin;
  String? _dateOfBirth;
  String? _email;
  String? _name;
  String? _lastName;
  String? _passport;
  String? _password;
  String? _patronymic;
  String? _registrationDate;
  String? _uid;

  bool? get admin => _admin;
  String? get dateOfBirth => _dateOfBirth;
  String? get email => _email;
  String? get name => _name;
  String? get lastName => _lastName;
  String? get passport => _passport;
  String? get password => _password;
  String? get patronymic => _patronymic;
  String? get registrationDate => _registrationDate;
  String? get uid => _uid;

  Users({
    bool? admin,
    String? dateOfBirth,
    String? email,
    String? name,
    String? lastName,
    String? passport,
    String? password,
    String? patronymic,
    String? registrationDate,
    String? uid}){
    _admin = admin;
    _dateOfBirth = dateOfBirth;
    _email = email;
    _name = name;
    _lastName = lastName;
    _passport = passport;
    _password = password;
    _patronymic = patronymic;
    _registrationDate = registrationDate;
    _uid = uid;
}

  Users.fromJson(dynamic json) {
    _admin = json['admin'];
    _dateOfBirth = json['dateOfBirth'];
    _email = json['email'];
    _name = json['name'];
    _lastName = json['lastName'];
    _passport = json['passport'];
    _password = json['password'];
    _patronymic = json['patronymic'];
    _registrationDate = json['registration date'];
    _uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['admin'] = _admin;
    map['dateOfBirth'] = _dateOfBirth;
    map['email'] = _email;
    map['name'] = _name;
    map['lastName'] = _lastName;
    map['passport'] = _passport;
    map['password'] = _password;
    map['patronymic'] = _patronymic;
    map['registration date'] = _registrationDate;
    map['uid'] = _uid;
    return map;
  }

}
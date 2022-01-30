class MessagesList {
  MessagesList({
      List<Messages>? messages, 
      String? user1, 
      String? user2,}){
    _messages = messages;
    _user1 = user1;
    _user2 = user2;
}

  MessagesList.fromJson(dynamic json) {
    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
        if(v != null) {
          _messages?.add(Messages.fromJson(v));
        }
      });
    }
    _user1 = json['user1'];
    _user2 = json['user2'];
  }
  List<Messages>? _messages;
  String? _user1;
  String? _user2;

  List<Messages>? get messages => _messages;
  String? get user1 => _user1;
  String? get user2 => _user2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_messages != null) {
      map['messages'] = _messages?.map((v) => v.toJson()).toList();
    }
    map['user1'] = _user1;
    map['user2'] = _user2;
    return map;
  }

}

class Messages {
  Messages({
      String? date , 
      String? mes, 
      String? sender,}){
    _date  = date ;
    _mes = mes;
    _sender = sender;
}

  Messages.fromJson(dynamic json) {
    _date  = json['date'];
    _mes = json['mes'];
    _sender = json['sender'];
  }
  String? _date ;
  String? _mes;
  String? _sender;

  String? get date  => _date ;
  String? get mes => _mes;
  String? get sender => _sender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date ;
    map['mes'] = _mes;
    map['sender'] = _sender;
    return map;
  }

}
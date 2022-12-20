class Messages {
  Messages({
    required this.toId,
    required this.msg,
    required this.read,

    required this.sent,
    required this.fromId,
  });
  late final String toId;
  late final String msg;
  late final String read;
  late final String sent;
  late final String fromId;

  Messages.fromJson(Map<String, dynamic> json){
    toId = json['toId'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    sent = json['sent'].toString();
    fromId = json['fromId'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['msg'] = msg;
    data['read'] = read;
    data['sent'] = sent;
    data['fromId'] = fromId;
    return data;
  }
}

enum Type{ text, image}
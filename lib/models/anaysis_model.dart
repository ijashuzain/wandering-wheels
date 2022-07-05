class Analysis {
  DateTime invokeTime;
  String title;
  String content;
  String type;

  Analysis({
    required this.type,
    required this.content,
    required this.invokeTime,
    required this.title,
  });

  Analysis.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        invokeTime = json["invokeTime"],
        content = json['content'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
        'title': type,
        'invokeTime': invokeTime,
        'type': type,
        'content': content,
      };
}

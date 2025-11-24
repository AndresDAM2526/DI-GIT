class Note {
  String title;
  String content;

  Note({required this.title, required this.content});

  Map<String, String> toJson() => {'title': title, 'content': content};

  factory Note.fromJson(Map<String, dynamic> json) =>
      Note(title: json['title'], content: json['content']);
}

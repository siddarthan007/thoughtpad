class Thought {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;

  const Thought(
      {this.id,
      required this.title,
      required this.content,
      required this.createdAt});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'createdAt': createdAt.toString()
      };
}

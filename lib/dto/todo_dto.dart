class TodoDTO {
  final int userId;
  final String title;
  final bool completed;
  final DateTime createdAt;

  TodoDTO({
    required this.userId,
    required this.title,
    required this.createdAt,
    bool complete = false,
  }) : completed = complete;

  TodoDTO.fromJson(Map<String, dynamic> json)
    : userId = json['userId'],
      title = json['title'],
      completed = json['completed'],
      createdAt = DateTime.parse(json['createdAt']);
}

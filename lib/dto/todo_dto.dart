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
}

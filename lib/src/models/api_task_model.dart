class ApiTask {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  ApiTask({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory ApiTask.fromJson(Map<String, dynamic> json) {
    return ApiTask(
      id: json['id'],
      userId: json['userId'],
      title: json['title'] ?? '',
      completed: json['completed'] ?? false,
    );
  }
}
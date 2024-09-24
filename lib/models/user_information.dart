class UserInformation {
  int userId;
  int id;
  String title;
  bool completed;

  UserInformation({required this.userId, required this.id, required this.title, required this.completed});

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}
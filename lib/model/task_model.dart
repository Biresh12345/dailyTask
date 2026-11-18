class Taskmodel {
  final int id;
  final String title;
  final bool isCompleted;

  Taskmodel({required this.id, required this.title, required this.isCompleted});

  factory Taskmodel.fromJson(Map<String, dynamic> json) {
    return Taskmodel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted};
  }
}

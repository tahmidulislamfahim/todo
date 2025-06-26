class Task {
  String title;
  String description;
  String date;
  String time;
  bool isDone; // ✅ Add this

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.isDone = false,
  });

  // Convert a Task to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'isDone': isDone,
    };
  }

  // Create a Task from a JSON map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      isDone: json['isDone'] ?? false,
    );
  }
}

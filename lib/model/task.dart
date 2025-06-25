class Task {
  String title;
  String description;
  String date;
  String time;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
  });

  // Convert a Task to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
    };
  }

  // Create a Task from a JSON map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
    );
  }
}

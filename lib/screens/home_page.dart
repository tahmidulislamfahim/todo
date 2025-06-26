import 'dart:convert';
import 'package:doable_todo_list_app/model/task.dart';
import 'package:doable_todo_list_app/screens/add_task_page.dart';
import 'package:doable_todo_list_app/screens/edit_task_page.dart';
import 'package:doable_todo_list_app/screens/settings_page.dart';
import 'package:doable_todo_list_app/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');

    if (tasksString != null) {
      final List decoded = json.decode(tasksString);
      setState(() {
        tasks = decoded.map((e) => Task.fromJson(e)).toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(tasks.map((t) => t.toJson()).toList());
    await prefs.setString('tasks', encoded);
  }

  void _navigateToAddTaskPage() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskPage()),
    );

    if (newTask != null && newTask is Task) {
      setState(() {
        tasks.add(newTask);
      });
      _saveTasks();
    }
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    _saveTasks();
  }

  bool isTaskExpired(Task task) {
    try {
      final date = DateTime.parse(task.date);
      final timeParts = task.time.split(':');
      int hour = int.tryParse(timeParts[0]) ?? 0;
      int minute = int.tryParse(timeParts[1].split(' ')[0]) ?? 0;

      if (task.time.toLowerCase().contains('pm') && hour != 12) {
        hour += 12;
      } else if (task.time.toLowerCase().contains('am') && hour == 12) {
        hour = 0;
      }

      final taskDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        hour,
        minute,
      );

      return taskDateTime.isBefore(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SvgPicture.asset("assets/images/trans_logo.svg"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTaskPage,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: tasks.isEmpty
                    ? const Center(
                        child: Text(
                          "No tasks yet. Tap + to add a task!",
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          final expired = isTaskExpired(task);

                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: IconButton(
                                icon: Icon(
                                  task.isDone
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: task.isDone
                                      ? Colors.green
                                      : (expired ? Colors.redAccent : null),
                                ),
                                onPressed: () {
                                  setState(() {
                                    task.isDone = !task.isDone;
                                  });
                                  _saveTasks();
                                },
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(
                                expired
                                    ? '[EXPIRED] ${task.title}'
                                    : task.title,
                                style: TextStyle(
                                  decoration: expired
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: expired ? Colors.redAccent : null,
                                ),
                              ),
                              subtitle: Text(
                                '${task.date} • ${task.time}\n${task.description}',
                                style: TextStyle(
                                  color: expired ? Colors.redAccent : null,
                                ),
                              ),
                              isThreeLine: true,
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit_outlined),
                                    onPressed: () async {
                                      final updatedTask = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditTaskPage(task: task),
                                        ),
                                      );

                                      if (updatedTask != null &&
                                          updatedTask is Task) {
                                        setState(() {
                                          tasks[index] = updatedTask;
                                        });
                                        _saveTasks();
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () => _deleteTask(index),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const Spacing(),
            ],
          ),
        ),
      ),
    );
  }
}

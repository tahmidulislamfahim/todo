import 'package:doable_todo_list_app/model/task.dart';
import 'package:doable_todo_list_app/widgets/back_arrow.dart';
import 'package:doable_todo_list_app/widgets/set_reminder.dart';
import 'package:doable_todo_list_app/widgets/small_spacing.dart';
import 'package:doable_todo_list_app/widgets/spacing.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String _titleValue = '';
  String _descriptionValue = '';
  String _dateValue = '';
  String _timeValue = '';

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const BackArrow(),
                    Text(
                      "Create to-do",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
                const Spacing(),
                const SetReminder(),
                const Spacing(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tell us about your task",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                const SmallSpacing(),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    prefixIcon: const Icon(Icons.title_outlined),
                    hintText: "Title",
                  ),
                  onChanged: (value) {
                    setState(() {
                      _titleValue = value;
                    });
                  },
                ),
                const SmallSpacing(),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    prefixIcon: const Icon(Icons.description_outlined),
                    hintText: "Description",
                  ),
                  onChanged: (value) {
                    setState(() {
                      _descriptionValue = value;
                    });
                  },
                ),
                const Spacing(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Date & Time",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    prefixIcon: const Icon(Icons.calendar_month_outlined),
                    hintText: "Select Date",
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 5),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      setState(() {
                        dateController.text = formattedDate;
                        _dateValue = formattedDate;
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: timeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    prefixIcon: const Icon(Icons.access_time_outlined),
                    hintText: "Select Time",
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      final now = TimeOfDay.now();

                      final nowMinutes = now.hour * 60 + now.minute;
                      final pickedMinutes =
                          pickedTime.hour * 60 + pickedTime.minute;

                      if (pickedMinutes <= nowMinutes) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a future time"),
                          ),
                        );
                        return;
                      }

                      final formattedTime = pickedTime.format(context);
                      setState(() {
                        timeController.text = formattedTime;
                        _timeValue = formattedTime;
                      });
                    }
                  },
                ),

                const Spacing(),
                ElevatedButton(
                  onPressed: () {
                    if (_titleValue.isNotEmpty &&
                        _descriptionValue.isNotEmpty &&
                        _dateValue.isNotEmpty &&
                        _timeValue.isNotEmpty) {
                      final newTask = Task(
                        title: _titleValue,
                        description: _descriptionValue,
                        date: _dateValue,
                        time: _timeValue,
                      );

                      Navigator.pop(context, newTask);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all required fields"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    fixedSize: const Size(200, 50),
                    shadowColor: Colors.white,
                  ),
                  child: const Text(
                    "Create",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }
}

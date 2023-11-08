import 'package:flutter/material.dart';
import 'package:projet/Widgets/new_task.dart';
import 'package:projet/models/task.dart';
import 'package:projet/services/firestore.dart';
import 'package:projet/tasks_list.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService = FirestoreService();
  final List<Task> _registeredTasks = [
    

    
  ];
  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(onAddTask: _addTask),
    );
  }

  void _addTask(Task task) {
    setState(() {
      _registeredTasks.add(task);
      firestoreService.addTask(task);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('ToDoList'),
        ),
        actions: [
          IconButton(
              onPressed: _openAddTaskOverlay,
              icon: Ink(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 143, 143, 193)),
                  child: const Padding(
                      padding: EdgeInsets.all(10), child: Icon(Icons.add)))),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: TasksList(tasks: _registeredTasks)),
          ],
        ),
      ),
    );
  }
}

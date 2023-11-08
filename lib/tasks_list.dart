import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet/models/task.dart';
import 'package:projet/services/firestore.dart';
import 'package:projet/widgets/task_item.dart';

class TasksList extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();
  final List<Task> tasks;

  TasksList({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final taskLists = snapshot.data!.docs;
          List<Task> taskItems = [];

          for (int index = 0; index < taskLists.length; index++) {
            DocumentSnapshot document = taskLists[index];
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String title =
                data['taskTitle'] ?? ''; // Handle potential null value
            String description =
                data['taskDesc'] ?? ''; // Handle potential null value
            DateTime date = data['taskDate'] != null
                ? DateTime.parse(data['taskDate'])
                : DateTime.now(); // Handle potential null value
            String categoryString = data['taskCategory'];
            String id = data['id'];
            bool completed = data['completed'];
            Category category;
            switch (categoryString) {
              case 'Category.personal':
                category = Category.personal;
                break;
              case 'Category.work':
                category = Category.work;
                break;
              case 'Category.shopping':
                category = Category.shopping;
                break;
              default:
                category = Category.others;
            }

            Task task = Task(
              title: title,
              description: description,
              date: date,
              category: category,
              completed: completed,
            );
            task.setId(id);

            taskItems.add(task);
          }

          taskItems.sort((a, b) => a.completed ? 1 : -1);

          return ListView.builder(
            itemCount: taskItems.length,
            itemBuilder: (ctx, index) {
              return TaskItem(taskItems[index]);
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

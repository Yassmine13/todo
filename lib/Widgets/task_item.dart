import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';
import 'package:projet/services/firestore.dart';

class TaskItem extends StatelessWidget {
  final Task task;

   const TaskItem(this.task,{super.key}); 

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();
    return Card(
      margin: EdgeInsets.all(16.0),
      color: task.completed ?  Colors.grey : null, 
      child: Column( 
        children: [
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Checkbox(
              value: task.completed,
              onChanged: (value) {
                firestoreService.toggleTaskCompletion(task);
              },
            ),
                
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title, style: TextStyle(fontWeight: FontWeight.bold,
                       decoration: task.completed ? TextDecoration.lineThrough : null, 
                       ),

                      ),
                      SizedBox(height: 5),
                      Text(task.description, style: TextStyle(fontWeight: FontWeight.bold,
                       decoration: task.completed ? TextDecoration.lineThrough : null, 
                       ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${DateFormat('dd/MM/yyyy').format(task.date)}',
                        textAlign: TextAlign.left,
                      ),
                      
                      SizedBox(height: 5),
                      Text(
                        'Category: ${task.category.name}',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    firestoreService.deleteTask(task);
                  },
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}





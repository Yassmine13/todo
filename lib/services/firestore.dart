import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(Task task) {
    return tasks.add({
      'taskTitle': task.title.toString(),
      'taskDesc': task.description.toString(),
      'taskCategory': task.category.toString(),
      'id': task.id.toString(),
      'completed': task.completed,
    });
  }

  Stream<QuerySnapshot> getTasks() {
    final taskStream = tasks.snapshots();
    return taskStream;
  }

  Future<void> deleteTask(Task task) async {
    final String taskId = task.id;
    final QuerySnapshot idQuery =
        await tasks.where('id', isEqualTo: taskId).get();

    if (idQuery.docs.isNotEmpty) {
      final taskDoc = idQuery.docs.first;
      await taskDoc.reference.delete();
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final String taskId = task.id;
    final QuerySnapshot idQuery =await tasks.where('id', isEqualTo: taskId).get();
    if (idQuery.docs.isNotEmpty) {
      final taskDoc = idQuery.docs.first;
      final currentCompletedValue = taskDoc.get('completed') ?? false;
      await taskDoc.reference.update({'completed': !currentCompletedValue});
    }
  }
}

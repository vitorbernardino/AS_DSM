import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String uid;

  DatabaseService(this.uid);

  CollectionReference get _tasksRef => 
      _db.collection('users').doc(uid).collection('tasks');

  Stream<List<Task>> get tasks {
    return _tasksRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Task.fromFirestore(doc))
            .toList());
  }

  Future<void> addTask(String title) async {
    await _tasksRef.add({
      'title': title,
      'isDone': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> toggleTask(String taskId, bool currentStatus) async {
    await _tasksRef.doc(taskId).update({'isDone': !currentStatus});
  }

  Future<void> deleteTask(String taskId) async {
    await _tasksRef.doc(taskId).delete();
  }
}

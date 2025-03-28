import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getTareitas() async {
  List tasks = [];
  CollectionReference collenctionTasks = db.collection('tasks');
  QuerySnapshot snapshot = await collenctionTasks.get();
  for (var document in snapshot.docs) {
    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final task = {
      'id': document.id,
      'title': data['title'],
      'description': data['description'],
      'status': data['status'],
    };
    print(task);
    tasks.add(task);
  }
  return tasks;
}

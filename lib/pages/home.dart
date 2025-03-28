import 'package:firebase_app/services/task.firebase.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> futureTareitas;
  @override
  void initState() {
    super.initState();
    futureTareitas = getTareitas();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      appBar: AppBar(title: Text('Lista de Tareas')),
      body: FutureBuilder(
        future: futureTareitas,
        builder: (context, resp) {
          if (resp.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (resp.hasError) {
            return Center(child: Text('Ocurrio un error ${resp.error}'));
          } else if (resp.hasData) {
            return ListView.builder(
              itemCount: resp.data?.length,
              itemBuilder: (context, index) {
                var task = resp.data![index];
                return TaskTile(
                  title: task['title'],
                  description: task['description'],
                  status: task['status'],
                );
              },
            );
          } else {
            return Center(child: Text('No hay tareas'));
          }
        },
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final String title;
  final String description;
  final int status;
  const TaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: Icon(Icons.close, color: const Color.fromARGB(255, 255, 7, 7)),
    );
  }
}

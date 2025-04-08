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

  void refreshTareitas() {
    setState(() {
      futureTareitas = getTareitas();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.pushNamed(context, '/counter');
          refreshTareitas();
        },
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
                  id: task['id'],
                  title: task['title'],
                  description: task['description'],
                  status: task['status'],
                  onDelete: refreshTareitas,
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
  final String id;
  final String title;
  final String description;
  final int status;
  final VoidCallback onDelete;
  const TaskTile({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: FloatingActionButton(
        child: Icon(Icons.delete, color: const Color.fromARGB(255, 255, 7, 7)),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Estas Seguro?'),
                actions: [
                  TextButton(
                    child: Text('Eliminar'),
                    onPressed: () {
                      deleteTask(id);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

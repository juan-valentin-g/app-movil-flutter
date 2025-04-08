import 'package:firebase_app/services/task.firebase.dart';
import 'package:flutter/material.dart';

class Newtask extends StatefulWidget {
  const Newtask({super.key});

  @override
  State<Newtask> createState() => _NewtaskState();
}

class _NewtaskState extends State<Newtask> {
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: Form(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Titulo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Descripcion',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await saveTask(
                      titleController.text,
                      descriptionController.text,
                    ).then((_) {
                      Navigator.pop(context);
                    });
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

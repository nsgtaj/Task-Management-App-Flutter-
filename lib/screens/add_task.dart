import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_practice/bloc/task_bloc/task_bloc.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _title,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Title',
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        if (_title.text.isNotEmpty) {
                          context.read<TaskBloc>().add(
                                AddTodo(
                                  title: _title.text,
                                  isImportant: true,
                                  number: 0,
                                  description: '',
                                  createdTime: DateTime.now(),
                                ),
                              );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text("Task added successfully"),
                          ));
                          context.read<TaskBloc>().add(const FetchTodos());
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Title must not be blank".toUpperCase()),
                          ));
                        }
                      },
                      child: const Text('Submit'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc/task_bloc.dart';
import 'add_task.dart';
import 'details_page.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => TaskListState();
}



class TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Task'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.black87,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const AddTaskPage()));
        },
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is CrudInitial) {
            context.read<TaskBloc>().add(const FetchTodos());
          }
          if (state is DisplayTodos) {
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height,
                child: Column(children: [

                  const SizedBox(
                    height: 10,
                  ),
                  state.todo.isNotEmpty
                      ? Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(8),
                      itemCount: state.todo.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            context.read<TaskBloc>().add(
                                FetchSpecificTodo(id: state.todo[i].id!));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) =>
                                const DetailsPage()),
                              ),
                            );
                          },
                          child: Container(
                            height: 80,
                            margin: const EdgeInsets.only(bottom: 14),
                            child: Card(
                              elevation: 10,
                              color: Colors.blue,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      state.todo[i].title.toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              context
                                                  .read<TaskBloc>()
                                                  .add(DeleteTodo(
                                                  id: state
                                                      .todo[i].id!));
                                              ScaffoldMessenger.of(
                                                  context)
                                                  .showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    content:
                                                    Text("deleted todo"),
                                                  ));
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                      : const Text(''),
                ]),
              ),
            );
          }
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_practice/bloc/task_bloc/task_bloc.dart';
import 'package:sqflite_practice/presentation/constants/colors.dart';
 import '../data/models/todo.dart';
 import '../presentation/constants/styles.dart';
import '../widgets/custom_text.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController _newTitle = TextEditingController();
  final TextEditingController _newDescription = TextEditingController();
  bool toggleSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            context.read<TaskBloc>().add(const FetchTodos());
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is DisplaySpecificTodo) {
              Todo currentTodo = state.todo;

              return Column(
                children: [
                  CustomText(text: 'title'.toUpperCase()),
                  const SizedBox(height: 10),
                  TextFormField(
                      initialValue: currentTodo.title, enabled: false),
                  const SizedBox(height: 10),
                  CustomText(text: 'date made'.toUpperCase()),
                  const SizedBox(height: 10),
                  CustomText(
                      text: DateFormat.yMMMEd().format(state.todo.createdTime)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext cx) {
                              return StatefulBuilder(
                                builder: ((context, setState) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Update Todo',
                                      style: TextStyle(
                                          fontSize: 25,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Align(
                                            alignment: Alignment.topLeft,
                                            child: Text('Title')),
                                        Flexible(
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              isDense: true,
                                            ),
                                            maxLines: 1,
                                            controller: _newTitle,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: Styles.customButtonStyle,
                                        onPressed: () {
                                          Navigator.pop(cx);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        style: Styles.customButtonStyle,
                                        onPressed: () async {
                                          context.read<TaskBloc>().add(
                                                UpdateTodo(
                                                  todo: Todo(
                                                    id: currentTodo.id,
                                                    createdTime: DateTime.now(),
                                                    description:
                                                        _newDescription.text,
                                                    isImportant: toggleSwitch,
                                                    number: currentTodo.number,
                                                    title: _newTitle.text,
                                                  ),
                                                ),
                                              );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            duration: Duration(seconds: 1),
                                            content:
                                                Text('Todo details updated'),
                                          ));
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                          context
                                              .read<TaskBloc>()
                                              .add(const FetchTodos());
                                        },
                                        child: const Text('Update'),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            });
                      },
                      child: const Text('Update'))
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

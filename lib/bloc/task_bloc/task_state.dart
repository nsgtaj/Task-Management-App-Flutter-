part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class CrudInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class DisplayTodos extends TaskState {
  final List<Todo> todo;

  const DisplayTodos({required this.todo});
  @override
  List<Object> get props => [todo];
}

class DisplaySpecificTodo extends TaskState {
  final Todo todo;

  const DisplaySpecificTodo({required this.todo});
  @override
  List<Object> get props => [todo];
}

part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class AddTodo extends TaskEvent {
  final String title;
  final bool isImportant;
  final int number;
  final String description;
  final DateTime createdTime;

  const AddTodo(
      {required this.title,
      required this.isImportant,
      required this.number,
      required this.description,
      required this.createdTime});

  @override
  List<Object?> get props =>
      [title, isImportant, number, description, createdTime];
}

class UpdateTodo extends TaskEvent {
  final Todo todo;
  const UpdateTodo({required this.todo});
  @override
  List<Object?> get props => [todo];
}

class FetchTodos extends TaskEvent {
  const FetchTodos();

  @override
  List<Object?> get props => [];
}

class FetchSpecificTodo extends TaskEvent {
  final int id;
  const FetchSpecificTodo({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteTodo extends TaskEvent {
  final int id;
  const DeleteTodo({required this.id});
  @override
  List<Object?> get props => [id];
}

import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final String description;
  bool? isCompleted;
  bool? isCancelled;

  Todo({
    required this.id,
    required this.task,
    required this.description,
    this.isCompleted = false,
    this.isCancelled = false,
  });

  Todo copyWith({
    String? id,
    String? task,
    String? description,
    bool? isCompleted,
    bool? isCancelled,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isCancelled: isCancelled ?? this.isCancelled,
    );
  }

  @override
  List<Object?> get props => [
        id,
        task,
        description,
        isCompleted,
        isCancelled,
      ];

  // static List<Todo> todos = [
  //   Todo(
  //     id: '1',
  //     task: 'Sample Task 1',
  //     description: "Test task 1",
  //   ),
  //   Todo(
  //     id: '2',
  //     task: 'Sample Task 2',
  //     description: "Test task 2",
  //   ),
  // ];
}

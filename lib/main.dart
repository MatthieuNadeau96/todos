import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/blocs/todos/todos_bloc.dart';
import 'package:todos/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:todos/models/todo_model.dart';
import 'package:todos/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()
            ..add(
              LoadTodos(todos: [
                Todo(
                  id: '1',
                  task: 'Sample Task 1',
                  description: "Test task 1",
                  isCompleted: false,
                  isCancelled: false,
                ),
                Todo(
                  id: '2',
                  task: 'Sample Task 2',
                  description: "Test task 2",
                  isCompleted: false,
                  isCancelled: false,
                ),
              ]),
            ),
        ),
        BlocProvider(
          create: (context) => TodosFilterBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

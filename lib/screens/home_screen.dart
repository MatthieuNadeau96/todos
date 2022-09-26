import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/blocs/todos/todos_bloc.dart';
import 'package:todos/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:todos/models/todo_model.dart';
import 'package:todos/models/todos_filter_model.dart';
import 'package:todos/screens/add_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Todos'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTodoScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
          bottom: TabBar(
            onTap: (tabIndex) {
              switch (tabIndex) {
                case 0:
                  BlocProvider.of<TodosFilterBloc>(context).add(
                    const UpdateTodos(todosFilter: TodosFilter.pending),
                  );
                  break;
                case 1:
                  BlocProvider.of<TodosFilterBloc>(context).add(
                    const UpdateTodos(todosFilter: TodosFilter.completed),
                  );
                  break;
              }
            },
            tabs: const [
              Tab(
                icon: Icon(Icons.pending),
              ),
              Tab(
                icon: Icon(Icons.add_task),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          _todosBuilder('Pending Todos'),
          _todosBuilder('Completed Todos'),
        ]),
      ),
    );
  }

  BlocConsumer<TodosFilterBloc, TodosFilterState> _todosBuilder(
      String headerText) {
    return BlocConsumer<TodosFilterBloc, TodosFilterState>(
      listener: (context, state) {
        if (state is TodosFilterLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(
                'There is ${state.filteredTodos.length} Todos in your ${state.todosFilter.toString().split('.').last} list',
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        print('----> ${state}');
        if (state is TodosFilterLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TodosFilterLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Text(
                      headerText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.filteredTodos.length,
                  itemBuilder: ((context, index) {
                    return _todoCard(context, state.filteredTodos[index]);
                  }),
                ),
              ],
            ),
          );
        } else {
          return const Text('Something went wrong...');
        }
      },
    );
  }

  Card _todoCard(BuildContext context, Todo todo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '#${todo.id}: ${todo.task}',
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(
                          UpdateTodo(
                            todo: todo.copyWith(isCompleted: true),
                          ),
                        );
                  },
                  icon: const Icon(Icons.check),
                ),
                IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(
                          DeleteTodo(todo: todo),
                        );
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

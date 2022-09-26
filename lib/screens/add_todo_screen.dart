import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/blocs/todos/todos_bloc.dart';
import 'package:todos/models/todo_model.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add a new task'),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Task Added!")));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _inputField('ID', controllerId),
              _inputField('Task', controllerTask),
              _inputField('Description', controllerDescription),
              ElevatedButton(
                onPressed: () {
                  var todo = Todo(
                    id: controllerId.value.text,
                    task: controllerTask.value.text,
                    description: controllerDescription.value.text,
                  );
                  context.read<TodosBloc>().add(
                        AddTodo(todo: todo),
                      );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text('Add Task'),
              )
            ],
          ),
        ),
      ),
    );
  }

  _inputField(String field, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field: ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          child: TextFormField(
            controller: controller,
          ),
        ),
      ],
    );
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/models/todo_model.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodos);
    on<UpdateTodo>(_onUpdateTodos);
    on<DeleteTodo>(_onDeleteTodos);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) {}

  void _onAddTodos(AddTodo event, Emitter<TodosState> emit) {}

  void _onUpdateTodos(UpdateTodo event, Emitter<TodosState> emit) {}

  void _onDeleteTodos(DeleteTodo event, Emitter<TodosState> emit) {}
}

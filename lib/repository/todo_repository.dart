import 'package:dart_todo/dto/todo_dto.dart';
import 'package:dart_todo/model/todo.dart';
import 'package:dart_todo/repository/repository.dart';

abstract interface class TodoRepository
    implements Repository<Todo, int, TodoDTO> {
  @override
  Future<Todo> create(TodoDTO todo);

  @override
  Future<List<Todo>> findAll();

  @override
  Future<Todo?> findOne(int id);

  Future<List<Todo>> findByTitle(String title);

  Future<List<Todo>> findByCompleted(bool completed);
}

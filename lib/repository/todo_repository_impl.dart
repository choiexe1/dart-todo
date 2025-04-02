import 'package:dart_todo/data_source/dsource.dart';
import 'package:dart_todo/dto/todo_dto.dart';
import 'package:dart_todo/model/todo.dart';
import 'package:dart_todo/repository/todo_repository.dart';

class TodoFileRepositoryImpl implements TodoRepository {
  final JsonFileDataSource<Todo> _dataSource;

  const TodoFileRepositoryImpl(this._dataSource);

  @override
  Future<List<Todo>> findByCompleted(bool completed) async {
    List<Todo> todos = await findAll();
    return todos.where((e) => e.completed == completed).toList();
  }

  @override
  Future<List<Todo>> findByTitle(String title) async {
    List<Todo> todos = await findAll();
    return todos.where((e) => e.title == title).toList();
  }

  @override
  Future<Todo> create(TodoDTO dto) async {
    List<Map<String, dynamic>> data = await _dataSource.fetch();
    int id = await _dataSource.sequence();

    Todo todo = Todo(
      id: id,
      title: dto.title,
      userId: dto.userId,
      createdAt: dto.createdAt,
      completed: dto.completed,
    );

    data.add(todo.toJson());
    await _dataSource.save(data);

    return todo;
  }

  @override
  Future<List<Todo>> findAll() async {
    List<Map<String, dynamic>> data = await _dataSource.fetch();

    return data.map((e) => Todo.fromJson(e)).toList();
  }

  @override
  Future<Todo?> findOne(int id) async {
    List<Map<String, dynamic>> data = await _dataSource.fetch();

    return data
        .map((e) => Todo.fromJson(e))
        .where((e) => e.id == id)
        .firstOrNull;
  }
}

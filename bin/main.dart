import 'package:dart_todo/controller/todo_controller.dart';
import 'package:dart_todo/controller/todo_controller_impl.dart';
import 'package:dart_todo/data_source/json_file_data_source.dart';
import 'package:dart_todo/injector.dart';
import 'package:dart_todo/model/todo.dart';
import 'package:dart_todo/repository/todo_file_repository_impl.dart';
import 'package:dart_todo/repository/todo_repository.dart';
import 'package:dart_todo/web_server.dart';

void main(List<String> arguments) async {
  register();

  final server = await WebServer.run(port: 8080);
  TodoController todoController = injector.get<TodoController>();

  server.get(
    '/todos',
    (request) async => await todoController.getTodos(request),
  );

  server.post(
    '/todos',
    (request) async => await todoController.create(request),
  );
}

void register() {
  injector
    ..addInstance<JsonFileDataSource<Todo>>(
      JsonFileDataSource<Todo>('data/backup.dat'),
    )
    ..addInstance<TodoRepository>(
      TodoFileRepositoryImpl(injector.get<JsonFileDataSource<Todo>>()),
    )
    ..addInstance<TodoController>(
      TodoControllerImpl(injector.get<TodoRepository>()),
    )
    ..commit();
}

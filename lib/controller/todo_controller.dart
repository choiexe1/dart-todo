import 'dart:io';

abstract interface class TodoController {
  Future<void> getTodos(HttpRequest request);
  Future<void> create(HttpRequest request);
}

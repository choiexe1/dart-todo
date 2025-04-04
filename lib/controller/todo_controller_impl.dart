import 'dart:convert';
import 'dart:io';

import 'package:dart_todo/controller/todo_controller.dart';
import 'package:dart_todo/dto/todo_dto.dart';
import 'package:dart_todo/model/todo.dart';
import 'package:dart_todo/repository/todo_repository.dart';

class TodoControllerImpl implements TodoController {
  final TodoRepository _repository;

  TodoControllerImpl(this._repository);

  @override
  Future<void> getTodos(HttpRequest request) async {
    request.response
      ..statusCode = HttpStatus.ok
      ..write(await _repository.findAll())
      ..close();
  }

  @override
  Future<void> create(HttpRequest request) async {
    final String body = await utf8.decoder.bind(request).join();
    final Map<String, dynamic> json = jsonDecode(body);

    try {
      final dto = TodoDTO.fromJson(json);

      Todo todo = await _repository.create(dto);

      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.json
        ..write(jsonEncode({'success': true, 'result': todo}))
        ..close();
    } catch (e) {
      request.response
        ..statusCode = HttpStatus.badRequest
        ..headers.contentType = ContentType.json
        ..write(jsonEncode({'error': '올바른 JSON 형식이 아니거나, 유효하지 않은 데이터입니다.'}))
        ..close();
    }
  }
}

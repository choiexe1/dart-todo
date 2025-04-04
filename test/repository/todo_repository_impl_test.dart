import 'package:dart_todo/data_source/json_file_data_source.dart';
import 'package:dart_todo/dto/todo_dto.dart';
import 'package:dart_todo/model/todo.dart';
import 'package:dart_todo/repository/todo_file_repository_impl.dart';
import 'package:dart_todo/repository/todo_repository.dart';
import 'package:test/test.dart';

void main() {
  const TodoRepository repository = TodoFileRepositoryImpl(
    JsonFileDataSource<Todo>('data/backup.dat'),
  );

  final TodoDTO dto = TodoDTO(
    title: 'hi',
    userId: 1,
    createdAt: DateTime.parse('2025-04-03 01:00'),
  );

  test('create()', () async {
    Todo created = await repository.create(dto);
    Todo? todo = await repository.findOne(created.id);

    expect(todo, isNotNull);
  });
}

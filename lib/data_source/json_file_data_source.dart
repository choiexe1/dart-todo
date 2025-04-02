import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dart_todo/data_source/data_source.dart';

class JsonFileDataSource<T> implements DataSource<String> {
  final String source;

  const JsonFileDataSource(this.source);

  @override
  Future<List<Map<String, dynamic>>> fetch() async {
    final File origin = File(source);
    List<dynamic> data = jsonDecode(await origin.readAsString());

    return data.cast<Map<String, dynamic>>().toList();
  }

  Future<void> save(List<Map<String, dynamic>> data) async {
    final File origin = File(source);
    final String encoded = JsonEncoder.withIndent(' ').convert(data);

    await origin.writeAsString(
      encoded + Platform.lineTerminator,
      encoding: Utf8Codec(),
      flush: true,
    );
  }

  Future<int> sequence() async {
    List<Map<String, dynamic>> data = await fetch();

    return data.map((e) => e['id'] as int).reduce(max) + 1;
  }

  // TODO: test reset()
  Future<void> _reset() async {
    final List<Map<String, dynamic>> origin = [
      {
        "userId": 1,
        "id": 1,
        "title": "생존코딩 유튜브 구독하기",
        "completed": false,
        "createdAt": "2025-03-29T10:15:00Z",
      },
      {
        "userId": 1,
        "id": 2,
        "title": "PR 제출하기",
        "completed": false,
        "createdAt": "2025-03-30T08:30:00Z",
      },
      {
        "userId": 1,
        "id": 3,
        "title": "다른 사람 코드 리뷰하기",
        "completed": false,
        "createdAt": "2025-03-31T14:00:00Z",
      },
      {
        "userId": 1,
        "id": 4,
        "title": "TIL 정리하기",
        "completed": true,
        "createdAt": "2025-04-01T09:45:00Z",
      },
      {
        "userId": 1,
        "id": 5,
        "title": "인프런 강의 시청",
        "completed": false,
        "createdAt": "2025-04-02T07:20:00Z",
      },
    ];

    await save(origin);
  }
}

void main() {
  JsonFileDataSource('data/backup.dat')._reset();
}

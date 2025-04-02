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
}

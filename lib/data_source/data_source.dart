abstract interface class DataSource<T> {
  /// 다양한 데이터 소스로부터 데이터를 로드할 수 있는 제네릭 인터페이스입니다.
  ///
  /// 구현체는 [T] 타입을 필요에 맞게 정의하고 사용할 수 있습니다.
  /// 아래 예제는 일반적인 사용 사례를 보여주지만, 실제 타입은 구현체에 따라 결정됩니다.
  ///
  /// * 웹 API의 경우, [T]는 [String] (URL)일 수 있습니다.
  /// * 파일 기반 소스의 경우, [T]는 파일 경로를 나타내는 [String]일 수 있습니다.
  ///
  /// 사용 예시:
  /// ```dart
  /// // URL 기반 데이터 소스
  /// class ApiDataSource implements DataSource<String> {
  ///   @override
  ///   load(String source) {
  ///     final url = source ?? 'https://default-api.com';
  ///     // URL에서 데이터를 가져오는 구현
  ///   }
  /// }
  ///
  /// // 파일 기반 데이터 소스
  /// class FileDataSource implements DataSource<String> {
  ///   @override
  ///   load(String source) {
  ///     final path = source ?? 'default/file/path.json';
  ///     // 파일에서 데이터를 읽는 구현
  ///   }
  /// }
  /// ```
  fetch();
}

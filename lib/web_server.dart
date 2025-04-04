import 'dart:io';

typedef Handler = Future<void> Function(HttpRequest request);

class Router {
  final Map<String, Map<String, Handler>> _routes = {};

  void _addRoute(String method, String path, Handler handler) {
    _routes.putIfAbsent(method, () => {})[path] = handler;
  }

  void get(String path, Handler handler) => _addRoute('GET', path, handler);
  void post(String path, Handler handler) => _addRoute('POST', path, handler);

  Future<void> handleRequest(HttpRequest request) async {
    final methodRoutes = _routes[request.method] ?? {};
    final handler = methodRoutes[request.uri.path];

    if (handler != null) {
      await handler(request);
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('404 Not Found')
        ..close();
    }
  }
}

class WebServer {
  final HttpServer _server;
  final Router _router;

  WebServer._(this._server, this._router);

  static Future<WebServer> run({required int port}) async {
    final HttpServer server = await HttpServer.bind(
      InternetAddress.anyIPv4,
      port,
    );

    print('🚀 Server running at http://localhost:$port');

    final router = Router();
    final webServer = WebServer._(server, router);

    webServer._startListening();

    return webServer;
  }

  void _startListening() async {
    await for (HttpRequest request in _server) {
      await _router.handleRequest(request);
    }
  }

  WebServer get(String path, Handler handler) {
    _router.get(path, handler);
    return this;
  }

  WebServer post(String path, Handler handler) {
    _router.post(path, handler);
    return this;
  }
}

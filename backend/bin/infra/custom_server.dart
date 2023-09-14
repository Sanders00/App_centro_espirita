import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

class CustomServer {
  Future<void> initialize({
    required Handler handler,
    required String address,
    required int port,
  }) async {
    await io.serve(handler, address, port);
    print('OK -> http://$address:$port');
  }
}

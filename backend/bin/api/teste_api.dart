import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ApiTeste {
  Handler get handler {
    Router router = Router();
    router.post('/teste', (Request req) {
      return Response.ok("testo ok");
    });
    return router;
  }
}

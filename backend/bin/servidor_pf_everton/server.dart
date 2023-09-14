// // ignore_for_file: unused_local_variable

// import 'dart:io';

// import 'package:backend/app_module.dart';
// import 'package:backend/infra/security/security_service_imp.dart';
// import 'package:backend/utils/env_manager.dart';
// import 'package:shelf/shelf.dart';
// import 'package:shelf/shelf_io.dart' as io;
// import 'package:shelf_cors_headers/shelf_cors_headers.dart';
// import 'package:shelf_modular/shelf_modular.dart';

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
// //Access to XMLHttpRequest at 'https://backend-app-gfsel.ondigitalocean.app//applicationconsumer_register' from origin 'http://localhost:51262' has been blocked by CORS policy: Response to preflight request doesn't pass access control check: No 'Access-Control-Allow-Origin' header is present on the requested resource.

// bool dontCheckCNNRequests(String origin) {
//   if (origin.contains('celilaclife') ||
//       origin.contains('localhost') ||
//       origin.contains('ddvital')) {
//     return true;
//   }
//   return false;
// }

// void main(List<String> arguments) async {
//   HttpOverrides.global = MyHttpOverrides();

//   // var hash = Password.hash('P@ssw0rd', PBKDF2());
//   // print(hash);
//   // print(Password.verify('password', hash));

//   final hasuraServerURL = await EnvManager.get<String>(
//     key: 'hasura_server_url',
//   );
//   final hasuraGraphQLAdminSecret =
//       await EnvManager.get<String>(key: 'hasura_admin_secret');

//   final overrideHeaders = {
//     // ACCESS_CONTROL_ALLOW_ORIGIN: '*',
//     ACCESS_CONTROL_ALLOW_ORIGIN:
//         'https://www.celilaclife.com.br,https://ddvital.github.io/dashboard/',
//     ACCESS_CONTROL_ALLOW_METHODS: 'POST, OPTIONS, GET',
//     ACCESS_CONTROL_ALLOW_HEADERS:
//         'content-type,authorization, access-control-allow-origin',
//     // 'Content-Type': 'application/json;charset=utf-8'
//   };
//   // 'Access-Control-Allow-Headers': 'content-type,access-control-allow-origin'

//   // String webAppURL = await EnvManager.get(key: 'webApp');
//   final handler = const Pipeline()
//       .addMiddleware(
//         corsHeaders(
//           headers: overrideHeaders,
//           originChecker: dontCheckCNNRequests,
//         ),
//       )
//       .addMiddleware(SecurityServiceImp().authorization)
//       .addMiddleware(SecurityServiceImp().verifyJWT)
//       .addHandler(
//         Modular(
//           module: AppModule(
//             hasuraServerURL: hasuraServerURL,
//             hasuraGraphQLAdminSecret: hasuraGraphQLAdminSecret,
//             securityService: SecurityServiceImp(),
//           ),
//         ),
//       );

//   final restServer = await io.serve(
//     handler,
//     '0.0.0.0',
//     4000,
//   );

//   // ignore: avoid_print
//   print(
//     'Server online: ${restServer.address.host} '
//     '${restServer.address.address}:${restServer.port}',
//   );
// }

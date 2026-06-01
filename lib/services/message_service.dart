import 'package:cloud_functions/cloud_functions.dart';

Future<HttpsCallableResult> sendMessage(
  String firstname,
  String lastname,
  String email,
  String phone,
  String subject,
  String message,
) async {
  final callable = FirebaseFunctions.instance.httpsCallable('sendEmail');

  final result = await callable.call({
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "message": message,
    "subject": subject,
  });
  return result;
}

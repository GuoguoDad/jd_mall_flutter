// Package imports:
import 'package:url_launcher/url_launcher.dart';

Future<bool> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (await canLaunchUrl(launchUri)) {
    return launchUrl(launchUri);
  } else {
    throw 'Could not launch';
  }
}

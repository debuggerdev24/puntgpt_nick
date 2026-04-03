import 'package:puntgpt_nick/core/constants/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUnibetUrl() async {
  final uri = Uri.parse(AppStrings.unibetPartnerUrl);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Future<void> launchDabbleUrl() async {
  final uri = Uri.parse(AppStrings.dabblePartnerUrl);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

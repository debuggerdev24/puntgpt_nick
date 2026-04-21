
import 'package:puntgpt_nick/core/app_imports.dart';

class UploadStoryData extends StatelessWidget {
  const UploadStoryData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppScreenTopBar(
          title: "Upload Story Data",
          slogan: "Update your story data",
        ),
      ],
    );
  }
}
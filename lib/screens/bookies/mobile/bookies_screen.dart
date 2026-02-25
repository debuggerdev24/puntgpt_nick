import 'package:puntgpt_nick/core/app_imports.dart';

class BookiesScreen extends StatelessWidget {
  const BookiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        AppRouter.indexedStackNavigationShell?.goBranch(0);
      },
      child: Center(
        child: Column(
          spacing: 32.h,
          children: [
            SizedBox(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Use Code: ",
                    style: bold(fontSize: 20.sp),
                  ),
                  TextSpan(
                    text: "‘PUNTGPT’",
                    style: bold(fontSize: 20.sp, color: Color(0xffE5B82E)),
                  ),
                ],
              ),
            ),
            ImageWidget(path: AppAssets.b1),
            ImageWidget(path: AppAssets.b2),
            ImageWidget(path: AppAssets.b3),
          ],
        ),
      ),
    );
  }
}

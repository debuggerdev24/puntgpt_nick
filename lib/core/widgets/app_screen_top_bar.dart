import 'package:puntgpt_nick/core/app_imports.dart';

class AppScreenTopBar extends StatelessWidget {
  const AppScreenTopBar({
    super.key,
    required this.title,
    required this.slogan,
    this.onBack,
  });

  final String title;
  final String slogan;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(4.w, 7.w, 25.w, 7.5.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: onBack ?? () => context.pop(),
                icon: Icon(Icons.arrow_back_ios_rounded, size: 16.w),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: regular(
                        fontSize: (context.isBrowserMobile) ? 36.sp : 24.sp,
                        fontFamily: AppFontFamily.secondary,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      slogan,
                      style: semiBold(
                        fontSize: (context.isBrowserMobile) ? 28.sp : 14.sp,
                        color: AppColors.primary.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        horizontalDivider(),
      ],
    );
  }
}

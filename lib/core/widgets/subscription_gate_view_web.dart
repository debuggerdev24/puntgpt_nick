import 'package:puntgpt_nick/core/app_imports.dart';

class SubscriptionGateViewWeb extends StatelessWidget {
  const SubscriptionGateViewWeb({
    super.key,
    required this.featureTitle,
    required this.featureDescription,
    this.icon = Icons.workspace_premium_rounded,
    this.subscribeButtonWidth = 360,
  });

  final String featureTitle,featureDescription;
  final IconData icon;
  final double subscribeButtonWidth;

  void _openManageSubscription(BuildContext context) {
    context.pushNamed(WebRoutes.manageSubscriptionScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(22.wSize),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 52.fSize,
                color: AppColors.primary.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 24),
            Text(
              featureTitle,
              style: semiBold(
                fontSize: 20.fSize,
                fontFamily: AppFontFamily.secondary,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
            Text(
              featureDescription,
              style: regular(
                fontSize: 14.fSize,
                color: AppColors.primary.withValues(alpha: 0.65),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 22),
            AppFilledButton(
              isExpand: false,
              width: subscribeButtonWidth,
              onTap: () => _openManageSubscription(context),
              text: "Subscribe to Pro",
              textStyle: semiBold(
                fontSize: 16.fSize,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

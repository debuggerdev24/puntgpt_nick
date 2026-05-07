import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/core/constants/app_strings.dart';
import 'package:puntgpt_nick/main.dart';
import 'package:puntgpt_nick/provider/subscription/subscription_provider.dart';
import 'package:puntgpt_nick/screens/account/web/widgets/subscription_plan_web.dart';

class ManageSubscriptionSectionWeb extends StatelessWidget {
  const ManageSubscriptionSectionWeb({super.key});

  @override
  Widget build(BuildContext context) {
    // final fourteenResponsive = context.isDesktop ? 14.sp : 22.sp;
    // double subscriptionBoxWidth = context.isDesktop ? 340.w : 510.w;

    return Consumer<SubscriptionProvider>(
      builder: (context, provider, child) {
        final plans = provider.plans;
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12, 8, 11, 8),

                child: topBar(
                  // twelveResponsive: context.isDesktop ? 12.sp : 20.sp,
                  provider: provider,
                  context: context,
                ),
              ),
              horizontalDivider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 22),

                      //* show the all plans
                      if (plans.isNotEmpty)
                        Text("All Plans : ", style: bold(fontSize: 14)),
                      SizedBox(height: 12),
                      Wrap(
                        runSpacing: 24.w,
                        spacing: 20.w,
                        children: List.generate(plans.length, (index) {
                          return OnMouseTap(
                            onTap: () {
                              if (isGuest) {
                                showDialog<void>(
                                  context: context,
                                  builder: (dialogCtx) => AlertDialog(
                                    title: Text(
                                      'Subscribe',
                                      style: semiBold(
                                        fontSize: 18.sp,
                                        fontFamily: AppFontFamily.secondary,
                                      ),
                                    ),
                                    content: Text(
                                      AppStrings.guestSubscribeInfoBody,
                                      style: regular(fontSize: 15.sp),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(dialogCtx).pop(),
                                        child: Text(
                                          'Cancel',
                                          style: semiBold(
                                            fontSize: 14.sp,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(dialogCtx).pop();
                                          provider.setIsShowSelectedPlan(
                                            showSelectedPlan: true,
                                            planIndex: plans[index].id,
                                          );
                                        },
                                        child: Text(
                                          'Continue',
                                          style: semiBold(
                                            fontSize: 14.sp,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }
                              provider.setIsShowSelectedPlan(
                                showSelectedPlan: true,
                                planIndex: plans[index].id,
                              );
                            },
                            child: SubscriptionPlanWeb(
                              plan: plans[index],
                              isCurrentPlan: provider.showCurrentPlan,
                            ),
                          );
                        }),
                      ),

                      SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
              if (!isGuest)
                AppFilledButton(
                  margin: EdgeInsets.only(
                    left: 60.w,
                    right: 60.w,
                    bottom: 25.w,
                  ),
                  text: "See Current Plan",
                  // textStyle: semiBold(
                  //   fontSize: context.isDesktop ? 17.sp : 22.sp,
                  //   color: AppColors.white,
                  // ),
                  // padding: EdgeInsets.symmetric(
                  //   vertical: context.isDesktop ? 12.w : 16.5.w,
                  // ),
                  onTap: () {
                    provider.setIsShowCurrentPlan = !provider.showCurrentPlan;
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget points({bool? isBenefit, required String content}) {
    return Row(
      spacing: 10.w,
      children: [
        Icon(
          isBenefit ?? false ? Icons.check_rounded : Icons.close_rounded,
          color: isBenefit ?? false ? AppColors.green : AppColors.red,
        ),
        Expanded(child: Text(content)),
      ],
    );
  }

  Widget topBar({
    // required double twelveResponsive,
    required SubscriptionProvider provider,
    required BuildContext context,
  }) {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Manage Subscription",
            style: regular(
              fontSize: 22, //context.isDesktop ? 24.sp : 30.sp,
              height: 1.1,

              fontFamily: AppFontFamily.secondary,
            ),
          ),
          Text(
            "Manage your Subscription Plan",
            style: semiBold(
              fontSize: 12,
              color: AppColors.primary.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

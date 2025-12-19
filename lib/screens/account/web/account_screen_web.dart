import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/app_colors.dart';
import 'package:puntgpt_nick/core/constants/text_style.dart';
import 'package:puntgpt_nick/core/widgets/app_devider.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';
import 'package:puntgpt_nick/responsive/responsive_builder.dart';
import 'package:puntgpt_nick/screens/account/web/widgets/manage_subscription_section_web.dart';
import 'package:puntgpt_nick/screens/account/web/widgets/personal_details_section_web.dart';
import 'package:puntgpt_nick/screens/home/web/home_screen_web.dart';

class AccountScreenWeb extends StatefulWidget {
  const AccountScreenWeb({super.key});

  @override
  State<AccountScreenWeb> createState() => _AccountScreenWebState();
}

class _AccountScreenWebState extends State<AccountScreenWeb> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bodyWidth = context.isMobile
        ? double.maxFinite
        : context.isTablet
        ? 1240.w
        : 1040.w;
    final twentyResponsive = context.isDesktop
        ? 20.sp
        : context.isTablet
        ? 28.sp
        : (kIsWeb)
        ? 36.sp
        : 20.sp;
    // final sixteenResponsive = context.isDesktop
    //     ? 16.sp
    //     : context.isTablet
    //     ? 24.sp
    //     : (kIsWeb)
    //     ? 32.sp
    //     : 16.sp;
    // final twelveResponsive = context.isDesktop
    //     ? 12.sp
    //     : context.isTablet
    //     ? 20.sp
    //     : (kIsWeb)
    //     ? 28.sp
    //     : 12.sp;
    final fourteenResponsive = context.isDesktop
        ? 14.sp
        : context.isTablet
        ? 20.sp
        : (kIsWeb)
        ? 28.sp
        : 14.sp;
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: bodyWidth,
                child: Consumer<AccountProvider>(
                  builder: (context, provider, child) {
                    return Row(
                      children: [
                        //todo ---------------> left panel
                        verticalDivider(),
                        SizedBox(
                          width: context.isDesktop
                              ? 312.w
                              : context.isTablet
                              ? 370.w
                              : 512.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo title
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.isDesktop ? 26.w : 20.w,

                                  vertical: context.isDesktop ? 26.w : 20.w,
                                ),
                                child: Text(
                                  "My Account",
                                  style: regular(
                                    fontSize: twentyResponsive,
                                    fontFamily: AppFontFamily.secondary,
                                  ),
                                ),
                              ),
                              4.h.verticalSpace,
                              horizontalDivider(),

                              //todo 1st tab
                              accountTabs(
                                title: "Personal Details",
                                fourteenResponsive: fourteenResponsive,
                                color: (provider.selectedAccountTabWeb == 0)
                                    ? AppColors.primary
                                    : null,
                                onTap: () {
                                  provider.setAccountTabIndex = 0;
                                },
                                context: context,
                              ),
                              accountTabs(
                                title: "Manage Subscription",
                                fourteenResponsive: fourteenResponsive,
                                color: (provider.selectedAccountTabWeb == 1)
                                    ? AppColors.primary
                                    : null,

                                onTap: () {
                                  provider.setAccountTabIndex = 1;
                                },
                                context: context,
                              ),
                              horizontalDivider(),
                            ],
                          ),
                        ),
                        verticalDivider(),
                        //todo ----------------> right panel
                        if (provider.selectedAccountTabWeb == 0)
                          PersonalDetailsSectionWeb(formKey: _formKey)
                        else
                          ManageSubscriptionSectionWeb(),
                        verticalDivider(),
                      ],
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.bottomRight,
              child: askPuntGPTButtonWeb(context: context),
            ),
          ],
        ),
      ),
    );
  }

  Widget accountTabs({
    required String title,
    required double fourteenResponsive,
    Color? color,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return OnMouseTap(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 700),
        decoration: BoxDecoration(color: color),
        padding: EdgeInsets.symmetric(
          horizontal: context.isDesktop ? 24.w : 30.w,
          vertical: context.isDesktop ? 20.w : 26.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: bold(
                fontSize: fourteenResponsive,
                color: color == AppColors.primary ? AppColors.white : null,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: fourteenResponsive - 2,
              color: color == AppColors.primary ? AppColors.white : null,
            ),
          ],
        ),
      ),
    );
  }
}

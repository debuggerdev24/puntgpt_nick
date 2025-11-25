import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:puntgpt_nick/core/constants/app_assets.dart';
import 'package:puntgpt_nick/core/router/app/app_routes.dart';
import 'package:puntgpt_nick/core/utils/field_validators.dart';
import 'package:puntgpt_nick/core/widgets/app_filed_button.dart';
import 'package:puntgpt_nick/core/widgets/app_outlined_button.dart';
import 'package:puntgpt_nick/core/widgets/app_text_field.dart';
import 'package:puntgpt_nick/core/widgets/on_button_tap.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/widgets/app_devider.dart';

class PersonalDetailsSection extends StatefulWidget {
  const PersonalDetailsSection({super.key});

  @override
  State<PersonalDetailsSection> createState() => _PersonalDetailsSectionState();
}

class _PersonalDetailsSectionState extends State<PersonalDetailsSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Consumer<AccountProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                topBar(context, provider),

              ],
            );
          },
        ),
      ),
    );
  }

  Widget topBar(BuildContext context, AccountProvider provider) {
    return Column(
      children: [
        // padding: EdgeInsets.fromLTRB(5.w, 12.h, (!provider.isEdit) ? 25.w : 8.w, 16.h),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Details",
                  style: regular(
                    fontSize: 24.sp,
                    fontFamily: AppFontFamily.secondary,
                    height: 1.35,
                  ),
                ),
                Text(
                  "Manage your name, email, etc.",
                  style: semiBold(
                    fontSize: 14.sp,
                    color: AppColors.greyColor.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),Spacer(),
            if (!provider.isEdit)
              OnMouseTap(
                onTap: () {
                  provider.setIsEdit = !(provider.isEdit);
                },
                child: Row(
                  spacing: 2,
                  children: [
                    SvgPicture.asset(AppAssets.edit),
                    Text("Edit", style: bold(fontSize: 16.sp)),
                  ],
                ),
              )
            else
              TextButton(
                onPressed: () {
                  _formKey.currentState?.reset();
                  provider.setIsEdit = !(provider.isEdit);
                },

                child: Text("Cancel", style: bold(fontSize: 16.sp,color: AppColors.primary)),
              ),
          ],
        ),
        // horizontalDivider(),
      ],
    );
  }
}

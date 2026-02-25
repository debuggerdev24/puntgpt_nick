import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/provider/punt_club/punter_club_provider.dart';
import 'package:puntgpt_nick/screens/punter_club/mobile/widgets/punter_club_shimmers.dart';

class GroupMembersScreen extends StatelessWidget {
  const GroupMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PuntClubProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            topBar(context: context, provider: provider),
            horizontalDivider(),
            Expanded(
              child: provider.groupMembersList == null
                  ? PunterClubShimmers.groupMembersScreenShimmer(context: context)
                  : ListView.separated(
                      separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: horizontalDivider(),
                      ),
                      itemCount: provider.groupMembersList!.length,
                      itemBuilder: (context, index) {
                        final groupMember = provider.groupMembersList![index];
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 23.w),
                          title: Text(groupMember.userName,style: semiBold(fontSize: 18.sp)),
                          subtitle: Text("Joined on ${DateFormatter.formatWithTime(groupMember.joinedAt)}",style: medium(fontSize: 15.sp,color: AppColors.greyColor.withValues(alpha: 0.6),)),
                          leading: ImageWidget(path: AppAssets.userIcon, type: ImageType.svg,width: 25.w,),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget topBar({
    required BuildContext context,
    required PuntClubProvider provider,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 18.w, 25.w, 18.w),

      // padding: EdgeInsets.symmetric(
      //   horizontal: (context.isBrowserMobile) ? 35.w : 25.w,
      //   vertical: 22.w,
      // ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 22.w,right: 12.w),
            child: GestureDetector(
              // padding: EdgeInsets.zero,
              onTap: () {
                context.pop();
              },
              child: Icon(Icons.arrow_back_ios_rounded, size: 16.h),
            ),
          ),
          Text(
            "Group Members",
            style: regular(
              fontSize: (context.isBrowserMobile) ? 38.sp : 24.sp,
              fontFamily: AppFontFamily.secondary,
            ),
          ),
          Spacer(),
          ImageWidget(path: AppAssets.groupIcon, type: ImageType.svg),
        ],
      ),
    );
  }
}

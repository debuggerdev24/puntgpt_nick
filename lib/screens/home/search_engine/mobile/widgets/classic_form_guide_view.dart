import 'package:flutter_animate/flutter_animate.dart';
import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/models/home/classic_form_guide/next_race_model.dart';
import 'package:puntgpt_nick/provider/home/classic_form/classic_form_provider.dart';

class ClassicFormGuideView extends StatelessWidget {
  const ClassicFormGuideView({super.key, required this.provider});

  final ClassicFormProvider provider;

  @override
  Widget build(BuildContext context) {
    final nextRaces = provider.nextRaceList;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Next to go", style: bold(fontSize: 16.sp)),
          10.w.verticalSpace,
          nextRaces.isEmpty
              ? _buildNextToGoEmptyState(context: context)
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.w,
                      children: List.generate(
                        nextRaces.length,
                        (index) => _nextToGoItem(nextRace: nextRaces[index]),
                      ),
                    ),
                  ),
                ),
          //* Next to go tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(provider.days.length, (index) {
                return GestureDetector(
                  onTap: () {
                    provider.changeSelectedDay = index;
                  },
                  child: AnimatedContainer(
                    duration: 400.milliseconds,
                    margin: EdgeInsets.only(
                      top: 24.w,
                      bottom: 16.w,
                      right: 8.w,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.w,
                      horizontal: 18.w,
                    ),
                    decoration: BoxDecoration(
                      color: (provider.selectedDay == index)
                          ? AppColors.primary
                          : null,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Text(
                      provider.days[index].value,
                      style: semiBold(
                        fontSize: 16.sp,
                        color: (provider.selectedDay == index)
                            ? AppColors.white
                            : null,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          provider.classicFormGuide!.isEmpty
              ? _buildRaceTableEmptyState(context: context, provider: provider)
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 55.w),
                  itemCount: provider.classicFormGuide!.length,
                  separatorBuilder: (_, __) => 10.w.verticalSpace,
                  itemBuilder: (context, index) {
                    final classicForm = provider.classicFormGuide![index];
                    return _classicMeetingListItem(
                      context: context,
                      meetingName: classicForm.meetingName,
                      meetingDate: classicForm.country,
                      meetingTime: classicForm.meetingAustralianTime,
                      onTap: () {
                        provider.getMeetingRaceList(
                          meetingId: classicForm.meetingId.toString(),
                        );
                        provider.getRaceFieldDetail(
                          id: classicForm.races[provider.selectedRace].raceId
                              .toString(),
                        );
                        context.pushNamed(AppRoutes.selectedRace.name);
                      },
                    );
                  },
                ),
          25.w.verticalSpace,
        ],
      ),
    );
  }
}

Widget _classicMeetingListItem({
  required BuildContext context,
  required String meetingName,
  required String meetingDate,
  required String meetingTime,
  required VoidCallback onTap,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(12.w, 10.w, 6.w, 10.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                spacing: 4.w,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meetingName,
                    style: semiBold(fontSize: 16.sp, color: AppColors.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    meetingDate,
                    style: regular(
                      fontSize: 13.sp,
                      color: AppColors.primary.withValues(alpha: 0.55),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            10.w.horizontalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                meetingTime,
                style: semiBold(
                  fontSize: 12.sp,
                  color: AppColors.primary.withValues(alpha: 0.8),
                ),
              ),
            ),
            6.w.horizontalSpace,
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.primary.withValues(alpha: 0.35),
            ),
          ],
        ),
      ),
    ),
  );
}

// SingleChildScrollView(
//   scrollDirection: Axis.horizontal,
//   child: Container(
//     width: 1.4.sw,
//     margin: EdgeInsets.only(bottom: 55.w),
//     decoration: BoxDecoration(
//       border: Border.all(
//         color: AppColors.primary.withValues(alpha: 0.3),
//       ),
//     ),
//     child: Table(
//       border: TableBorder.symmetric(
//         inside: BorderSide(
//           color: AppColors.primary.withValues(alpha: 0.2),
//         ),
//       ),
//       columnWidths: {
//         0: FlexColumnWidth(3.w),
//         1: FlexColumnWidth(2.w),
//         2: FlexColumnWidth(2.w),
//       },
//       defaultVerticalAlignment:
//           TableCellVerticalAlignment.middle,
//       children: List.generate(
//         provider.classicFormGuide!.length,
//         (index) {
//           final classicForm = provider.classicFormGuide![index];
//           return _buildTableRow(
//             col1: classicForm.meetingName,
//             col3: classicForm.meetingDate,
//             col4: classicForm.meetingAustralianTime,
//             onTap: () {
//               provider.getMeetingRaceList(
//                 meetingId: classicForm.meetingId.toString(),
//               );
//               provider.getRaceFieldDetail(
//                 id: classicForm
//                     .races[provider.selectedRace]
//                     .raceId
//                     .toString(),
//               );
//               context.pushNamed(AppRoutes.selectedRace.name);
//             },
//           );
//         },
//       ),
//     ),
//   ),
// ),
Widget _buildNextToGoEmptyState({required BuildContext context}) {
  return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 4.w),
        padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 20.w),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.03),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.12),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flag_outlined,
              size: 22.sp,
              color: AppColors.primary.withValues(alpha: 0.45),
            ),
            10.w.horizontalSpace,
            Text(
              "NO races found",
              style: semiBold(
                fontSize: 15.sp,
                fontFamily: AppFontFamily.secondary,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      )
      .animate()
      .fadeIn(duration: 400.ms)
      .slideY(
        begin: 0.08,
        end: 0,
        duration: 400.ms,
        curve: Curves.easeOutCubic,
      );
}

Widget _buildRaceTableEmptyState({
  required BuildContext context,
  required ClassicFormProvider provider,
}) {
  final dayLabel = provider.days[provider.selectedDay].value.toLowerCase();
  return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 55.w),
        padding: EdgeInsets.symmetric(vertical: 28.w, horizontal: 20.w),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.03),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.green.withValues(alpha: 0.22),
                ),
              ),
              child: Icon(
                Icons.calendar_today_outlined,
                size: 30.sp,
                color: AppColors.primary.withValues(alpha: 0.55),
              ),
            ),
            14.w.verticalSpace,
            Text(
              "No races for $dayLabel",
              style: semiBold(
                fontSize: 16.sp,
                fontFamily: AppFontFamily.secondary,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
      .animate()
      .fadeIn(duration: 350.ms)
      .slideY(
        begin: 0.04,
        end: 0,
        duration: 350.ms,
        curve: Curves.easeOutCubic,
      );
}

Widget _nextToGoItem({required NextRaceModel nextRace}) {
  return Container(
    width: 240.w,
    padding: EdgeInsets.fromLTRB(16.w, 12.w, 14.w, 14.w),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6.w,
      children: [
        Text(nextRace.trackName, style: semiBold(fontSize: 16.sp)),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                nextRace.raceName,
                style: semiBold(
                  fontSize: 14.sp,
                  color: AppColors.primary.withValues(alpha: 0.6),
                ),
              ),
            ),
            Text(
              nextRace.raceAustralianTime,
              style: semiBold(
                fontSize: 14.sp,
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

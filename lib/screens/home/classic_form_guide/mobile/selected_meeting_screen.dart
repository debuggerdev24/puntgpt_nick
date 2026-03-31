import 'package:flutter_animate/flutter_animate.dart';
import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/models/home/classic_form_guide/race_details_model.dart';
import 'package:puntgpt_nick/provider/home/classic_form/classic_form_provider.dart';
import 'package:puntgpt_nick/provider/home/search_engine/search_engine_provider.dart';
import 'package:puntgpt_nick/screens/home/search_engine/mobile/home_screen.dart';
import 'package:puntgpt_nick/screens/home/search_engine/mobile/widgets/home_section_shimmers.dart';

class SelectedMeetingScreen extends StatelessWidget {
  const SelectedMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClassicFormProvider>(
      builder: (context, provider, child) {
        if (provider.raceList == null || provider.raceFieldDetail == null) {
          return HomeSectionShimmers.selectedRaceScreenShimmer(
            context: context,
          );
        }
        return Stack(
          children: [
            Column(
              children: [
                topBar(context: context, provider: provider),
                //* Race selection view
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //* Race selection view
                        Padding(
                          padding: EdgeInsets.fromLTRB(25.w, 25.h, 25.w, 0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primary),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  provider.raceList!.races.length,
                                  (index) {
                                    final race =
                                        provider.raceList!.races[index];
                                    return GestureDetector(
                                      onTap: () {
                                        provider.changeSelectedRace = index;
                                        provider.getRaceFieldDetail(
                                          id: race.raceId.toString(),
                                        );
                                      },
                                      child: AnimatedContainer(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 12,
                                        ),
                                        duration: 400.milliseconds,
                                        decoration: BoxDecoration(
                                          color:
                                              (provider.selectedRace == index)
                                              ? AppColors.primary
                                              : null,
                                        ),
                                        child: Text(
                                          "R${index + 1}",
                                          style: semiBold(
                                            fontSize: 16.sp,
                                            color:
                                                (provider.selectedRace == index)
                                                ? AppColors.white
                                                : AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        //* Race other details
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 16.w,
                            horizontal: 25.w,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 15.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _raceSubNavBar(
                                title: 'Tips & Analysis',
                                onTap: () {
                                  provider.getTipsAndAnalysis(
                                    raceId: provider
                                        .raceFieldDetail!
                                        .race
                                        .raceId
                                        .toString(),
                                  );
                                  context.pushNamed(
                                    AppRoutes.tipsAndAnalysis.name,
                                  );
                                },
                              ),
                              _raceSubNavBar(
                                title: 'Speed Maps',
                                onTap: () {
                                  provider.getSpeedMaps(
                                    meetingId: provider
                                        .raceList!
                                        .meeting
                                        .meetingId
                                        .toString(),
                                    raceId: provider
                                        .raceFieldDetail!
                                        .race
                                        .raceId
                                        .toString(),
                                  );
                                  context.pushNamed(AppRoutes.speedMaps.name);
                                },
                              ),
                              _raceSubNavBar(
                                title: 'Barrier Map',
                                onTap: () {
                                  deBouncer.run(() {
                                    AppToast.info(
                                      context: context,
                                      message: 'Coming soon',
                                    );
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        //* Race table
                        SelectedRaceTable(provider: provider),
                        120.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //* ask punt gpt button
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: 25.w, right: 25.w),
                child: askPuntGPTButton(context: context),
              ),
            ),
            Consumer<SearchEngineProvider>(
              builder: (context, provider, child) {
                if (provider.isCreatingTipSlip) {
                  return FullPageIndicator();
                }
                return Container();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _raceSubNavBar({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Text(title, style: semiBold(fontSize: 14.sp)),
    );
  }

  Widget topBar({
    required ClassicFormProvider provider,
    required BuildContext context,
  }) {
    final meeting = provider.raceList!.meeting;
    final races = provider.raceList!.races;
    if (races.isEmpty) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(6.w, 6.w, 10.w, 6.w),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back_ios_rounded, size: 16.h),
                ),
                Expanded(
                  child: Text(
                    meeting.name,
                    style: regular(
                      fontSize: 24.sp,
                      fontFamily: AppFontFamily.secondary,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          horizontalDivider(),
        ],
      );
    }
    final safeIndex = provider.selectedRace.clamp(0, races.length - 1);
    final race = races[safeIndex];

    return AppScreenTopBar(
      title: meeting.name,
      slogan:
          "PuntGPT Legends Stakes ${race.distance} ${race.distanceUnits}, ${DateFormatter.formatRaceDateTime(race.startTimeUtc)}",
    );
    // return Column(
    //   children: [
    //     Padding(
    //       padding: EdgeInsets.fromLTRB(6.w, 7.w, 25.w, 7.w),
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           IconButton(
    //             padding: EdgeInsets.zero,
    //             onPressed: () {
    //               context.pop();
    //             },
    //             icon: Icon(Icons.arrow_back_ios_rounded, size: 16.w),
    //           ),
    //           Expanded(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   meeting.name,
    //                   style: regular(
    //                     fontSize: 24.sp,
    //                     fontFamily: AppFontFamily.secondary,
    //                     height: 1.2,
    //                   ),
    //                 ),
    //                 Text(
    //                   "PuntGPT Legends Stakes ${race.distance} ${race.distanceUnits}, ${DateFormatter.formatRaceDateTime(race.startTimeUtc)}",
    //                   style: semiBold(
    //                     fontSize: 14.sp,
    //                     color: AppColors.primary.withValues(alpha: 0.6),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     horizontalDivider(),
    //   ],
    // );
  }
}

class SelectedRaceTable extends StatefulWidget {
  const SelectedRaceTable({super.key, required this.provider});
  final ClassicFormProvider provider;

  @override
  State<SelectedRaceTable> createState() => _SelectedRaceTableState();
}

class _SelectedRaceTableState extends State<SelectedRaceTable> {
  int? expandedIndex;

  @override
  void didUpdateWidget(SelectedRaceTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    final selections = widget.provider.raceFieldDetail?.selections ?? [];
    if (expandedIndex != null &&
        (selections.isEmpty || expandedIndex! >= selections.length)) {
      expandedIndex = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selections = widget.provider.raceFieldDetail!.selections;
    final safeExpandedIndex =
        expandedIndex != null && expandedIndex! < selections.length
        ? expandedIndex
        : null;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      itemCount: selections.length,
      separatorBuilder: (_, __) => 10.w.verticalSpace,
      itemBuilder: (context, index) {
        final selection = selections[index];
        final isExpanded = safeExpandedIndex == index;
        return _selectionCard(
          context: context,
          index: index,
          selection: selection,
          isExpanded: isExpanded,
          onToggle: () {
            setState(() => expandedIndex = isExpanded ? null : index);
          },
        );
      },
    );
  }

  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
  //       borderRadius: BorderRadius.circular(6.r),
  //     ),
  //     child: Text(
  //       label,
  //       style: semiBold(fontSize: 13.sp, color: AppColors.primary),
  //     ),
  //   );
  // }
}

Widget _pill({
  required String text,
  required BuildContext context,
  Color? bg,
  Color? fg,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.w),
    decoration: BoxDecoration(
      color: bg ?? AppColors.primary.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.08)),
    ),
    child: Text(
      text,
      style: semiBold(
        fontSize: 12.sp,
        color: fg ?? AppColors.primary.withValues(alpha: 0.85),
      ),
    ),
  );
}

Widget _selectionCard({
  required BuildContext context,
  required int index,
  required Selection selection,
  required bool isExpanded,
  required VoidCallback onToggle,
}) {
  final distance =
      context.read<ClassicFormProvider>().raceFieldDetail?.race.distance ?? 0;
  final trainerStr = selection.trainerName.toString();
  final trackStr = selection.trackName.toString();

  String formStr() {
    final list = selection.formHistory;
    if (list.isEmpty) return '—';
    return list.map((f) => f.resultPosition.toString()).join('-');
  }

  Widget labelValue({required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label : ',
          style: bold(fontSize: 12.sp, color: AppColors.primary),
        ),
        Expanded(
          child: Text(
            value,
            style: semiBold(
              fontSize: 12.sp,
              color: AppColors.primary.withValues(alpha: 0.7),
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: isExpanded
                ? AppColors.primary.withValues(alpha: 0.6)
                : AppColors.primary.withValues(alpha: 0.2),
            width: isExpanded ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    spacing: 4.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* Horse name and barrier
                      Text(
                        '${index + 1}. ${selection.horseName} (${selection.barrier})',
                        style: semiBold(
                          fontSize: 15.sp,
                          color: AppColors.primary,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${selection.trackName} • W: ${selection.weight}',
                        style: regular(
                          fontSize: 12.sp,
                          color: AppColors.primary.withValues(alpha: 0.5),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                //* Race number
                _pill(text: 'R${selection.number}', context: context),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: isExpanded
                  ? Padding(
                      padding: EdgeInsets.only(top: 10.w),
                      child: Column(
                        children: [
                          horizontalDivider(),
                          10.w.verticalSpace,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    labelValue(
                                      label: 'Weight',
                                      value: '${selection.weight}kg',
                                    ),
                                    6.w.verticalSpace,
                                    labelValue(label: 'Form', value: formStr()),
                                  ],
                                ),
                              ),
                              14.w.horizontalSpace,
                              Expanded(
                                child: Column(
                                  children: [
                                    labelValue(
                                      label: 'Jockey',
                                      value: selection.jockeyName,
                                    ),
                                    6.w.verticalSpace,
                                    labelValue(
                                      label: 'Trainer',
                                      value: trainerStr,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          6.w.verticalSpace,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: labelValue(
                                  label: 'Track',
                                  value: trackStr,
                                ),
                              ),
                              14.w.horizontalSpace,
                              Expanded(
                                child: labelValue(
                                  label: 'Distance',
                                  value: '${distance}m',
                                ),
                              ),
                            ],
                          ),
                          10.w.verticalSpace,
                          horizontalDivider(),
                          10.w.verticalSpace,
                          _ExpandedStatsContent(
                            selection: selection,
                            distance: distance,
                          ),
                          12.w.verticalSpace,
                          SizedBox(
                            width: double.infinity,
                            child: AppFilledButton(
                              text: 'Add to Tip Slip',
                              textStyle: semiBold(
                                fontSize: 14.sp,
                                color: AppColors.white,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.w),
                              onTap: () {
                                context
                                    .read<SearchEngineProvider>()
                                    .createTipSlip(
                                      context: context,
                                      selectionId: selection.selectionId
                                          .toString(),
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    ),
  );
}

// @override
// Widget build(BuildContext context) {
//   final selections = widget.provider.raceFieldDetail!.selections;
//   final safeExpandedIndex =
//       expandedIndex != null && expandedIndex! < selections.length
//       ? expandedIndex
//       : null;
//   return SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Container(
//       width: 1.4.sw,
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
//       ),
//       margin: EdgeInsets.symmetric(horizontal: 24.w),
//       child: Table(
//         border: TableBorder.symmetric(
//           inside: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
//         ),
//         columnWidths: {0: FlexColumnWidth(1.7.w), 1: FlexColumnWidth(4.5.w)},
//         defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//         children: List.generate(selections.length, (index) {
//           final selection = selections[index];
//           final isExpanded = safeExpandedIndex == index;
//           return TableRow(
//             children: [
//               //* first column
//               TableCell(
//                 verticalAlignment: TableCellVerticalAlignment.top,

//                 child: IntrinsicHeight(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         expandedIndex = isExpanded ? null : index;
//                       });
//                     },

//                     child: Container(
//                       // alignment: Alignment.,
//                       color: isExpanded
//                           ? AppColors.primary
//                           : Colors.transparent,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 10.w,
//                           horizontal: 8.w,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${index + 1}. ${selections[index].horseName}",
//                               style: semiBold(
//                                 fontSize: 16.sp,
//                                 color: isExpanded ? Colors.white : null,
//                               ),
//                             ),
//                             if (isExpanded) ...[
//                               12.w.verticalSpace,
//                               Text(
//                                 "\$${selection.oddsWin}",
//                                 style: semiBold(
//                                   fontSize: 16.sp,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               AppFilledButton(
//                                 margin: EdgeInsets.only(top: 4),
//                                 text: "Add to Tip Slip",
//                                 textStyle: semiBold(
//                                   fontSize: 14.sp,
//                                   color: AppColors.primary,
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 9.w),
//                                 color: AppColors.white,
//                                 onTap: () {
//                                   context
//                                       .read<SearchEngineProvider>()
//                                       .createTipSlip(
//                                         context: context,
//                                         selectionId: selection.selectionId
//                                             .toString(),
//                                       );
//                                 },
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               //* second column
//               TableCell(
//                 verticalAlignment: TableCellVerticalAlignment.top,
//                 child: Container(
//                   color: Colors.transparent,
//                   padding: EdgeInsets.symmetric(
//                     vertical: 8.w,

//                     horizontal: 12.w,
//                   ),
//                   child: isExpanded
//                       ? _ExpandedStatsContent(
//                           selection: selection,
//                           distance:
//                               widget.provider.raceFieldDetail!.race.distance,
//                         )
//                       : Text(
//                           "W: J: F: T:",
//                           style: medium(
//                             fontSize: 14.sp,
//                             color: AppColors.primary,
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     ),
//   );
// }

class _ExpandedStatsContent extends StatelessWidget {
  const _ExpandedStatsContent({
    required this.selection,
    required this.distance,
  });
  final Selection selection;
  final int distance;

  static String _formatStat(HorseStatsDetails value) {
    final runs = value.runs;
    final wins = value.wins;
    final seconds = value.seconds;
    final thirds = value.thirds;
    return '$runs : $wins-$seconds-$thirds';
  }

  @override
  Widget build(BuildContext context) {
    final stats = <String, HorseStatsDetails>{
      'Career': selection.horseStats.career,
      '1st Up': selection.horseStats.firstUp,
      '2nd Up': selection.horseStats.secondUp,
      '3rd Up': selection.horseStats.thirdUp,
      'Firm': selection.horseStats.firm,
      'Good': selection.horseStats.good,
      'Soft': selection.horseStats.soft,
      'Heavy': selection.horseStats.heavy,
    };

    // Boxes take only the needed height (no fixed row height).
    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = 10.w;
        final tileWidth = (constraints.maxWidth - (spacing * 2)) / 3;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final e in stats.entries)
              SizedBox(
                width: tileWidth,
                child: _statTile(label: e.key, value: _formatStat(e.value)),
              ),
          ],
        );
      },
    );
  }
}

Widget _statTile({required String label, required String value}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
    decoration: BoxDecoration(
      color: AppColors.primary.withValues(alpha: 0.03),
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.08)),
    ),
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: semiBold(fontSize: 11.sp, color: AppColors.primary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        4.w.verticalSpace,
        Text(
          value,
          style: semiBold(
            fontSize: 12.sp,
            color: AppColors.primary.withValues(alpha: 0.7),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/models/home/search_engine/tip_slip_model.dart';

class TipSlipItem extends StatelessWidget {
  const TipSlipItem({
    super.key,
    required this.tipSlip,
    required this.isExpanded,
    required this.onTap,
    required this.listPosition,
  });

  final TipSlipModel tipSlip;
  final bool isExpanded;
  final VoidCallback onTap;

  final int listPosition;

  //* Light “clean list” palette — soft greys, not solid black.
  static const Color _textPrimary = Color(0xFF424242);
  static const Color _textMuted = Color(0xFF757575);
  static const Color _border = Color(0xFFE0E0E0);
  static const Color _borderExpanded = Color(0xFFBDBDBD);
  static const Color _oddsBg = Color(0xFFEEEEEE);
  static const Color _expandedFill = Color(0xFFFAFAFA);

  @override
  Widget build(BuildContext context) {
    final selection = tipSlip.selection;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isExpanded ? _borderExpanded : _border,
          width: isExpanded ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(8.r),
        color: isExpanded ? _expandedFill : Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.fromLTRB(4.w, 10.w, 7.w, 10.w),
              child: Row(
                children: [
                  SizedBox(
                    width: context.isMobileWeb ? 32.w : 22.w,
                    child: Center(
                      child: Text(
                        '$listPosition.',
                        style: semiBold(
                          fontSize: context.isMobileWeb ? 26.sp : 14.sp,
                          color: _textMuted,
                        ),
                      ),
                    ),
                  ),
                  2.w.horizontalSpace,
                  _buildSilksOrPlaceholder(
                    silksImage: selection.silksImage,
                    number: selection.number,
                    context: context,
                  ),
                  8.w.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${selection.number}. ',
                              style: semiBold(
                                fontSize: context.isMobileWeb
                                    ? 32.sp
                                    : 16.sp,
                                color: _textPrimary,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${selection.horseName} (${selection.barrier})",
                                style: semiBold(
                                  fontSize: context.isMobileWeb
                                      ? 32.sp
                                      : 16.sp,
                                  color: _textPrimary,
                                  height: 1.2,
                                ),
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        4.w.verticalSpace,
                        Text(
                          '${selection.trackName} • R${selection.raceNumber} • ${selection.distance}m',
                          style: regular(
                            fontSize: context.isMobileWeb ? 26.sp : 13.sp,
                            color: _textMuted,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  4.5.w.horizontalSpace,
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => launchUnibetUrl(),
                    child: ImageWidget(
                      path: AppAssets.unibatLogo,
                      type: ImageType.asset,
                      height: 28.w,
                    ),
                  ),
                  6.w.horizontalSpace,

                  Text(
                      '\$${selection.unibetFixedOddsWin}',
                      style: bold(
                        fontSize: context.isMobileWeb ? 32.sp : 16.sp,
                        color: _textPrimary,
                      ),
                    ),
                  
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: isExpanded
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        height: 1,
                        color: _border,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: _oddsBg,
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(color: _border),
                              ),
                              child: Text(
                                selection.raceName,
                                style: medium(
                                  fontSize: context.isMobileWeb
                                      ? 24.sp
                                      : 12.sp,
                                  color: _textPrimary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            12.w.verticalSpace,
                            _buildDetailRow(
                              context: context,
                              icon: Icons.access_time,
                              label: 'Race Time',
                              value: DateFormatter.formatRaceDateTime(
                                selection.startTimeUtc.toIso8601String(),
                              ),
                            ),
                            8.w.verticalSpace,
                            _buildDetailRow(
                              context: context,
                              icon: Icons.person_outline,
                              label: 'Jockey',
                              value: selection.jockeyName,
                            ),
                            8.w.verticalSpace,
                            _buildDetailRow(
                              context: context,
                              icon: Icons.school_outlined,
                              label: 'Trainer',
                              value: selection.trainerName,
                            ),
                            8.w.verticalSpace,
                            // _buildDetailRow(
                            //   context: context,
                            //   icon: Icons.location_on_outlined,
                            //   label: 'Track',
                            //   value: selection.trackName,
                            // ),
                            12.w.verticalSpace,
                            Row(
                              children: [
                                Icon(
                                  Icons.bookmark_added_outlined,
                                  size: 13.sp,
                                  color: _textMuted,
                                ),
                                6.w.horizontalSpace,
                                Text(
                                  'Added ${_formatAddedTime(tipSlip.addedAt)}',
                                  style: regular(
                                    fontSize: context.isMobileWeb
                                        ? 22.sp
                                        : 11.sp,
                                    color: _textMuted,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // Shown before deleting a tip (e.g. swipe delete).
  static void showRemoveConfirmationDialog({
    required BuildContext context,
    required VoidCallback onConfirmRemove,
  }) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.white,
        content: Text(
          'Are you sure you want to remove this tip?',
          style: medium(fontSize: 18.sp, color: AppColors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('Cancel', style: medium(fontSize: 16.sp)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onConfirmRemove();
            },
            child: Text(
              'Yes',
              style: semiBold(fontSize: 16.sp, color: AppColors.red),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDetailRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: _textMuted,
        ),
        8.w.horizontalSpace,
        Text(
          '$label: ',
          style: semiBold(
            fontSize: context.isMobileWeb ? 24.sp : 12.sp,
            color: _textMuted,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: regular(
              fontSize: context.isMobileWeb ? 24.sp : 12.sp,
              color: _textPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  static String _formatAddedTime(DateTime addedAt) {
    final now = DateTime.now();
    final difference = now.difference(addedAt);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormatter.formatToIso(
        DateTime.parse(addedAt.toIso8601String()),
      );
    }
  }

  static Widget _buildSilksOrPlaceholder({
    required String silksImage,
    required int number,
    required BuildContext context,
  }) {
    final hasValidSilks = silksImage.trim().isNotEmpty;
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: _border,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.r),
        child: hasValidSilks
            ? ImageWidget(
                path: silksImage,
                type: ImageType.svg,
                errorWidget: _silksPlaceholder(number: number),
              )
            : _silksPlaceholder(number: number),
      ),
    );
  }

  static Widget _silksPlaceholder({required int number}) => Container(
    color: _expandedFill,
    alignment: Alignment.center,
    child: Text(
      '$number',
      style: semiBold(fontSize: 16.sp, color: _textMuted),
    ),
  );
}

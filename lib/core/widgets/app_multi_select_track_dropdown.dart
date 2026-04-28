import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/provider/home/search_engine/search_engine_provider.dart';

/// Multi-select tracks; API string comes from [SearchEngineProvider.trackFilterForApi].
class AppMultiSelectTrackDropdown extends StatelessWidget {
  const AppMultiSelectTrackDropdown({
    super.key,
    required this.items,
    required this.hintText,
    this.hintStyle,
    this.textStyle,
    this.borderRadius,
    this.margin,
    this.enabled,
  });

  final List<String> items;
  final String hintText;
  final TextStyle? hintStyle, textStyle;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchEngineProvider>();
    final controller = TextEditingController(text: provider.trackFilterForApi);

    return GestureDetector(
      onTap: (enabled ?? true) ? () => _showDropdownMenu(context) : null,
      child: AbsorbPointer(
        child: AppTextField(
          controller: controller,
          hintText: hintText,
          textStyle: textStyle,
          hintStyle: hintStyle,
          enabled: enabled ?? true,
          margin: margin,
          borderRadius: borderRadius,
          trailingIcon: AppAssets.arrowDown,
        ),
      ),
    );
  }

  Future<void> _showDropdownMenu(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox;
    final fieldSize = box.size;
    final fieldTopLeft = box.localToGlobal(Offset.zero);

    final screenH = MediaQuery.sizeOf(context).height;
    final screenW = MediaQuery.sizeOf(context).width;

    final top = fieldTopLeft.dy + fieldSize.height;
    final maxHeight = (screenH - top - 24).clamp(200.0, screenH * 0.55);
    final left = fieldTopLeft.dx.clamp(0.0, screenW - fieldSize.width);

    await showDialog<void>(
      context: context,
      barrierColor: Colors.transparent,
      useSafeArea: false,
      builder: (dialogContext) {
        return Material(
          color: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => Navigator.pop(dialogContext),
                  behavior: HitTestBehavior.opaque,
                ),
              ),
              Positioned(
                left: left,
                top: top,
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
                  color: AppColors.white,
                  child: Container(
                    width: fieldSize.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
                      color: AppColors.backGroundColor,
                      border: Border.all(
                        color: AppColors.primary.setOpacity(0.12),
                      ),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: maxHeight),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(top: 8.w),
                        child: Consumer<SearchEngineProvider>(
                          builder: (context, provider, _) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (provider.selectedTracks.isNotEmpty)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 12.w,
                                        bottom: 4.h,
                                      ),
                                      child: GestureDetector(
                                        onTap: () =>
                                            provider.clearSelectedTracks(),
                                        child: Text(
                                          'Clear all',
                                          style: medium(
                                            fontSize: 14.sp.clamp(12, 16),
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                _TrackListBody(
                                  provider: provider,
                                  textStyle: textStyle,
                                ),
                                8.w.verticalSpace,
                                horizontalDivider(),
                                8.w.verticalSpace,
                                TextButton(
                                  onPressed: () => dialogContext.pop(),
                                  child: Text(
                                    'Done',
                                    style: semiBold(
                                      fontSize: 16.sp.clamp(14, 18),
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Lists tracks: grouped (Metro → Regional) or one block if the API returned a flat list.
class _TrackListBody extends StatelessWidget {
  const _TrackListBody({required this.provider, this.textStyle});

  final SearchEngineProvider provider;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final metro = provider.metroTrackList;
    final regional = provider.regionalTrackList;
    final grouped = metro != null && regional != null;

    final namesForFlat = provider.trackList ?? [];
    if (!grouped && namesForFlat.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(20.w),
        child: Text(
          'No tracks available',
          style: medium(
            fontSize: 14.sp.clamp(14, 18),
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
        ),
      );
    }

    if (grouped && metro.isEmpty && regional.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(20.w),
        child: Text(
          'No tracks available',
          style: medium(
            fontSize: 14.sp.clamp(14, 18),
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
        ),
      );
    }

    final nameStyle =
        textStyle ??
        semiBold(
          fontSize: 15.sp.clamp(14, 17),
          color: AppColors.black,
          fontFamily: AppFontFamily.primary,
        );

    if (grouped) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (metro.isNotEmpty) ...[
              _SectionHeader(title: 'Metro'),
              ...metro.map(
                (name) => _TrackPickCard(
                  trackName: name,
                  nameStyle: nameStyle,
                  isSelected: provider.selectedTracks.contains(name),
                  onToggle: () => provider.toggleSelectedTrack(name),
                ),
              ),
            ],
            if (regional.isNotEmpty) ...[
              if (metro.isNotEmpty) 12.w.verticalSpace,
              _SectionHeader(title: 'Regional'),
              ...regional.map(
                (name) => _TrackPickCard(
                  trackName: name,
                  nameStyle: nameStyle,
                  isSelected: provider.selectedTracks.contains(name),
                  onToggle: () => provider.toggleSelectedTrack(name),
                ),
              ),
            ],
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final name in namesForFlat)
            _TrackPickCard(
              trackName: name,
              nameStyle: nameStyle,
              isSelected: provider.selectedTracks.contains(name),
              onToggle: () => provider.toggleSelectedTrack(name),
            ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 8.h),
      child: Text(
        title,
        style: semiBold(
          fontSize: 16.sp.clamp(14, 18),
          color: AppColors.black,
          fontFamily: AppFontFamily.primary,
        ),
      ),
    );
  }
}

/// One row: track name + region hint on the left; checkbox + chevron on the right (matches reference layout).
class _TrackPickCard extends StatelessWidget {
  const _TrackPickCard({
    required this.trackName,
    required this.nameStyle,
    required this.isSelected,
    required this.onToggle,
  });

  final String trackName;
  final TextStyle nameStyle;
  final bool isSelected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final subtitleColor = AppColors.primary.withValues(alpha: 0.45);

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.wSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.primary.setOpacity(0.12),
          ),
        ),
        child: InkWell(
          onTap: onToggle,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(trackName, style: nameStyle),
                    SizedBox(height: 2.wSize),
                    // 2.h.verticalSpace,
                    Text(
                      "AU",
                      style: regular(
                        fontSize: (kIsWeb) ? 12.fSize : 12.sp.clamp(11, 14),
                        color: subtitleColor,
                        fontFamily: AppFontFamily.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Checkbox(
                value: isSelected,
                checkColor: AppColors.white,
                activeColor: AppColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                onChanged: (_) => onToggle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

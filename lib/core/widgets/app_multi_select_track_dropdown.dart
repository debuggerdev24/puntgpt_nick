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

    // Panel opens under the field. Max height = space down to screen bottom (capped).
    final top = fieldTopLeft.dy + fieldSize.height;
    final maxHeight = (screenH - top - 16).clamp(120.0, 320.0);
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
                  elevation: 4,
                  borderRadius: BorderRadius.circular(borderRadius ?? 0),
                  color: AppColors.white,
                  child: Container(
                    width: fieldSize.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius ?? 0),
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.primary.setOpacity(0.1),
                      ),
                    ),
                    //* One scroll area: short list = short panel; long list = scroll inside maxHeight.
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: maxHeight),
                      child: SingleChildScrollView(
                        child: Consumer<SearchEngineProvider>(
                          builder: (context, provider, _) {
                            final selected = provider.selectedTracks;
                            final itemStyle =
                                textStyle ??
                                medium(
                                  fontSize: 16.sp.clamp(14, 18),
                                  color: AppColors.black,
                                );

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                12.w.verticalSpace,
                                if (selected.isNotEmpty)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () =>
                                          provider.clearSelectedTracks(),
                                      child: Text(
                                        'Clear all    ',
                                        style: medium(
                                          fontSize: 14.sp.clamp(12, 16),
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (items.isEmpty)
                                  Padding(
                                    padding: EdgeInsets.all(20.w),
                                    child: Text(
                                      'No tracks available',
                                      style: medium(
                                        fontSize: 14.sp.clamp(14, 18),
                                        color: AppColors.primary.withValues(
                                          alpha: 0.5,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  for (final item in items)
                                    InkWell(
                                      onTap: () =>
                                          provider.toggleSelectedTrack(item),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          12.w,0,12.w,12.w
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 24.w,
                                              height: 24.w,
                                              child: Checkbox(

                                                checkColor: AppColors.white,
                                                activeColor: AppColors.primary,
                                                value: selected.contains(item),
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                visualDensity:
                                                    VisualDensity.compact,
                                                onChanged: (_) => provider
                                                    .toggleSelectedTrack(item),
                                              ),
                                            ),
                                            8.w.horizontalSpace,
                                            Expanded(
                                              child: Text(
                                                item,
                                                style: itemStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                12.w.verticalSpace,
                                horizontalDivider(),
                                TextButton(
                                  onPressed: () => Navigator.pop(dialogContext),
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

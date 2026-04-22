import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/provider/home/story/story_provider.dart';

class UploadStoryData extends StatefulWidget {
  const UploadStoryData({super.key});

  @override
  State<UploadStoryData> createState() => _UploadStoryDataState();
}

class _UploadStoryDataState extends State<UploadStoryData> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _affiliateUrlController = TextEditingController();

  @override
  void dispose() {
    _displayNameController.dispose();
    _affiliateUrlController.dispose();
    super.dispose();
  }

  Future<void> _submit({required StoryProvider provider}) async {
    if (provider.isUpdatingStoryData) return;
    if (!provider.hasStoryDataDraft) return;

    provider.uploadStoryData(
      onSuccess: () {
        _displayNameController.clear();
        _affiliateUrlController.clear();
        AppToast.success(
          context: context,
          message: "Story data updated Successfully",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedSection = context.select<StoryProvider, String>(
      (p) => p.selectedStorySection,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppScreenTopBar(
          title: 'Upload Story Data',
          slogan: 'Update display name, URL and avatar',
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 24.w),
            child: Container(
              padding: EdgeInsets.all(16.w),

              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18.w),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Text(
                          'Section: ${selectedSection.toUpperCase()}',
                          style: semiBold(
                            fontSize: 12.fSize,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  18.w.verticalSpace,
                  AppTextField(
                    controller: _displayNameController,
                    onChanged: (v) => context
                        .read<StoryProvider>()
                        .setStoryDataDisplayName(v),
                    hintText: 'display_name (optional) - PuntGPT Pro',
                    borderRadius: 10.w,
                  ),
                  12.w.verticalSpace,
                  AppTextField(
                    controller: _affiliateUrlController,
                    onChanged: (v) => context
                        .read<StoryProvider>()
                        .setStoryDataAffiliateUrl(v),
                    keyboardType: TextInputType.url,
                    hintText: 'affiliate_url (optional) - https://new-link.com',
                    borderRadius: 10.w,
                  ),
                  18.w.verticalSpace,
                  Consumer<StoryProvider>(
                    builder: (context, provider, _) {
                      return Material(
                        color: AppColors.greyColor.withValues(alpha: 0.42),
                        borderRadius: BorderRadius.circular(12.w),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12.w),
                          onTap: provider.isPickingStoryDataAvatar
                              ? null
                              : provider.pickStoryDataAvatar,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 14.w,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  color: AppColors.primary,
                                  size: 22.wSize,
                                ),
                                10.w.horizontalSpace,
                                Expanded(
                                  child: Text(
                                    provider.storyDataAvatarFile == null
                                        ? 'Pick avatar (optional)'
                                        : provider.storyDataAvatarFile!.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: regular(
                                      fontSize: 13.fSize,
                                      color: AppColors.primary.withValues(
                                        alpha: 0.75,
                                      ),
                                    ),
                                  ),
                                ),
                                if (provider.isPickingStoryDataAvatar)
                                  SizedBox(
                                    width: 18.w,
                                    height: 18.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.primary,
                                    ),
                                  )
                                else if (provider.storyDataAvatarFile != null)
                                  InkWell(
                                    onTap: provider.clearStoryDataAvatar,
                                    child: Icon(
                                      Icons.close_rounded,
                                      size: 18.wSize,
                                      color: AppColors.primary.withValues(
                                        alpha: 0.75,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Consumer<StoryProvider>(
            builder: (context, provider, _) {
              final canSave =
                  provider.hasStoryDataDraft && !provider.isUpdatingStoryData;
              return AppFilledButton(
                margin: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 12.w),
                text: 'Save story data',
                onTap: canSave ? () => _submit(provider: provider) : () {},
                child: provider.isUpdatingStoryData
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.2,
                              color: AppColors.white,
                            ),
                          ),
                          8.w.horizontalSpace,
                          Text(
                            'Saving...',
                            style: semiBold(
                              fontSize: 14.fSize,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      )
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}

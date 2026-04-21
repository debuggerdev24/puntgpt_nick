import 'package:puntgpt_nick/core/app_imports.dart';

/// Admin: choose whether to update media content or story metadata.
class EditStoryOptionScreen extends StatelessWidget {
  const EditStoryOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppScreenTopBar(
          title: 'Edit story',
          slogan: 'Choose what you want to update',
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _EditOptionTile(
                  icon: Icons.perm_media_outlined,
                  title: 'Update story content',
                  subtitle: 'Upload or replace the image and video shown in the story.',
                  onTap: () =>
                      context.pushNamed(AppRoutes.uploadStoryContent.name),
                ),
                12.w.verticalSpace,
                _EditOptionTile(
                  icon: Icons.edit_note_rounded,
                  title: 'Update story data',
                  subtitle: 'Change thumbnail, links, name, and other story details.',
                  onTap: () =>
                      context.pushNamed(AppRoutes.uploadStoryData.name),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EditOptionTile extends StatelessWidget {
  const _EditOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16.w),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shadowColor: AppColors.primary.withValues(alpha: 0.08),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(18.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.greyColor.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: Icon(icon, size: 26.wSize, color: AppColors.primary),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: semiBold(fontSize: 16.fSize, color: AppColors.primary),
                    ),
                    4.w.verticalSpace,
                    Text(
                      subtitle,
                      style: regular(
                        fontSize: 13.fSize,
                        color: AppColors.primary.withValues(alpha: 0.55),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.primary.withValues(alpha: 0.35),
                size: 24.wSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

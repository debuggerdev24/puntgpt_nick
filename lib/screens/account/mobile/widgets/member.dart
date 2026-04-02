import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/models/account/lifetime_member_model.dart';
import 'package:url_launcher/url_launcher.dart';

class LifetimeMemberCard extends StatefulWidget {
  const LifetimeMemberCard({super.key, required this.member});

  final LifeTimeMember member;

  @override
  State<LifetimeMemberCard> createState() => _LifetimeMemberCardState();
}

class _LifetimeMemberCardState extends State<LifetimeMemberCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final fullName = '${m.firstName} ${m.lastName}'.trim();

    return Container(
      margin: EdgeInsets.only(bottom: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),

        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _initialAvatar(text: fullName),
                12.w.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName.isEmpty ? '—' : fullName,
                        style: semiBold(
                          fontSize: context.isBrowserMobile ? 26.sp : 16.sp,
                          color: AppColors.primary,
                          height: 1.2,
                        ),
                      ),
                      6.w.verticalSpace,
                      Wrap(
                        spacing: 10.w,
                        runSpacing: 8.w,
                        children: [
                          _pill(
                            context: context,
                            icon: Icons.mail_outline_rounded,
                            text: m.email,
                            onTap: () => _copy(
                              context,
                              value: m.email,
                              label: 'Email',
                            ),
                          ),
                          if (m.phone.trim().isNotEmpty)
                            _pill(
                              context: context,
                              icon: Icons.phone_outlined,
                              text: m.phone,
                              onTap: () => _copy(
                                context,
                                value: m.phone,
                                label: 'Phone',
                              ),
                            ),
                          if (m.state.trim().isNotEmpty)
                            _pill(
                              context: context,
                              icon: Icons.location_on_outlined,
                              text: m.state,
                              onTap: null,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                6.w.horizontalSpace,
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColors.primary.withValues(alpha: 0.55),
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              child: _expanded
                  ? Padding(
                      padding: EdgeInsets.only(top: 12.w),
                      child: Column(
                        children: [
                          Divider(
                            height: 1,
                            color: AppColors.primary.withValues(alpha: 0.1),
                          ),
                          12.w.verticalSpace,
                          _kv(
                            context,
                            label: 'Address line 1',
                            value: m.addressLine1,
                          ),
                          8.w.verticalSpace,
                          _kv(
                            context,
                            label: 'Address line 2',
                            value: m.addressLine2,
                          ),
                          8.w.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: _kv(
                                  context,
                                  label: 'Suburb',
                                  value: m.suburb,
                                ),
                              ),
                              10.w.horizontalSpace,
                              Expanded(
                                child: _kv(
                                  context,
                                  label: 'Post code',
                                  value: m.postCode,
                                ),
                              ),
                            ],
                          ),
                          8.w.verticalSpace,
                          _kv(context, label: 'Country', value: m.country),
                          14.w.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: _actionButton(
                                  context: context,
                                  icon: Icons.email_rounded,
                                  label: 'Email',
                                  onTap: () => _launchEmail(m.email),
                                ),
                              ),
                              10.w.horizontalSpace,
                              Expanded(
                                child: _actionButton(
                                  context: context,
                                  icon: Icons.call_rounded,
                                  label: 'Call',
                                  onTap: () => _launchCall(m.phone),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _initialAvatar({required String text}) {
    final t = text.trim();
    final initials = (t.isEmpty)
        ? 'LM'
        : t
            .split(RegExp(r'\s+'))
            .where((p) => p.isNotEmpty)
            .take(2)
            .map((p) => p[0].toUpperCase())
            .join();
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.06)),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: semiBold(
          fontSize: 14.sp,
          color: AppColors.primary.withValues(alpha: 0.75),
        ),
      ),
    );
  }

  Widget _pill({
    required BuildContext context,
    required IconData icon,
    required String text,
    required VoidCallback? onTap,
  }) {
    final clickable = onTap != null;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.w),
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.06)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: AppColors.primary.withValues(alpha: 0.55),
            ),
            6.w.horizontalSpace,
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.isBrowserMobile ? 240.w : 160.w,
              ),
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: medium(
                  fontSize: context.isBrowserMobile ? 20.sp : 12.sp,
                  color: clickable
                      ? AppColors.primary.withValues(alpha: 0.85)
                      : AppColors.primary.withValues(alpha: 0.7),
                ),
              ),
            ),
            if (clickable) ...[
              6.w.horizontalSpace,
              Icon(
                Icons.copy_rounded,
                size: 14.sp,
                color: AppColors.primary.withValues(alpha: 0.45),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _kv(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.isBrowserMobile ? 120.w : 90.w,
          child: Text(
            label,
            style: semiBold(
              fontSize: context.isBrowserMobile ? 20.sp : 12.sp,
              color: AppColors.primary.withValues(alpha: 0.55),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: regular(
              fontSize: context.isBrowserMobile ? 20.sp : 12.sp,
              color: AppColors.primary.withValues(alpha: 0.85),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.sp, color: AppColors.primary),
            8.w.horizontalSpace,
            Text(
              label,
              style: semiBold(
                fontSize: context.isBrowserMobile ? 20.sp : 12.sp,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copy(
    BuildContext context, {
    required String value,
    required String label,
  }) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    AppToast.success(context: context, message: "$label copied");
  }

  Future<void> _launchEmail(String email) async {
    final e = email.trim();
    if (e.isEmpty) return;
    final uri = Uri(scheme: 'mailto', path: e);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchCall(String phone) async {
    final p = phone.trim();
    if (p.isEmpty) return;
    final uri = Uri(scheme: 'tel', path: p);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}


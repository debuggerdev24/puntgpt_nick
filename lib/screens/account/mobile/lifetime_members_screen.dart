import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/models/account/lifetime_member_model.dart';
import 'package:puntgpt_nick/provider/subscription/subscription_provider.dart';
import 'package:puntgpt_nick/screens/account/mobile/widgets/member.dart';

class LifetimeMembersScreen extends StatefulWidget {
  const LifetimeMembersScreen({super.key});

  @override
  State<LifetimeMembersScreen> createState() => _LifetimeMembersScreenState();
}

class _LifetimeMembersScreenState extends State<LifetimeMembersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionProvider>(
      builder: (context, provider, child) {
        final members = provider.lifetimeMembers;
        final filtered = _filterMembers(members, _query);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppScreenTopBar(
              title: "Lifetime Members",
              slogan: "Manage lifetime access and member details.",
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.white,
                onRefresh: () =>
                    context.read<SubscriptionProvider>().getLifetimeMembers(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(18.w, 12.w, 18.w, 18.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (members == null)
                        _LifetimeMembersShimmer(context: context)
                      else ...[
                        _buildHeaderRow(
                          context: context,
                          total: members.length,
                        ),
                        12.w.verticalSpace,
                        _buildSearchField(context: context),
                        14.w.verticalSpace,
                        if (members.isEmpty)
                          _buildEmptyState(
                            context: context,
                            title: "No lifetime members",
                            subtitle:
                                "Once a member is added to the lifetime plan, they’ll appear here.",
                          )
                        else if (filtered!.isEmpty)
                          _buildEmptyState(
                            context: context,
                            title: "No matches found",
                            subtitle:
                                "Try searching by name, email, phone, or state.",
                          )
                        else
                          ...filtered.map(
                            (m) => LifetimeMemberCard(member: m),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<LifeTimeMember>? _filterMembers(
    List<LifeTimeMember>? members,
    String q,
  ) {
    if (members == null) return null;
    final query = q.trim().toLowerCase();
    if (query.isEmpty) return members;
    bool hit(String? s) => (s ?? '').toLowerCase().contains(query);

    return members
        .where(
          (m) =>
              hit(m.firstName) ||
              hit(m.lastName) ||
              hit(m.email) ||
              hit(m.phone) ||
              hit(m.state) ||
              hit(m.suburb) ||
              hit(m.postCode) ||
              hit(m.country),
        )
        .toList();
  }

  Widget _buildHeaderRow({required BuildContext context, required int? total}) {
    final countText = (total == null) ? '—' : total.toString();
    return Row(
      children: [
        Expanded(
          child: Text(
            "Members :",
            style: semiBold(
              fontSize: context.isMobileWeb ? 28.sp : 18.sp,
              color: AppColors.primary,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
          decoration: BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.06),
            ),
          ),
          child: Text(
            "$countText total",
            style: semiBold(
              fontSize: context.isMobileWeb ? 20.sp : 12.sp,
              color: AppColors.primary.withValues(alpha: 0.75),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField({required BuildContext context}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: AppColors.primary.withValues(alpha: 0.55),
            size: 18.sp,
          ),
          10.w.horizontalSpace,
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v),
              style: regular(
                fontSize: context.isMobileWeb ? 22.sp : 14.sp,
                color: AppColors.primary,
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: "Search name, email, phone, state…",
                hintStyle: regular(
                  fontSize: context.isMobileWeb ? 22.sp : 14.sp,
                  color: AppColors.primary.withValues(alpha: 0.45),
                ),
              ),
            ),
          ),
          if (_query.trim().isNotEmpty)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _searchController.clear();
                setState(() => _query = '');
              },
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: Icon(
                  Icons.close_rounded,
                  size: 18.sp,
                  color: AppColors.primary.withValues(alpha: 0.55),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.admin_panel_settings_rounded,
                  size: context.isMobileWeb ? 50.sp : 34.sp,
                  color: AppColors.primary.withValues(alpha: 0.55),
                ),
              ),
              12.w.verticalSpace,
              Text(
                title,
                textAlign: TextAlign.center,
                style: semiBold(
                  fontSize: context.isMobileWeb ? 28.sp : 18.sp,
                  fontFamily: AppFontFamily.secondary,
                  color: AppColors.primary,
                ),
              ),
              8.w.verticalSpace,
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: regular(
                  fontSize: context.isMobileWeb ? 22.sp : 13.sp,
                  color: AppColors.primary.withValues(alpha: 0.65),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LifetimeMembersShimmer extends StatelessWidget {
  const _LifetimeMembersShimmer({required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    final isWide = context.isMobileWeb;
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: isWide ? 22.h : 18.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              12.w.horizontalSpace,
              Container(
                width: isWide ? 100.w : 88.w,
                height: isWide ? 30.h : 26.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ],
          ),
          12.w.verticalSpace,
          Container(
            width: double.infinity,
            height: isWide ? 48.h : 44.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.06),
              ),
            ),
          ),
          14.w.verticalSpace,
          ...List.generate(
            6,
            (i) => Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  12.w.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: isWide ? 200.w : 160.w,
                          height: isWide ? 18.h : 14.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        10.h.verticalSpace,
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.w,
                          children: [
                            _pillShimmer(isWide: isWide, w: 140.w),
                            _pillShimmer(isWide: isWide, w: 100.w),
                            _pillShimmer(isWide: isWide, w: 72.w),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pillShimmer({required bool isWide, required double w}) {
    return Container(
      width: w,
      height: isWide ? 30.h : 26.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

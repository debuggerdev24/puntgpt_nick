import 'package:puntgpt_nick/core/app_imports.dart';

class ChatBubbleWeb extends StatelessWidget {
  const   ChatBubbleWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(17, 18.w, 24.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "@you",
            style: semiBold(fontSize: 12),//fontSize: context.isDesktop ? 14.sp : 22.sp
          ),
          Text(
            "12:41 PM",
            style: semiBold(
              fontSize: 12,//context.isDesktop ? 12.sp : 22.sp,
              color: AppColors.primary.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 3),
          Text(
            "mdsndjkjvdjkvbdjkfvbdf c mnbbnxmnfklfjkfjkdm,nnm,nbm,cnvm,bncmnbmcb",
            style: regular(fontSize:14),
          ),
          SizedBox(height: 16),
          horizontalDivider(opacity: 0.15),
        ],
      ),
    );
  }
}

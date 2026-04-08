import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/models/punt_club/club_chat_message_model.dart';

/// A single chat message bubble in Punter Club chat (visual parity with [ChatBubble] / Ask PuntGPT).
/// Selection highlight is drawn by the parent as a full-width row (WhatsApp-style).
class ClubChatMessageBubble extends StatelessWidget {
  const ClubChatMessageBubble({
    super.key,
    required this.message,
    required this.isOwnMessage,
  });

  final ClubChatMessageModel message;
  final bool isOwnMessage;

  @override
  Widget build(BuildContext context) {
    final maxW = MediaQuery.sizeOf(context).width * 0.88;

    final fill = !isOwnMessage
        ? AppColors.greyColor
        : const Color(0xFF1C1C1C);
    final border = !isOwnMessage
        ? AppColors.primary.withValues(alpha: 0.3)
        : AppColors.white.withValues(alpha: 0.15);
    final labelColor = !isOwnMessage
        ? AppColors.primary.withValues(alpha: 0.9)
        : AppColors.white.withValues(alpha: 0.8);
    final timeColor = !isOwnMessage
        ? AppColors.primary.withValues(alpha: 0.45)
        : AppColors.white.withValues(alpha: 0.7);
    final msgColor = !isOwnMessage ? AppColors.primary : AppColors.white;
    final editedColor = !isOwnMessage
        ? AppColors.primary.withValues(alpha: 0.5)
        : AppColors.white.withValues(alpha: 0.5);

    final borderRadius = isOwnMessage
        ? const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(4),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          );

    final senderLabel =
        isOwnMessage ? '@you' : '@${message.senderUsername}';

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: (context.isBrowserMobile) ? 35.w : 16.w,
        // vertical: 4.w,
      ),
      child: Column(
        crossAxisAlignment: isOwnMessage
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Align(
            alignment:
                isOwnMessage ? Alignment.centerRight : Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxW),
              child: Container(
                decoration: BoxDecoration(
                  color: fill,
                  borderRadius: borderRadius,
                  border: Border.all(color: border, width: 1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 8.w,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            senderLabel,
                            style: semiBold(
                              fontSize: context.isBrowserMobile
                                  ? 32.sp
                                  : 16.sp,
                              color: labelColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          DateFormatter.formatTimeOnly(message.createdAt),
                          style: regular(
                            fontSize: context.isBrowserMobile ? 22.sp : 11.sp,
                            color: timeColor,
                          ),
                        ),
                        if (message.isEdited)
                          Text(
                            '(edited)',
                            style: regular(
                              fontSize: context.isBrowserMobile ? 22.sp : 12.sp,
                              color: editedColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                    5.w.verticalSpace,
                    Text(
                      message.content,
                      style: regular(
                        fontSize: context.isBrowserMobile ? 30.sp : 15.sp,
                        color: msgColor,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/models/punt_club/club_chat_message_model.dart';

/// A single chat message bubble in Punter Club chat.
/// Shows sender, content, timestamp, and edit/delete actions for own messages (within 15 min).
class ClubChatMessageBubble extends StatelessWidget {
  const ClubChatMessageBubble({
    super.key,
    required this.message,
    required this.isOwnMessage,
    required this.onEdit,
    required this.onDelete,
  });

  final ClubChatMessageModel message;
  final bool isOwnMessage;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        (context.isBrowserMobile) ? 35.w : 25.w,
        12.h,
        25.w,
        0,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '@${message.senderUsername}',
                    style: semiBold(
                      fontSize: context.isBrowserMobile ? 32.sp : 18.sp,
                    ),
                  ),
                  8.w.horizontalSpace,
                  Text(
                    DateFormatter.formatTimeOnly(message.createdAt),
                    style: semiBold(
                      fontSize: context.isBrowserMobile ? 26.5.sp : 14.sp,
                      color: AppColors.primary.withValues(alpha: 0.6),
                    ),
                  ),
                  if (message.isEdited) ...[
                    SizedBox(width: 6.w),
                    Text(
                      '(edited)',
                      style: regular(
                        fontSize: context.isBrowserMobile ? 22.sp : 12.sp,
                        color: AppColors.primary.withValues(alpha: 0.5),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
              2.5.w.verticalSpace,
              Text(
                message.content,
                style: regular(
                  fontSize: context.isBrowserMobile ? 32.sp : 16.sp,
                ),
              ),
              6.w.verticalSpace,
              horizontalDivider(),
            ],
          ),
          //* Edit/Delete: only for own messages, within 15 min (message.canEdit)
          if(isOwnMessage && message.canEdit)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 4),
              child: PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.more_vert_rounded,
                  size: (context.isBrowserMobile) ? 28.w : 18.w,
                  color: AppColors.primary.withValues(alpha: 0.6),
                ),
                onSelected: (v) {
                  if (v == 'edit') onEdit();
                  if (v == 'delete') onDelete();
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ),
          // if(isOwnMessage && message.canEdit)
          // Positioned(
          //   top: 0,
          //   right: 0,
          //   child:
          // ),
        ],
      ),
    );
  }
}

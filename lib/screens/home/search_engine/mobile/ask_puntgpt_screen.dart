import 'package:flutter/material.dart';
import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/provider/bot/bot_provider.dart';
import 'package:puntgpt_nick/screens/home/search_engine/mobile/widgets/chat_section.dart';
import 'package:puntgpt_nick/screens/home/search_engine/mobile/widgets/home_section_shimmers.dart';

class AskPuntGptScreen extends StatefulWidget {
  const AskPuntGptScreen({super.key});

  @override
  State<AskPuntGptScreen> createState() => _AskPuntGptScreenState();
}

class _AskPuntGptScreenState extends State<AskPuntGptScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(BotProvider provider) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    provider.sendMessage(text).then((_) => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    if (!context.isMobileView) {
      context.pop();
    }
    return Consumer<BotProvider>(
      builder: (context, provider, child) {
        if (provider.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppToast.error(
              context: context,
              message: provider.errorMessage!,
            );
            provider.clearError();
          });
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topBar(context),
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.only(bottom: 80.h),
                    itemCount:
                        provider.messages.length + (provider.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < provider.messages.length) {
                        return ChatSection(message: provider.messages[index]);
                      }
                      return HomeSectionShimmers.chatMessageShimmer(context: context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          horizontalDivider(),
                          TextField(
                            controller: _controller,
                            enabled: !provider.isLoading,
                            onSubmitted: (_) => _sendMessage(provider),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: provider.isLoading
                                    ? null
                                    : () => _sendMessage(provider),
                                icon: Icon(
                                  Icons.send_rounded,
                                  size: 24.w,
                                ),
                              ),
                              prefix: 25.w.horizontalSpace,
                              hintText: "Type your message...",
                              hintStyle: medium(
                                fontStyle: FontStyle.italic,
                                fontSize:
                                    (context.isBrowserMobile) ? 24.sp : 14.sp,
                                color: AppColors.primary.withValues(alpha: 0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget topBar(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(5.w, 12.h, 25.w, 12.h),
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios_rounded, size: 16.h),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ask @PuntGPT",
                    style: regular(
                      fontFamily: AppFontFamily.secondary,
                      fontSize: context.isBrowserMobile ? 40.sp : 20,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    "Chat with AI",
                    style: medium(
                      fontSize: (context.isBrowserMobile) ? 28.sp : 14.sp,
                      color: AppColors.primary.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        horizontalDivider(),
      ],
    );
  }
}

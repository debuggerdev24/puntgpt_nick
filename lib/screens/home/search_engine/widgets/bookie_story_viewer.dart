import 'package:better_player_plus/better_player_plus.dart';
import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/models/home/search_engine/bookie_story_item.dart';
import 'package:url_launcher/url_launcher.dart';

/// Full-screen story: swipe sideways between partners, tap the ad image for the
/// affiliate link, swipe down or tap X to close. Returns the last page index.
class BookieStoryViewer extends StatefulWidget {
  const BookieStoryViewer({
    super.key,
    required this.stories,
    this.initialIndex = 0,
  });

  final List<BookieStoryItem> stories;
  final int initialIndex;

  @override
  State<BookieStoryViewer> createState() => _BookieStoryViewerState();
}

class _BookieStoryViewerState extends State<BookieStoryViewer> {
  late final PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    final last = widget.stories.length - 1;
    final start = last < 0 ? 0 : widget.initialIndex.clamp(0, last);
    _currentPage = start;
    _pageController = PageController(initialPage: start);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _closeAndReturnLastPage() {
    Navigator.of(context).pop(_currentPage);
  }

  Future<void> _openAffiliateLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  //*
  // First story (PuntGPT, `id: puntgpt`): open Manage Subscription instead of a URL.
  void _onStoryImageTap(BookieStoryItem story) {
    if (story.id == 'puntgpt') {
      final routeName = (context.isMobileView && kIsWeb)
          ? WebRoutes.manageSubscriptionScreen.name
          : AppRoutes.manageSubscriptionScreen.name;
      Navigator.of(context).pop(_currentPage);
      Future.microtask(() {
        (kIsWeb ? WebRouter.router : AppRouter.router).pushNamed(routeName);
      });
      return;
    }
    final url = story.affiliateUrl;
    if (url.isEmpty) return;
    _openAffiliateLink(url);
  }

  @override
  Widget build(BuildContext context) {
    final stories = widget.stories;
    if (stories.isEmpty) return const SizedBox.shrink();

    return Material(
      color: Colors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SegmentProgressRow(
              pageCount: stories.length,
              currentPage: _currentPage,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      stories[_currentPage].displayName,
                      style: bold(fontSize: 15, color: AppColors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: _closeAndReturnLastPage,
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: stories.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, i) {
                  final story = stories[i];
                  final isActive = i == _currentPage;
                  final videoPath = story.storyVideoAsset;
                  if (videoPath != null && videoPath.isNotEmpty) {
                    return _StoryVideoPage(
                      story: story,
                      videoAssetPath: videoPath,
                      isActive: isActive,
                      onTapImage: () => _onStoryImageTap(story),
                      onSwipeDown: _closeAndReturnLastPage,
                    );
                  }
                  return _StoryAdPage(
                    imageAsset: story.storyImageAsset,
                    onTapImage: () => _onStoryImageTap(story),
                    onSwipeDown: _closeAndReturnLastPage,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// White bars at the top: filled up to and including the active page.
class _SegmentProgressRow extends StatelessWidget {
  const _SegmentProgressRow({
    required this.pageCount,
    required this.currentPage,
  });

  final int pageCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: Row(
        children: List.generate(pageCount, (i) {
          final isDoneOrActive = i <= currentPage;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  color: isDoneOrActive ? Colors.white : Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// One fullscreen ad: tap opens URL; fling down closes the viewer.
class _StoryAdPage extends StatelessWidget {
  const _StoryAdPage({
    required this.imageAsset,
    required this.onTapImage,
    required this.onSwipeDown,
  });

  final String imageAsset;
  final VoidCallback onTapImage;
  final VoidCallback onSwipeDown;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        final v = details.primaryVelocity ?? 0;
        if (v > 300) onSwipeDown();
      },
      child: Center(
        child: GestureDetector(
          onTap: onTapImage,
          child: Image.asset(
            imageAsset,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

/// Plays a bundled story video when possible; otherwise shows [BookieStoryItem.storyImageAsset].
class _StoryVideoPage extends StatefulWidget {
  const _StoryVideoPage({
    required this.story,
    required this.videoAssetPath,
    required this.isActive,
    required this.onTapImage,
    required this.onSwipeDown,
  });

  final BookieStoryItem story;
  final String videoAssetPath;
  final bool isActive;
  final VoidCallback onTapImage;
  final VoidCallback onSwipeDown;

  @override
  State<_StoryVideoPage> createState() => _StoryVideoPageState();
}

class _StoryVideoPageState extends State<_StoryVideoPage> {
  BetterPlayerController? _player;
  bool _ready = false;
  bool _useImageFallback = false;

  @override
  void initState() {
    super.initState();
    _bootstrapBetterPlayer();
  }

  String _videoExtension(String path) {
    final i = path.lastIndexOf('.');
    if (i < 0 || i >= path.length - 1) return 'mp4';
    return path.substring(i + 1).toLowerCase();
  }

  void _onBetterPlayerEvent(BetterPlayerEvent event) {
    if (!mounted) return;
    switch (event.betterPlayerEventType) {
      case BetterPlayerEventType.exception:
        Logger.error('Story BetterPlayer exception: ${event.parameters}');
        _player?.dispose(forceDispose: true);
        _player = null;
        setState(() {
          _ready = false;
          _useImageFallback = true;
        });
        return;
      case BetterPlayerEventType.initialized:
        if (widget.isActive) {
          _player?.play();
        }
        return;
      default:
        return;
    }
  }

  Future<void> _bootstrapBetterPlayer() async {
    if (kIsWeb) {
      if (mounted) setState(() => _useImageFallback = true);
      return;
    }
    try {
      final data = await rootBundle.load(widget.videoAssetPath);
      final bytes = data.buffer
          .asUint8List(data.offsetInBytes, data.lengthInBytes)
          .toList();
      if (!mounted) return;

      final config = BetterPlayerConfiguration(
        autoPlay: false,
        looping: true,
        // [fit] only applies inside the player’s box. [expandToFill] makes that box fill the parent;
        // otherwise the player stays small and cover looks like it “does nothing”.
        fit: BoxFit.cover,
        expandToFill: true,
        handleLifecycle: true,
        eventListener: _onBetterPlayerEvent,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          showControls: false,
          showControlsOnInitialize: false,
          enableFullscreen: true,
          enableMute: false,
          enableProgressBar: false,
          enablePlayPause: false,
          enableSkips: false,
          enableOverflowMenu: false,
          enablePip: false,
          enableRetry: false,
          enablePlaybackSpeed: false,
          enableSubtitles: false,
          enableQualities: false,
          enableAudioTracks: false,
        ),
      );

      final source = BetterPlayerDataSource.memory(
        bytes,
        videoExtension: _videoExtension(widget.videoAssetPath),
        notificationConfiguration: const BetterPlayerNotificationConfiguration(
          showNotification: false,
        ),
      );

      _player = BetterPlayerController(
        config,
        betterPlayerDataSource: source,
      );
      setState(() => _ready = true);

      if (widget.isActive) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _player?.play();
        });
      }
    } catch (e, st) {
      Logger.error('Story video failed to load: $e\n$st');
      if (!mounted) return;
      setState(() => _useImageFallback = true);
    }
  }

  Future<void> _applyPlayPauseForVisibility() async {
    final p = _player;
    if (p == null) return;
    if (widget.isActive) {
      await p.seekTo(Duration.zero);
      await p.play();
    } else {
      await p.pause();
    }
  }

  @override
  void didUpdateWidget(covariant _StoryVideoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive && _player != null) {
      _applyPlayPauseForVisibility();
    }
  }

  @override
  void dispose() {
    _player?.dispose(forceDispose: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_useImageFallback) {
      return _StoryAdPage(
        imageAsset: widget.story.storyImageAsset,
        onTapImage: widget.onTapImage,
        onSwipeDown: widget.onSwipeDown,
      );
    }
    if (!_ready || _player == null) {
      return GestureDetector(
        onVerticalDragEnd: (details) {
          final v = details.primaryVelocity ?? 0;
          if (v > 300) widget.onSwipeDown();
        },
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white54),
        ),
      );
    }

    return GestureDetector(
      onVerticalDragEnd: (details) {
        final v = details.primaryVelocity ?? 0;
        if (v > 300) widget.onSwipeDown();
      },
      child: GestureDetector(
        onTap: widget.onTapImage,
        behavior: HitTestBehavior.opaque,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                const ColoredBox(color: Colors.black),
                SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: BetterPlayer(controller: _player!),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
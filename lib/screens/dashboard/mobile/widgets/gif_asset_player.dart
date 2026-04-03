import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GifAssetPlayer extends StatefulWidget {
  const GifAssetPlayer({
    super.key,
    required this.assetPath,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.filterQuality = FilterQuality.medium,
    this.fallback,
  });

  final String assetPath;
  final double? height;
  final double? width;
  final BoxFit fit;
  final FilterQuality filterQuality;
  final Widget? fallback;

  @override
  State<GifAssetPlayer> createState() => _GifAssetPlayerState();
}

class _GifAssetPlayerState extends State<GifAssetPlayer>
    with SingleTickerProviderStateMixin {
  List<ui.Image>? _images;
  List<int>? _durationsMs;
  int _totalMs = 0;
  AnimationController? _controller;
  bool _loadFailed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    ui.Codec? codec;
    final images = <ui.Image>[];
    final durations = <int>[];
    try {
      final ByteData data = await rootBundle.load(widget.assetPath);
      final Uint8List bytes = data.buffer.asUint8List();
      codec = await ui.instantiateImageCodec(bytes);
      final int n = codec.frameCount;
      for (var i = 0; i < n; i++) {
        final ui.FrameInfo frame = await codec.getNextFrame();
        images.add(frame.image);
        var ms = frame.duration.inMilliseconds;
        if (ms <= 0) ms = 100;
        durations.add(ms);
      }
    } catch (_) {
      for (final img in images) {
        img.dispose();
      }
      if (!mounted) return;
      setState(() => _loadFailed = true);
      return;
    } finally {
      codec?.dispose();
    }

    if (!mounted) {
      for (final img in images) {
        img.dispose();
      }
      return;
    }

    final int total = durations.fold<int>(0, (a, b) => a + b);
    final int totalMs = total > 0 ? total : 100;

    _controller?.dispose();
    _controller = null;

    if (images.length > 1) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: totalMs),
      )..repeat();
    }

    setState(() {
      _images = images;
      _durationsMs = durations;
      _totalMs = totalMs;
    });
  }

  int _frameIndex(double animationValue) {
    final durations = _durationsMs;
    if (durations == null || durations.isEmpty) return 0;
    final total = _totalMs;
    if (total <= 0) return 0;
    var t = (animationValue * total).floor();
    if (t >= total) t = total - 1;
    if (t < 0) t = 0;
    var acc = 0;
    for (var i = 0; i < durations.length; i++) {
      acc += durations[i];
      if (t < acc) return i;
    }
    return durations.length - 1;
  }

  @override
  void dispose() {
    _controller?.dispose();
    for (final img in _images ?? <ui.Image>[]) {
      img.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loadFailed) {
      return widget.fallback ?? const SizedBox.shrink();
    }
    final images = _images;
    if (images == null || images.isEmpty) {
      return SizedBox(
        height: widget.height,
        width: widget.width,
        child: widget.fallback,
      );
    }

    final Widget content = _controller != null
        ? AnimatedBuilder(
            animation: _controller!,
            builder: (context, _) {
              final idx = _frameIndex(_controller!.value);
              return RawImage(
                image: images[idx],
                fit: widget.fit,
                filterQuality: widget.filterQuality,
              );
            },
          )
        : RawImage(
            image: images.first,
            fit: widget.fit,
            filterQuality: widget.filterQuality,
          );

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: content,
    );
  }
}

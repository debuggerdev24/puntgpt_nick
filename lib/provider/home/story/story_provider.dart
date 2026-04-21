import 'package:image_picker/image_picker.dart';
import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/models/home/story/story_model.dart';
import 'package:puntgpt_nick/services/story/story_api_service.dart';

class StoryProvider extends ChangeNotifier {
  List<StoryModel>? _stories;
  List<StoryModel>? get stories => _stories;

  final ImagePicker _imagePicker = ImagePicker();

  XFile? _storyContentImageFile;
  Uint8List? _storyContentImageBytes;
  XFile? _storyContentVideoFile;
  int? _storyContentVideoSizeBytes;
  bool _busyStoryImage = false;
  bool _busyStoryVideo = false;
  bool _isUploadingStoryContent = false;

  XFile? get storyContentImageFile => _storyContentImageFile;
  Uint8List? get storyContentImageBytes => _storyContentImageBytes;
  XFile? get storyContentVideoFile => _storyContentVideoFile;
  int? get storyContentVideoSizeBytes => _storyContentVideoSizeBytes;
  bool get isPickingStoryImage => _busyStoryImage;
  bool get isPickingStoryVideo => _busyStoryVideo;
  bool get isUploadingStoryContent => _isUploadingStoryContent;

  bool get hasStoryContentImage =>
      _storyContentImageBytes != null && _storyContentImageBytes!.isNotEmpty;
  bool get hasStoryContentVideo =>
      _storyContentVideoFile?.name.isNotEmpty ?? false;

  String storyContentVideoSizeLabel() {
    final b = _storyContentVideoSizeBytes;
    if (b == null) return '';
    if (b < 1024) return '$b B';
    if (b < 1024 * 1024) return '${(b / 1024).toStringAsFixed(1)} KB';
    return '${(b / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Future<void> pickStoryImage(ImageSource source) async {
    if (_busyStoryImage) return;
    _busyStoryImage = true;
    notifyListeners();
    try {
      final x = await _imagePicker.pickImage(
        source: source,
        maxWidth: 4096,
        maxHeight: 4096,
        imageQuality: 88,
      );
      if (x == null) return;
      final bytes = await x.readAsBytes();
      _storyContentImageFile = x;
      _storyContentImageBytes = bytes;
    } finally {
      _busyStoryImage = false;
      notifyListeners();
    }
  }

  Future<void> pickStoryVideo() async {
    if (_busyStoryVideo) return;
    _busyStoryVideo = true;
    notifyListeners();
    try {
      final x = await _imagePicker.pickVideo(source: ImageSource.gallery);
      if (x == null) return;
      final len = await x.length();
      _storyContentVideoFile = x;
      _storyContentVideoSizeBytes = len;
    } finally {
      _busyStoryVideo = false;
      notifyListeners();
    }
  }

  void clearStoryContentImage() {
    _storyContentImageFile = null;
    _storyContentImageBytes = null;
    notifyListeners();
  }

  void clearStoryContentVideo() {
    _storyContentVideoFile = null;
    _storyContentVideoSizeBytes = null;
    notifyListeners();
  }

  Future<void> getStories() async {
    _stories = null;
    notifyListeners();
    final response = await StoryApiService.instance.getStories();
    response.fold(
      (l) {
        Logger.error(l.errorMsg);
      },
      (r) {
        _stories = (r).map((e) => StoryModel.fromJson(e)).toList();
        notifyListeners();
        Logger.info("Stories loaded: ${_stories?.length}");
      },
    );
  }

  /// Submits selected draft image/video to the API (payload TBD).
  Future<void> uploadStoryContent() async {
    if (_isUploadingStoryContent) return;
    if (!hasStoryContentImage && !hasStoryContentVideo) return;

    _isUploadingStoryContent = true;
    notifyListeners();
    try {
      final data = <String, dynamic>{
        'section': 'section',
        'media_type': 'media_type',
        'file': 'media_url',
      };
      final response = await StoryApiService.instance.updateStoryContent(data: data);
      response.fold(
        (l) {
          Logger.error(l.errorMsg);
        },
        (r) {
          Logger.info('Media uploaded: $r');
        },
      );
    } finally {
      _isUploadingStoryContent = false;
      notifyListeners();
    }
  }

  Future<void> updateStorySection() async {
    final response = await StoryApiService.instance.updateStorySection(section: "section", data: {});
    response.fold(
      (l) {
        Logger.error(l.errorMsg);
      },
      (r) {
        Logger.info("Story section updated: $r");
      },
    );
  }
}

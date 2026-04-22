import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/models/home/story/story_model.dart';
import 'package:puntgpt_nick/services/story/story_api_service.dart';

class StoryProvider extends ChangeNotifier {
  static const List<String> allowedStorySections = <String>[
    'puntgpt',
    'unibet',
    'dabble',
  ];

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
  bool _isUpdatingStoryData = false;
  bool _isPickingStoryDataAvatar = false;
  String _selectedStorySection = allowedStorySections.first;
  String _storyDataDisplayName = '';
  String _storyDataAffiliateUrl = '';
  XFile? _storyDataAvatarFile;

  XFile? get storyContentImageFile => _storyContentImageFile;
  Uint8List? get storyContentImageBytes => _storyContentImageBytes;
  XFile? get storyContentVideoFile => _storyContentVideoFile;
  int? get storyContentVideoSizeBytes => _storyContentVideoSizeBytes;
  bool get isPickingStoryImage => _busyStoryImage;
  bool get isPickingStoryVideo => _busyStoryVideo;
  bool get isUploadingStoryContent => _isUploadingStoryContent;
  bool get isUpdatingStoryData => _isUpdatingStoryData;
  bool get isPickingStoryDataAvatar => _isPickingStoryDataAvatar;
  String get selectedStorySection => _selectedStorySection;
  String get storyDataDisplayName => _storyDataDisplayName;
  String get storyDataAffiliateUrl => _storyDataAffiliateUrl;
  XFile? get storyDataAvatarFile => _storyDataAvatarFile;

  bool get hasStoryContentImage =>
      _storyContentImageBytes != null && _storyContentImageBytes!.isNotEmpty;
  bool get hasStoryContentVideo =>
      _storyContentVideoFile?.name.isNotEmpty ?? false;
  bool get hasStoryDataDraft =>
      _storyDataDisplayName.trim().isNotEmpty ||
      _storyDataAffiliateUrl.trim().isNotEmpty ||
      _storyDataAvatarFile != null;

  void selectStorySection(String section) {
    if (!allowedStorySections.contains(section)) return;
    if (_selectedStorySection == section) return;
    _selectedStorySection = section;
    notifyListeners();
  }

  void setStoryDataDisplayName(String value) {
    if (_storyDataDisplayName == value) return;
    _storyDataDisplayName = value;
    notifyListeners();
  }

  void setStoryDataAffiliateUrl(String value) {
    if (_storyDataAffiliateUrl == value) return;
    _storyDataAffiliateUrl = value;
    notifyListeners();
  }

  Future<void> pickStoryDataAvatar() async {
    if (_isPickingStoryDataAvatar) return;
    _isPickingStoryDataAvatar = true;
    notifyListeners();
    try {
      final file = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 90,
      );
      if (file == null) return;
      _storyDataAvatarFile = file;
    } finally {
      _isPickingStoryDataAvatar = false;
      notifyListeners();
    }
  }

  void clearStoryDataAvatar() {
    if (_storyDataAvatarFile == null) return;
    _storyDataAvatarFile = null;
    notifyListeners();
  }

  void clearStoryDataDraft() {
    _storyDataDisplayName = '';
    _storyDataAffiliateUrl = '';
    _storyDataAvatarFile = null;
    notifyListeners();
  }

  String storyContentVideoSizeLabel() {
    final b = _storyContentVideoSizeBytes;
    if (b == null) return '';
    if (b < 1024) return '$b B';
    if (b < 1024 * 1024) return '${(b / 1024).toStringAsFixed(1)} KB';
    return '${(b / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Future<void> pickStoryFile() async {
    if (_busyStoryImage || _busyStoryVideo) return;
    _busyStoryImage = true;
    _busyStoryVideo = true;
    notifyListeners();
    try {
      final x = await _imagePicker.pickMedia();
      if (x == null) return;
      final path = x.path.toLowerCase();
      final isImage =
          path.endsWith('.jpg') ||
          path.endsWith('.jpeg') ||
          path.endsWith('.png') ||
          path.endsWith('.webp') ||
          path.endsWith('.gif') ||
          path.endsWith('.heic');

      if (isImage) {
        final bytes = await x.readAsBytes();
        _storyContentImageFile = x;
        _storyContentImageBytes = bytes;
        _storyContentVideoFile = null;
        _storyContentVideoSizeBytes = null;
        return;
      }

      final len = await x.length();
      _storyContentVideoFile = x;
      _storyContentVideoSizeBytes = len;
      _storyContentImageFile = null;
      _storyContentImageBytes = null;
    } finally {
      _busyStoryImage = false;
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
        Logger.info("Stories: ${_stories?[0].title}");
        Logger.info("Stories: ${_stories?[0].imageAdsList.length}");
        Logger.info("Stories: ${_stories?[0].videoAdsList.length}");
        notifyListeners();
      },
    );
  }

  //* Submits selected draft image/video to the API (payload TBD).
  Future<void> uploadStoryContent({required VoidCallback onSuccess}) async {
    if (_isUploadingStoryContent) return;
    if (!hasStoryContentImage && !hasStoryContentVideo) return;

    _isUploadingStoryContent = true;
    notifyListeners();
    try {
      final section = _selectedStorySection;
      final isImage = _storyContentImageFile != null;
      final selectedFile = isImage
          ? _storyContentImageFile
          : _storyContentVideoFile;
      if (selectedFile == null) return;

      final storyContent = FormData.fromMap({
        "section": section,
        "media_type": isImage ? "image" : "video",
        "file": await MultipartFile.fromFile(
          selectedFile.path,
          filename: selectedFile.name,
        ),
      });

      final response = await StoryApiService.instance.uploadStoryContent(
        data: storyContent,
      );
      response.fold((l) => Logger.error(l.errorMsg), (r) {
        Logger.info("Upload Success");
        _storyContentImageFile = null;
        _storyContentImageBytes = null;
        _storyContentVideoFile = null;
        _storyContentVideoSizeBytes = null;
        getStories();
        onSuccess();
      });
    } finally {
      _isUploadingStoryContent = false;
      notifyListeners();
    }
  }

  Future<void> uploadStoryData({required VoidCallback onSuccess}) async {
    if (_isUpdatingStoryData) return;
    if (!hasStoryDataDraft) return;

    _isUpdatingStoryData = true;
    notifyListeners();
    try {
      final data = <String, dynamic>{};
      if (_storyDataDisplayName.trim().isNotEmpty) {
        data["display_name"] = _storyDataDisplayName.trim();
      }
      if (_storyDataAffiliateUrl.trim().isNotEmpty) {
        data["affiliate_url"] = _storyDataAffiliateUrl.trim();
      }
      if (_storyDataAvatarFile != null) {
        data["avatar"] = await MultipartFile.fromFile(
          _storyDataAvatarFile!.path,
          filename: _storyDataAvatarFile!.name,
        );
      }

      final response = await StoryApiService.instance.updateStorySection(
        section: _selectedStorySection,
        data: FormData.fromMap(data),
      );


      response.fold(
        (l) {
          Logger.error(l.errorMsg); 
        },
        (r) {
          Logger.info("Story data updated: $r");
          clearStoryDataDraft();
          onSuccess();
          getStories();
        },
      );
    } finally {
      _isUpdatingStoryData = false;
      notifyListeners();
    }
  }
}
/*
    

*/
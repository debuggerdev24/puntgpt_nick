class StoryModel {
  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
    id: json["section"],
    title: json["display_name"],
    logo: json["avatar"],
    affiliateUrl: json["affiliate_url"],

    videoAdsList: json["storyVideoAssets"],
    imageAdsList: json["storyImageAssets"],
  );
  StoryModel({
    required this.id,
    required this.title,

    required this.affiliateUrl,
    required this.logo,
    required this.videoAdsList,
    required this.imageAdsList,
  });
  final String id, title, logo, affiliateUrl;
  List<dynamic> videoAdsList, imageAdsList;

  int get slideCount {
    if (imageAdsList.isEmpty) return 0;
    final nImages = imageAdsList.length;
    final nVideos = videoAdsList.length;
    if (nVideos > nImages) return nVideos;
    return nImages;
  }
}

/// Returns the starting flat PageView index for a given story channel.
/// It sums slide counts of all channels before [channelIndex].
int flatSlideIndexForChannel(List<StoryModel> stories, int channelIndex) {
  var sum = 0;
  for (var i = 0; i < channelIndex && i < stories.length; i++) {
    sum += stories[i].slideCount;
  }
  return sum;
}

//* Partner ids touched between two flat slide indices (inclusive).
Set<String> channelIdsInFlatPageRange(
  List<StoryModel> stories,
  int flatA,
  int flatB,
) {
  final lo = flatA < flatB ? flatA : flatB;
  final hi = flatA < flatB ? flatB : flatA;
  final ids = <String>{};
  var flat = 0;
  for (final s in stories) {
    final len = s.slideCount;
    final start = flat;
    final end = flat + len - 1;
    if (end >= lo && start <= hi) {
      ids.add(s.id);
    }
    flat += len;
  }
  return ids;
}
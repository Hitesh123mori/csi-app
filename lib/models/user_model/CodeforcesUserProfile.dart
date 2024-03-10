class CodeforcesUserProfile {
  final String handle;
  final int rating;
  final String rank;
  final int maxRating;
  final String maxRank;

  CodeforcesUserProfile({
    required this.handle,
    required this.rating,
    required this.rank,
    required this.maxRating,
    required this.maxRank,
  });

  factory CodeforcesUserProfile.fromJson(Map<String, dynamic> json) {
    return CodeforcesUserProfile(
      handle: json['handle'] ?? '',
      rating: json['rating'] ?? 0,
      rank: json['rank'] ?? '',
      maxRating: json['maxRating'] ?? 0,
      maxRank: json['maxRank'] ?? '',
    );
  }
}

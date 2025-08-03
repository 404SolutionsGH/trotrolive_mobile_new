import 'package:intl/intl.dart';

class Story {
  final String headline;
  final String brief;
  final String url;
  final String source;
  final int author;
  final DateTime publishedAt;

  Story({
    required this.headline,
    required this.brief,
    required this.url,
    required this.source,
    required this.author,
    required this.publishedAt,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      headline: json['headline'] as String,
      brief: json['brief'] as String,
      url: json['url'] as String,
      source: json['source'] as String,
      author: int.tryParse(json['author'].toString()) ?? 0,
      publishedAt: DateTime.parse(json['published_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'headline': headline,
      'brief': brief,
      'url': url,
      'source': source,
      'author': author.toString(), // Convert back to string if needed
      'published_at': publishedAt.toIso8601String(),
    };
  }
}

class StoryResponse {
  final List<Story> stories;

  StoryResponse({required this.stories});

  factory StoryResponse.fromJson(Map<String, dynamic> json) {
    return StoryResponse(
      stories: (json['stories'] as List)
          .map((storyJson) => Story.fromJson(storyJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stories': stories.map((story) => story.toJson()).toList(),
    };
  }
}

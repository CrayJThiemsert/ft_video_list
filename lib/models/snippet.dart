import 'package:equatable/equatable.dart';
import 'package:ft_video_list/models/thumbnails.dart';

class Snippet extends Equatable {
  final String publishedAt;
  final String channelId;
  final String title;
  final String description;
  final Thumbnails thumbnails;
  final String channelTitle;
  final String liveBroadcastContent;

  const Snippet({this.publishedAt, this.channelId, this.title, this.description,
      this.thumbnails, this.channelTitle, this.liveBroadcastContent});

  @override
  List<Object> get props => [publishedAt, channelId, title, description, thumbnails, channelTitle, liveBroadcastContent];

  factory Snippet.fromJson(Map<String, dynamic> parsedJson){
    return Snippet(
      publishedAt: parsedJson['publishedAt'],
      channelId: parsedJson['channelId'],
      title: parsedJson['title'],
      description: parsedJson['description'],
      thumbnails: Thumbnails.fromJson(parsedJson['thumbnails']),
      channelTitle: parsedJson['channelTitle'],
      liveBroadcastContent: parsedJson['liveBroadcastContent'],
    );
  }

  @override
  String toString() {
    return 'Snippet{publishedAt: $publishedAt, channelId: $channelId, title: $title, description: $description, thumbnails: $thumbnails, channelTitle: $channelTitle, liveBroadcastContent: $liveBroadcastContent}';
  }
}

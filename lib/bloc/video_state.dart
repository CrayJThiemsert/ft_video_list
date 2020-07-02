import 'package:equatable/equatable.dart';
import 'package:ft_video_list/models/items.dart';


abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoFailure extends VideoState {}

class VideoSuccess extends VideoState {
  final List<Item> items;
  final bool hasReachedMax;

  const VideoSuccess({
    this.items,
    this.hasReachedMax,
  });

  VideoSuccess copyWith({
    List<Item> items,
    bool hasReachedMax,
  }) {
    return VideoSuccess(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax];

  @override
  String toString() =>
      'VideoSuccess { items: ${items.length}, hasReachedMax: $hasReachedMax }';
}

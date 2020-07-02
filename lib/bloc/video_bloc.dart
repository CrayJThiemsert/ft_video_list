import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ft_video_list/models/snippet.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'package:ft_video_list/bloc/bloc.dart';
import 'package:ft_video_list/models/models.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final http.Client httpClient;

  VideoBloc({@required this.httpClient});

  @override
  // TODO: implement initialState
  VideoState get initialState => VideoInitial();

  @override
  Stream<Transition<VideoEvent, VideoState>> transformEvents(
      Stream<VideoEvent> events,
      TransitionFunction<VideoEvent, VideoState> transitionFn,
      ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    final currentState = state;
    if(event is VideoFetched && !_hasReachedMax(currentState)) {
      try {
        if(currentState is VideoInitial) {
          final items = await _fetchYoutubeVideos();
          debugPrint('items.length=${items.length}');

          yield VideoSuccess(items: items, hasReachedMax: false);
          return;
        }

        if (currentState is VideoSuccess) {
          final items = await _fetchYoutubeVideos();
          yield items.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : VideoSuccess(
                items: items, // (no need to append list in this app )
                hasReachedMax: true,
              );
//          yield items.isEmpty
//              ? currentState.copyWith(hasReachedMax: true)
//              : VideoSuccess(
//                items: currentState.items + items, // (use to append list in app )
//                hasReachedMax: false,
//              );
        }
      } catch(_) {
        yield VideoFailure();
      }

    }
    yield null;
  }

  bool _hasReachedMax(VideoState state) =>
      state is VideoSuccess && state.hasReachedMax;

  /**
   * Fetch video list from fixed url
   */
  Future<List<Item>> _fetchYoutubeVideos() async {
    String srcUrl = 'https://s3-ap-southeast-1.amazonaws.com/ysetter/media/video-search.json';

    final response = await http.Client().get(srcUrl);

    if (response.statusCode == 200) {
      // This causes the Dart http client to decode the body as Latin-1 instead of utf-8.
      final data = json.decode(utf8.decode(response.bodyBytes));
//      debugPrint('${data["items"].toString()}');

      List<Item> items = data["items"]?.map<Item>((rawItem) {
//        debugPrint('kind=>${rawItem['kind']}');
        return Item.fromJson(rawItem);
        // For test debug mutile json layer.
//          kind: rawItem['kind'],
//          id: Id.fromJson(rawItem['id']),
//          snippet: Snippet.fromJson(rawItem['snippet']),
//
//
//        );
      }).toList();
      debugPrint('items.length=${items.length}');

      return items;
    } else {
      throw Exception('error fetching posts');
    }
  }
}

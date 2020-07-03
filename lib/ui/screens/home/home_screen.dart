import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_video_list/bloc/bloc.dart';
import 'package:ft_video_list/ui/screens/home/widgets/bottom_loader.dart';
import 'package:ft_video_list/ui/screens/home/widgets/video_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  VideoBloc _videoBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _videoBloc = BlocProvider.of<VideoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        if (state is VideoInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is VideoFailure) {
          return Center(
            child: Text('failed to fetch items'),
          );
        }
        if (state is VideoSuccess) {
          if (state.items.isEmpty) {
            return Center(
              child: Text('no items'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.items.length
                  ? BottomLoader()
                  : VideoWidget(item: state.items[index]);
            },
            itemCount: state.hasReachedMax
                ? state.items.length
                : state.items.length + 1,
            controller: _scrollController,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _videoBloc.add(VideoFetched());
    }
  }
}
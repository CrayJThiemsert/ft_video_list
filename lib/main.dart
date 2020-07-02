import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ft_video_list/models/default.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_video_list/bloc/bloc.dart';
import 'package:octo_image/octo_image.dart';

import 'models/items.dart';
import 'models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';


void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {
//    final items = _fetchYoutubeVideos();
    return MaterialApp(
      title: 'Flutter Infinite Scroll',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Bloc Posts'),
        ),
        body: BlocProvider(
          create: (context) =>
          VideoBloc(httpClient: http.Client())..add(VideoFetched()),
          child: HomePage(),
        ),
      ),
    );
  }
}

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

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class VideoWidget extends StatelessWidget {
  final Item item;

  const VideoWidget({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
//      leading: OctoImage(
//        image: CachedNetworkImageProvider(
//            item.snippet.thumbnails.p_default.url),
//        placeholderBuilder: OctoPlaceholder.blurHash(
//          'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
//        ),
//        errorBuilder: OctoError.icon(color: Colors.red),
//        fit: BoxFit.cover,
//      ),
//      leading: Image.network(item.snippet.thumbnails.p_default.url,fit: BoxFit.cover,
//        loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
//          if (loadingProgress == null) return child;
//          return Center(
//            child: CircularProgressIndicator(
//              value: loadingProgress.expectedTotalBytes != null ?
//              loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
//                  : null,
//            ),
//          );
//        },
//      ),

        // Still freeze when error 404
//        leading: getImageByURL(item.snippet.thumbnails.p_default.url),

//        leading: CachedNetworkImage(
//          imageUrl: item.snippet.thumbnails.p_default.url,
//          progressIndicatorBuilder: (context, url, downloadProgress) =>
//              CircularProgressIndicator(value: downloadProgress.progress),
//          errorWidget: (context, url, error) => Icon(Icons.error),
//        ),

//      leading: FadeInImage.assetNetwork(image: item.snippet.thumbnails.p_default.url, placeholder:  'assets/icons/live_tv-black-24dp.svg',),

      // Can load, but not good handle missing image
      leading: Image(
        image: NetworkImageWithRetry(item.snippet.thumbnails.p_default.url),
      ),

    // Display text only
//      leading: Text(
//        '${item.id.kind}',
//        style: TextStyle(fontSize: 10.0),
//      ),
      title: Text(item.snippet.title.isEmpty ? '' : item.snippet.title),
      isThreeLine: true,
      subtitle: Text(item.kind),
      dense: true,
    );
  }

  Widget getImageByURL(String url) {
    try {
      return CachedNetworkImage(
        useOldImageOnUrlChange: true,
        imageUrl: url,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) {
          return Icon(Icons.error);
        },
      );
    } catch (e) {
      return Icon(Icons.error);
    }
  }

  Widget _customImage(String url) {
    return SizedBox(
      height: 150,
      child: OctoImage(
        image: CachedNetworkImageProvider(url),
        progressIndicatorBuilder: (context, progress) {
          double value;
          if (progress != null && progress.expectedTotalBytes != null) {
            value =
                progress.cumulativeBytesLoaded / progress.expectedTotalBytes;
          }
          return CircularProgressIndicator(value: value);
        },
        errorBuilder: (context, error, stacktrace) => Icon(Icons.error),
      ),
    );
  }
}






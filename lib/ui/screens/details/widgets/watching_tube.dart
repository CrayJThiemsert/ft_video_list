import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:ft_video_list/models/models.dart';
import 'package:ft_video_list/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
class WatchingTube extends StatefulWidget {
  final Item item;
  final Size size;

  const WatchingTube({Key key, @required this.size, this.item})
      : super(key: key);

  @override
  _WatchingTubeState createState() => _WatchingTubeState(size: this.size, item: this.item);
}

class _WatchingTubeState extends State<WatchingTube> implements YouTubePlayerListener {
  final Item item;
  final Size size;

  _WatchingTubeState({Key key, @required this.size, this.item})
      : super();

  double _currentVideoSecond = 0.0;
  String _playerState = "";
  FlutterYoutubeViewController _controller;

  @override
  void onCurrentSecond(double second) {
    print("onCurrentSecond second = $second");
    _currentVideoSecond = second;
  }

  @override
  void onError(String error) {
    print("onError error = $error");
  }

  @override
  void onReady() {
    print("onReady");
  }

  @override
  void onStateChange(String state) {
    print("onStateChange state = $state");
    setState(() {
      _playerState = state;
    });
  }

  @override
  void onVideoDuration(double duration) {
    print("onVideoDuration duration = $duration");
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    this._controller = controller;
  }

  void _loadOrCueVideo() {
    _controller.loadOrCueVideo('mfqJyKm20Z4', _currentVideoSecond);
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
      padding:
          const EdgeInsets.only(bottom: kDefaultPadding, top: kDefaultPadding),
      child: SizedBox(
        height: (size.height * 0.35) + kDefaultPadding,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                icon: SvgPicture.asset('assets/icons/back_arrow.svg'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
//            Container(
//              height: size.height * 0.3,
//              width: size.width * 0.95,
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.all(Radius.circular(3)),
//                boxShadow: [
//                  BoxShadow(
//                    offset: Offset(0, 10),
//                    blurRadius: 30,
//                    color: kGreyColor.withOpacity(0.29),
//                  )
//                ],
//                image: DecorationImage(
//                  alignment: Alignment.center,
//                  fit: BoxFit.contain,
//                  image: NetworkImageWithRetry(
//                      item.snippet.thumbnails.p_default.url),
//                ),
//              ),
//            ),
            Container(
                height: size.height * 0.3,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 30,
                      color: kGreyColor.withOpacity(0.29),
                    )
                  ],
                ),
                child: FlutterYoutubeView(
                  onViewCreated: _onYoutubeCreated,
                  listener: this,
                  scaleMode: YoutubeScaleMode.fitWidth,
                  params: YoutubeParam(
                    videoId: item.id.videoId, //'mfqJyKm20Z4',
                    showUI: true,
                    startSeconds: 5 * 60.0,
                    showYoutube: true,
                    showFullScreen: true,
                  ),
                )),
          ],
        ),
      ),
      ),
    );
  }
}

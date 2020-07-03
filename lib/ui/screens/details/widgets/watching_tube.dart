import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:ft_video_list/models/models.dart';
import 'package:ft_video_list/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WatchingTube extends StatelessWidget {
  final Item item;
  const WatchingTube({Key key, @required this.size, this.item})
      : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                image: DecorationImage(
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  image: NetworkImageWithRetry(
                      item.snippet.thumbnails.p_default.url),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ft_video_list/utils/constants.dart';

class TitleAndDescription extends StatelessWidget {
  const TitleAndDescription({
    Key key,
    this.title,
    this.description,
    this.publishedWhen,
  }) : super(key: key);

  final String title, description;
  final String publishedWhen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(children: [
              TextSpan(
                text: '${title}\n',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: kTextColor, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${description}\n',
                  style: TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${publishedWhen}',
                    style: TextStyle(
                      fontSize: 12,
                      color: kTextColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

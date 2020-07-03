import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_video_list/models/models.dart';
import 'package:ft_video_list/utils/constants.dart';
import 'package:ft_video_list/utils/string_utils.dart';
import 'watching_tube.dart';
import 'title_and_description.dart';


class Body extends StatelessWidget {
  final Item item;

  const Body({this.item});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          WatchingTube(size: size, item: item,),
          TitleAndDescription(
            title: StringUtils().verifyString(item.snippet.title, '-'),
            description: StringUtils().verifyString(item.snippet.description, '-'),
            publishedWhen: StringUtils().printShortDateTime(item.snippet.publishedAt, '-'),
          ),
          SizedBox(height: kDefaultPadding),
//          Row(
//            children: [
//              SizedBox(
//                width: size.width / 2,
//                height: 84,
//                child: FlatButton(
//                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
//                  color: kPrimaryColor,
//                  onPressed: () {},
//                  child: Text(
//                    'Buy Now',
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 16,
//                    ),
//                  ),
//                ),
//              ),
//              Expanded(
//                child: FlatButton(
//                  onPressed: () {},
//                  child: Text('Description'),
//                ),
//              )
//            ],
//          ),
          SizedBox(
            height: kDefaultPadding * 2,
          )
        ],
      ),
    );
  }
}







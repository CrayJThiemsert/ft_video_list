import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:ft_video_list/models/models.dart';
import 'package:ft_video_list/ui/screens/details/details_screen.dart';
import 'package:ft_video_list/ui/widgets/dialog_widget.dart';

class VideoWidget extends StatelessWidget {
  final Item item;

  const VideoWidget({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Can load, but not good handle missing image
      leading: Image(
        image: NetworkImageWithRetry(item.snippet.thumbnails.p_default.url),
      ),

      title: Text(item.snippet.title.isEmpty ? '' : item.snippet.title),
      isThreeLine: true,
      subtitle: Text(item.kind),
      dense: true,
      onTap: () {
        debugPrint('tap -> [${item.snippet.title}]');
//        DialogUtils().showMessageDialog(context, 'Message', '${item.snippet.title}', 'Close');
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(item: item)));
      },
    );
  }

}
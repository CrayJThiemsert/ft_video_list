import 'package:flutter/material.dart';
import 'package:ft_video_list/models/items.dart';
import 'package:ft_video_list/ui/screens/details/widgets/body.dart';

class DetailsScreen extends StatelessWidget {
  final Item item;
  const DetailsScreen({this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(item: item),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ft_video_list/ui/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_video_list/bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {
//    final items = _fetchYoutubeVideos();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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












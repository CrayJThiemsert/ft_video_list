import 'package:equatable/equatable.dart';

class Default extends Equatable {
  final String url;
  final int width;
  final int height;

  const Default({this.url, this.width, this.height});

  @override
  List<Object> get props => [url, width, height];

  factory Default.fromJson(Map<String, dynamic> parsedJson){
    return Default(
        url: parsedJson['url'],
        width: parsedJson['width'],
        height: parsedJson['height'],
    );
  }

  @override
  String toString() {
    return 'Default{url: $url, width: $width, height: $height}';
  }
}

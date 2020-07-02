import 'package:equatable/equatable.dart';
import 'package:ft_video_list/models/default.dart';

class Thumbnails extends Equatable {
  final Default p_default;
  final Default medium;
  final Default high;

  const Thumbnails({this.p_default, this.medium, this.high});

  @override
  List<Object> get props => [p_default, medium, high];

  factory Thumbnails.fromJson(Map<String, dynamic> parsedJson){
    return Thumbnails(
        p_default: Default.fromJson(parsedJson['default']),
        medium: Default.fromJson(parsedJson['medium']),
        high: Default.fromJson(parsedJson['high']),
    );
  }

  @override
  String toString() {
    return 'Thumbnails{p_default: $p_default, medium: $medium, high: $high}';
  }

}

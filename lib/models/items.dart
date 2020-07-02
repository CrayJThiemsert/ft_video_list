import 'package:equatable/equatable.dart';
import 'package:ft_video_list/models/snippet.dart';
import 'id.dart';


class Item extends Equatable {
  final String kind;
  final String etag;
  final Id id;
  final Snippet snippet;

  const Item({this.kind, this.etag, this.id, this.snippet});

  @override
  List<Object> get props => [kind, etag, id, snippet];

  factory Item.fromJson(Map<String, dynamic> parsedJson){
    return Item(
        kind: parsedJson['kind'],
        etag: parsedJson['etag'],
        id: Id.fromJson(parsedJson['id']),
        snippet: Snippet.fromJson(parsedJson['snippet'])
    );
  }

  @override
  String toString() {
    return 'Item{kind: $kind, id: $id}';
  }
}

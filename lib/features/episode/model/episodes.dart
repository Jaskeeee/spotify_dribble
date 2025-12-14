import 'package:spotify_dribble/features/episode/model/episode.dart';

class Episodes {
  final int limit;
  final int offset;
  final int total;
  final String next;
  final String previous;
  final List<Episode> episodes;
  Episodes({
    required this.limit,
    required this.next,
    required this.previous,
    required this.offset,
    required this.total,
    required this.episodes,
  });
  factory Episodes.fromJson(Map<String,dynamic> json){
    return Episodes(
      limit: json["limit"], 
      next: json["next"],
      previous: json["previous"], 
      offset: json["offset"], 
      total: json["total"], 
      episodes: (json["items"] as List<dynamic>).map((json)=>Episode.fromJson(json)).toList()
    );
  }
}
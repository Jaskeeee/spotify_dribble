import 'package:spotify_dribble/core/models/image_model.dart';
import 'package:spotify_dribble/core/player/domain/model/resume_point.dart';
import 'package:spotify_dribble/features/show/domain/model/show_simplified.dart';

class Episode {
  final String id;
  final String name;
  final String uri;
  final String description;
  final bool explicit;
  final bool isPlayable;
  final int durationMs;
  final String type;
  final List<ImageModel> images;
  final ResumePoint? resumePoint;
  final ShowSimplified show;
  final String releaseDate;
  final String releaseDatePrecision;
  Episode({
    required this.id,
    required this.name,
    required this.description,
    required this.durationMs,
    required this.explicit,
    required this.images,
    required this.type,
    required this.uri,
    required this.isPlayable,
    required this.releaseDate,
    required this.show,
    required this.resumePoint,
    required this.releaseDatePrecision,
  });
  factory Episode.fromJson(Map<String,dynamic> json){
    return Episode(
      id:json["id"], 
      name: json["name"], 
      uri: json["uri"],
      description: json["description"], 
      durationMs: json["duration_ms"], 
      explicit: json["explicit"], 
      resumePoint:json["resume_point"]!=null?ResumePoint.fromJson(json["resume_point"]):ResumePoint(fullyPlayed: false, resumePositionMs:0),
      images: (json["images"] as List<dynamic>).map((json)=>ImageModel.fromJson(json)).toList(), 
      isPlayable: json["is_playable"], 
      releaseDate: json["release_date"], 
      type: json["type"],
      show: ShowSimplified.fromJson(json["show"]),
      releaseDatePrecision: json["release_date_precision"]
    );
  }
}
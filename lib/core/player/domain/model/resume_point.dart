class ResumePoint {
  final bool fullyPlayed;
  final int resumePositionMs;
  ResumePoint({
    required this.fullyPlayed,
    required this.resumePositionMs
  });
  factory ResumePoint.fromJson(Map<String,dynamic> json){
    return ResumePoint(
      fullyPlayed: json["fully_played"], 
      resumePositionMs: json["resume_position_ms"]
    );
  }
}
import 'package:spotify_dribble/features/track/domain/model/track.dart';

sealed class TrackStates {}
class TrackInitial extends TrackStates{}
class TrackLoaded extends TrackStates{
  final List<Track> tracks;
  TrackLoaded({
    required this.tracks
  });
}
class TrackLoading extends TrackStates{}
class TrackError extends TrackStates{
  final String message;
  TrackError({
    required this.message
  });
}
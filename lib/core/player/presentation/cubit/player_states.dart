import 'package:spotify_dribble/core/player/domain/model/playback_state.dart';

sealed class PlayerStates{}
class PlayerInitial extends PlayerStates{}
class PlayerLoading extends PlayerStates{}
class PlayerError extends PlayerStates{
  final String message;
  PlayerError({required this.message});
}
class PlayerLoaded extends PlayerStates{
  final PlaybackState? playbackState;
  PlayerLoaded({this.playbackState});
}
import 'package:spotify_dribble/features/track/domain/model/track.dart';

abstract class TrackRepo {
  Future<Track> getTrack({required String id});
  Future<List<Track>> getUserSavedTracks({int? limit,int? offset});
  Future<List<bool>> checkUserSavedTracks({required List<String> ids});
}
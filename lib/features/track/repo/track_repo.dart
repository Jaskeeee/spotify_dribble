import 'package:spotify_dribble/features/track/model/track_simplified.dart';

abstract class TrackRepo {
  Future<Track> getTrack({required String id});
  
}
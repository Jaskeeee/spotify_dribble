import 'package:spotify_dribble/features/episode/domain/model/episode.dart';

abstract class EpisodeRepo {
  Future<Episode> getEpisode({required String id});
}
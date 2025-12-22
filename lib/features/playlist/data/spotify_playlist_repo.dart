import 'dart:convert';

import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/constants/api_constants.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/features/playlist/model/playlist.dart';
import 'package:spotify_dribble/features/playlist/model/playlist_simplified.dart';

class SpotifyPlaylistRepo {
  final ApiClient _apiClient = ApiClient();

  Future<Playlist> getPlaylist({required String playlistId})async{
    try{
      final playlist = await _apiClient.get(
        endpoint: "$basePlaylistEndpoint/$playlistId", 
        fromJson: (json)=>Playlist.fromJson(json)
      );
      if(playlist==null){
        throw SpotifyAPIError(message: "Failed to Fetch User Playlist");
      }
      return playlist;
    }
    catch(e){
      throw SpotifyAPIError(message: e.toString());
    }
  }

  Future<List<PlaylistSimplified>>getUserPlaylists({required String userId,int? limit,int? offset})async{
    try{
      final playlistList = await _apiClient.get(
        endpoint: "/v1/users/$userId/playlists", 
        fromJson: (json)=>(json["items"]as List<dynamic>)
      );
      if(playlistList==null){
        throw SpotifyAPIError(message: "Failed to Fetch User Playlists!");
      }
      return playlistList.map((json)=>PlaylistSimplified.fromJson(json)).toList();
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }



}
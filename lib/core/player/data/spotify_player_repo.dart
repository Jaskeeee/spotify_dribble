import 'dart:async';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/constants/api_constants.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/core/player/domain/model/device.dart';
import 'package:spotify_dribble/core/player/domain/model/playback_state.dart';
import 'package:spotify_dribble/core/player/domain/model/player_enums.dart';
import 'package:spotify_dribble/core/player/domain/repo/player_repo.dart';
import 'package:spotify_dribble/features/track/domain/model/track.dart';

class SpotifyPlayerRepo implements PlayerRepo {
  final ApiClient _apiClient = ApiClient();
  @override
  Future<List<Device>> getavailableDevices() async {
    try {
      final List<dynamic>? data = await _apiClient.get(
        endpoint: "$basePlayerEndpoint/devices",
        fromJson: (json) => (json["devices"] as List<dynamic>),
      );
      return data!.map((json) => Device.fromJson(json)).toList();
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  Future<void> playbackCaller(Duration callDelay)async{
    Timer.periodic(callDelay,(timer)async{
      await getPlaybackState();
    });
  }

  @override
  Future<PlaybackState?> getPlaybackState()async{
    try{
      print("Playback state called");
      final PlaybackState? playbackState = await _apiClient.get(
        endpoint: basePlayerEndpoint, 
        fromJson: (json)=>PlaybackState.fromJson(json)
      );
      return playbackState;
    }catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }

  Future<void> checkSpotifyd()async{
    try{
      final result = await Process.run('systemctl', ['--user','is-active','spotifyd.service']);
      if(result.exitCode==0){
        print("lmao nerd it's active, get a fucking life you retard");
      }else{
        Process.run("systemctl",['--user','start','spotifyd.service']);
      }
    }catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }

  Future<void> stopSpotifyd()async{
    try{
      print("terminating spotifyd");
      await Process.run('systemctl', ['--user','stop','spotifyd.service']);
    }catch(e){
      throw SpotifyError(message: e.toString());
    }
  }

  @override
  Future<void> syncDevice()async{
    try{
      await checkSpotifyd();
      Process.run('systemctl',['--user','start','spotifyd.service']);
      final PlaybackState? playbackState = await getPlaybackState();
      final List<Device> devices = await getavailableDevices();
      final String deviceName= dotenv.get("SPOTIFY_DEVICE_NAME");
      if(playbackState==null){
        for(var device in devices){
          if(device.name==deviceName){
            try{
              await transferPlayback(deviceIds:[device.id],play:false);
            }catch(e){
              Process.run("systemctl", ['--user','restart','spotifyd.service']);
              await syncDevice();
            }
          }
        }      
      }
    }
    catch(e){
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> next({String? deviceId}) async {
    try {
      // await syncDevice();
      final String? queryParameters = deviceId != null
          ? Uri(queryParameters: {"device_id": deviceId}).query
          : null;
      await _apiClient.post(
        endpoint: "$basePlayerEndpoint/next",
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> pause({String? deviceId}) async {
    try {
      await syncDevice();
      final String? queryParameters = deviceId != null
          ? Uri(queryParameters: {"device_id": deviceId}).query
          : null;
      await _apiClient.put(
        endpoint: '$basePlayerEndpoint/pause',
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> previous({String? deviceId}) async {
    try {
      // await syncDevice();
      final String? queryParameters = deviceId != null
          ? Uri(queryParameters: {"device_id": deviceId}).query
          : null;
      await _apiClient.post(
        endpoint: '$basePlayerEndpoint/previous',
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> repeatMode({
    String? deviceId,
    required String state,
  }) async {
    try {
      // await syncDevice();
      final String queryParameters = Uri(
        queryParameters: deviceId != null
            ? {"device_id": deviceId, "state": state}
            : {"state": state},
      ).query;
      await _apiClient.put(
        endpoint: "$basePlayerEndpoint/repeat",
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> resume({String? deviceId}) async {
    try {
      // await syncDevice();
      final String? queryParameters = deviceId != null
          ? Uri(queryParameters: {"device_id": deviceId}).query
          : null;
      await _apiClient.put(
        endpoint: '$basePlayerEndpoint/play',
        queryParameters: queryParameters,
        extraheaders:apiHeader,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> seek({String? deviceId, required int positionMs}) async {
    try {
      // await syncDevice();
      final String queryParameters = Uri(
        queryParameters: deviceId != null
            ? {"device_id": deviceId, "position_ms": positionMs.toString()}
            : {"position_ms": positionMs.toString()},
      ).query;
      await _apiClient.put(
        endpoint: '$basePlayerEndpoint/seek',
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> shuffle({String? deviceId, required bool state}) async {
    try{
      // await syncDevice();
      final String queryParameters = Uri(
        queryParameters:deviceId!=null
        ?{"device_id":deviceId,"state":state.toString()}
        :{"state":state.toString()}
      ).query;
      await _apiClient.put(
        endpoint:"$basePlayerEndpoint/shuffle",
        queryParameters: queryParameters
      );
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }

  @override
  Future<void> transferPlayback({required List<String> deviceIds,bool? play})async{
    try{
      // await syncDevice();
      final Map<String,dynamic> body = play!=null
        ?{"device_ids":deviceIds,"play":play}
        :{"device_ids":deviceIds};
      await _apiClient.put(
        endpoint:basePlayerEndpoint,
        body: body,
        extraheaders: apiHeader 
      );
    }catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }

  @override
  Future<void> volume({String? deviceId, required int volume}) async {
    try {
      // await syncDevice();
      final String queryParameters = Uri(
        queryParameters: deviceId != null
            ? {"device_id": deviceId, "volume_percent": volume.toString()}
            : {"volume_percent": volume.toString()},
      ).query;
      await _apiClient.put(
        endpoint: "$basePlayerEndpoint/volume",
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> queue({String? deviceId, required String uri}) async {
    try {
      // await syncDevice();
      final String queryParameters = Uri(
        queryParameters: deviceId != null
            ? {"device_id": deviceId, "uri": uri}
            : {"uri": uri},
      ).query;
      await _apiClient.post(
        endpoint: '${basePlayerEndpoint}queue',
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<List<Track>> getRecentlyPlayedTracks({int? limit})async{
    try{
      final Map<String,dynamic> queryParameters ={};
      if(limit!=null){
        queryParameters["limit"]=limit.toString();
      }
      final String query=Uri(
        queryParameters: queryParameters.isNotEmpty?queryParameters:null
      ).query;
      final tracksData = await _apiClient.get(
        endpoint: "/v1/me/player/recently-played", 
        fromJson: (json)=>(json["items"] as List<dynamic>),
        query: query
      );
      if(tracksData==null){
        throw [];
      }
      return tracksData.map((json)=>Track.fromJson(json["track"])).toList();
    }
    catch(e){
      throw SpotifyAPIError(message: e.toString());
    }
  }
  
@override
Future<void> startPlayback({required List<String> uris, String? deviceId}) async {
  try {
    await syncDevice();
    final Map<String, dynamic> queryParameters = {};
    if (deviceId != null) {
      queryParameters["device_id"] = deviceId;
    }
    final Map<String, dynamic> body = {"uris": uris};
    
    await _apiClient.put(
      endpoint: '$basePlayerEndpoint/play',
      body: body,
      extraheaders: apiHeader,
      queryParameters: Uri(queryParameters: queryParameters.isNotEmpty ? queryParameters : null).query 
    );
  } catch (e) {
    throw SpotifyAPIError(message: e.toString());
  }
}
  
}

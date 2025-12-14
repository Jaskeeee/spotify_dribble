import 'package:spotify_dribble/core/auth/data/services/api_wrapper.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/core/player/domain/model/device.dart';
import 'package:spotify_dribble/core/player/domain/model/playback_state.dart';
import 'package:spotify_dribble/core/player/domain/model/player_enums.dart';
import 'package:spotify_dribble/core/player/domain/repo/player_repo.dart';

class SpotifyPlayerRepo implements PlayerRepo {
  final ApiWrapper _apiWrapper = ApiWrapper();
  final String baseEndpoint = "/v1/me/player";
  @override
  Future<List<Device>> getavailableDevices() async {
    try {
      final List<dynamic>? data = await _apiWrapper.fetchEndpointData(
        endpoint: "${baseEndpoint}devices",
        fromJson: (json) => (json["devices"] as List<dynamic>),
      );
      return data!.map((json) => Device.fromJson(json)).toList();
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<PlaybackState?> getPlaybackState()async{
    try{
      final PlaybackState? playbackState = await _apiWrapper.fetchEndpointData(
        endpoint: baseEndpoint, 
        fromJson: (json)=>PlaybackState.fromJson(json)
      );
      if(playbackState!=null){
        return playbackState;
      }
      else{
        return null;
      }
    }catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }

  @override
  Future<void> next({String? deviceId}) async {
    try {
      final String? queryParameters = deviceId != null
          ? Uri(queryParameters: {"device_id": deviceId}).query
          : null;
      await _apiWrapper.postDataOnEndpoint(
        endpoint: "$baseEndpoint/next",
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> pause({String? deviceId}) async {
    try {
      final String? queryParameters = deviceId != null
          ? Uri(queryParameters: {"device_id": deviceId}).query
          : null;
      await _apiWrapper.updateEndpointData(
        endpoint: '$baseEndpoint/pause',
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> previous({String? deviceId}) async {
    try {
      final String? queryParameters = deviceId != null
          ? Uri(queryParameters: {"device_id": deviceId}).query
          : null;
      await _apiWrapper.postDataOnEndpoint(
        endpoint: '$baseEndpoint/previous',
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> repeatMode({
    String? deviceId,
    required RepeatState state,
  }) async {
    try {
      final String queryParameters = Uri(
        queryParameters: deviceId != null
            ? {"device_id": deviceId, "state": state}
            : {"state": state},
      ).query;
      await _apiWrapper.updateEndpointData(
        endpoint: "$baseEndpoint/repeat",
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> resume({String? deviceId}) async {
    try {
      final String? queryParameters = deviceId != null
          ? Uri(queryParameters: {"device_id": deviceId}).query
          : null;
      await _apiWrapper.updateEndpointData(
        endpoint: '$baseEndpoint/play',
        queryParameters: queryParameters,
        extraheaders: {"Content-Type": "application/json"},
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> seek({String? deviceId, required int positionMs}) async {
    try {
      final String queryParameters = Uri(
        queryParameters: deviceId != null
            ? {"device_id": deviceId, "position_ms": positionMs.toString()}
            : {"position_ms": positionMs.toString()},
      ).query;
      await _apiWrapper.updateEndpointData(
        endpoint: '$baseEndpoint/seek',
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> shuffle({String? deviceId, required bool state}) async {
    try{
      final String queryParameters = Uri(
        queryParameters:deviceId!=null
        ?{"device_id":deviceId,"state":state.toString()}
        :{"state":state.toString()}
      ).query;
      await _apiWrapper.updateEndpointData(
        endpoint:"$baseEndpoint/shuffle",
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
      final Map<String,dynamic> body = play!=null
        ?{"device_ids":deviceIds,"play":play}
        :{"device_ids":deviceIds};
      await _apiWrapper.updateEndpointData(
        endpoint:baseEndpoint,
        body: body,
        extraheaders: {"Content-Type":"application/json"} 
      );
    }catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }

  @override
  Future<void> volume({String? deviceId, required int volume}) async {
    try {
      final String queryParameters = Uri(
        queryParameters: deviceId != null
            ? {"device_id": deviceId, "volume_percent": volume.toString()}
            : {"volume_percent": volume.toString()},
      ).query;
      await _apiWrapper.updateEndpointData(
        endpoint: "${baseEndpoint}volume",
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> queue({String? deviceId, required String uri}) async {
    try {
      final String queryParameters = Uri(
        queryParameters: deviceId != null
            ? {"device_id": deviceId, "uri": uri}
            : {"uri": uri},
      ).query;
      await _apiWrapper.postDataOnEndpoint(
        endpoint: '${baseEndpoint}queue',
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mpris/mpris.dart';
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
  final MPRIS mpris = MPRIS();
  final List<String> restartSpotifyd = ['--user','restart','spotifyd']; 

  MPRISPlayer? currentPlayer;
  Track? lastTrack;
  String? deviceId;
   
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

  Future<bool> isSpotifydActive()async{
    try{
      final result = await Process.run('systemctl',['--user','is-active','spotifyd']);
      return result.stdout.toString().trim()=='active';
    }
    catch(e){
      throw SpotifyError(message:e.toString());
    }
  }




  Future<void> ensureSpotifyContext({int retires=2})async{
    try{
      for(int attempt=1;attempt<=retires;attempt++){
        final data = await listenToSpotifyd().first;
        if(!data.contains("couldn't load context")){
          return;
        }
        await transferTospotifyd();
        await Future.delayed(Duration(seconds:1));
        await transferTospotifyd();
        await Future.delayed(Duration(seconds:1));
      }
    }
    catch(e){
      throw SpotifyError(message:e.toString());
    }
  }


  Future<void> checkSpotifyd()async{
    try{    
      final bool state= await isSpotifydActive();
      if(!state){
        await Process.run('systemctl',['--user','restart','spotifyd']);
      } 
      await ensureSpotifyContext();
      await getPlaybackState();
      await getPlayerForMPRIS();
    }
    catch(e){
      throw SpotifyError(message:e.toString());
    }
  }

  Future<void> getPlayerForMPRIS() async {
    try {
      final players = await mpris.getPlayers();
      print("Found ${players.length} players");
      for (MPRISPlayer player in players) {
        if (player.name.contains("spotifyd")) {
          currentPlayer = player;
          print("Current Player : ${player.name}");
        }
      }
    } catch (e) {
      throw SpotifyError(message: e.toString());
    }
  }
  

  Future<void> playbackCaller(Duration callDelay) async {
    Timer.periodic(callDelay, (timer) async {
      await getPlaybackState();
    });
  }

  Stream<String> listenToSpotifyd() async* {
    final Process process = await Process.start('journalctl', [
      '--user',
      '-u',
      'spotifyd.service',
      '-f',
    ]);
    yield* process.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter());
  }

  @override
  Future<PlaybackState?> getPlaybackState() async {
    try {
      print("Playback state called");
      final PlaybackState? playbackState = await _apiClient.get(
        endpoint: basePlayerEndpoint,
        fromJson: (json) => PlaybackState.fromJson(json),
      );
      return playbackState;
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  Future<void> stopSpotifyd() async {
    try {
      print("terminating spotifyd");
      await Process.run('systemctl', ['--user', 'stop', 'spotifyd.service']);
    } catch (e) {
      throw SpotifyError(message: e.toString());
    }
  }


  Future<void> transferTospotifyd() async {
    try {
      final PlaybackState? playbackState = await getPlaybackState();
      final List<Device> devices = await getavailableDevices();
      final String deviceName = dotenv.get("SPOTIFY_DEVICE_NAME");
      if (playbackState == null) {
        for (Device device in devices) {
          if (device.name == deviceName) {
            try {
              await transferPlayback(deviceIds: [device.id], play: false);
            } catch (e) {
              throw SpotifyError(message: e.toString());
            }
          }
        }
      }
    } catch (e) {
      throw SpotifyError(message: e.toString());
    }
  }


  @override
  Future<void> syncDevice() async {
    try {
      await checkSpotifyd();
      final PlaybackState? playbackState = await getPlaybackState();
      final List<Device> devices = await getavailableDevices();
      final String deviceName = dotenv.get("SPOTIFY_DEVICE_NAME");
      if (playbackState == null) {
        for (var device in devices) {
          if (device.name == deviceName) {
            try {
              await transferPlayback(deviceIds: [device.id], play: false);
            } catch (e) {
              await Process.run("systemctl", [
                '--user',
                'restart',
                'spotifyd.service',
              ]);
              await Future.delayed(Duration(milliseconds: 1500));
              await syncDevice();
            }
          }
        }
      }
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> next({String? deviceId}) async {
    try {
      if (currentPlayer != null) {
        currentPlayer!.next();
      } else {
        final String? queryParameters = deviceId != null
            ? Uri(queryParameters: {"device_id": deviceId}).query
            : null;
        await _apiClient.post(
          endpoint: "$basePlayerEndpoint/next",
          queryParameters: queryParameters,
        );
      }
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> pause({String? deviceId}) async {
    try {
      if (currentPlayer != null) {
        print("pausing playback using MPRIS");
        currentPlayer!.pause();
      } else {
        await syncDevice();
        final String? queryParameters = deviceId != null
            ? Uri(queryParameters: {"device_id": deviceId}).query
            : null;
        await _apiClient.put(
          endpoint: '$basePlayerEndpoint/pause',
          queryParameters: queryParameters,
        );
      }
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> previous({String? deviceId}) async {
    try {
      if (currentPlayer != null) {
        if (await currentPlayer!.canGoPrevious()) {
          await currentPlayer!.previous();
        }
      } else {
        final String? queryParameters = deviceId != null
            ? Uri(queryParameters: {"device_id": deviceId}).query
            : null;
        await _apiClient.post(
          endpoint: '$basePlayerEndpoint/previous',
          queryParameters: queryParameters,
        );
      }
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
      // await syncDevice();
      final String queryParameters = Uri(
        queryParameters: deviceId != null
            ? {"device_id": deviceId, "state": state.name}
            : {"state": state.name},
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
      if (currentPlayer != null) {
        print("resuming playback using MPRIS");
        currentPlayer!.play();
      } else {
        final String? queryParameters = deviceId != null
            ? Uri(queryParameters: {"device_id": deviceId}).query
            : null;
        await _apiClient.put(
          endpoint: '$basePlayerEndpoint/play',
          queryParameters: queryParameters,
          extraheaders: apiHeader,
        );
      }
      // await syncDevice();
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
    try {
      // await syncDevice();
      if (currentPlayer != null) {
        bool shuffle = await currentPlayer!.getShuffle();
        print("shuffle state: $shuffle");
        await currentPlayer!.setShuffle(!shuffle);
      } else {
        final String queryParameters = Uri(
          queryParameters: deviceId != null
              ? {"device_id": deviceId, "state": state.toString()}
              : {"state": state.toString()},
        ).query;
        await _apiClient.put(
          endpoint: "$basePlayerEndpoint/shuffle",
          queryParameters: queryParameters,
        );
      }
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> transferPlayback({
    required List<String> deviceIds,
    bool? play,
  }) async {
    try {
      // await syncDevice();
      final Map<String, dynamic> body = play != null
          ? {"device_ids": deviceIds, "play": play}
          : {"device_ids": deviceIds};
      await _apiClient.put(
        endpoint: basePlayerEndpoint,
        body: body,
        extraheaders: apiHeader,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
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
  Future<List<Track>> getRecentlyPlayedTracks({int? limit}) async {
    try {
      final Map<String, dynamic> queryParameters = {};
      if (limit != null) {
        queryParameters["limit"] = limit.toString();
      }
      final String query = Uri(
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      ).query;
      final tracksData = await _apiClient.get(
        endpoint: "/v1/me/player/recently-played",
        fromJson: (json) => (json["items"] as List<dynamic>),
        query: query,
      );
      if (tracksData == null) {
        throw [];
      }
      return tracksData.map((json) => Track.fromJson(json["track"])).toList();
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  @override
  Future<void> startPlayback({
    required List<String> uris,
    String? deviceId,
  }) async {
    try {
      
      final Map<String, dynamic> queryParameters = {};
      if (deviceId != null) {
        queryParameters["device_id"] = deviceId;
      }
      final Map<String, dynamic> body = {"uris": uris};

      await _apiClient.put(
        endpoint: '$basePlayerEndpoint/play',
        body: body,
        extraheaders: apiHeader,
        queryParameters: Uri(
          queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
        ).query,
      );
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }

  Future<void> togglePlayback() async {
    try {
      if (currentPlayer != null) {
        final data = await currentPlayer!.toggle();
        print(data);
      }
    } catch (e) {
      throw SpotifyAPIError(message: e.toString());
    }
  }
}

final String possibleCharSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
final String darkLogoPath = "assets/images/Spotify_Primary_Logo_RGB_Black.png";
final String lighLogoPath = "assets/images/Spotify_Primary_Logo_RGB_White.png";
final String spotifyLogoPath = "assets/images/Spotify_Primary_Logo_RGB_Green.png";
final String authUrl = "https://accounts.spotify.com/authorize";
final String video = "assets/videos/water_video.mp4";
final Map<String,String> contentHeader = {
  'Content-Type': 'application/x-www-form-urlencoded',
};

final List<String> scopes = [
  "user-read-private",
  "user-read-email",
  "user-library-read",
  "user-library-modify",
  "playlist-read-private",
  "playlist-read-collaborative",
  "playlist-modify-public",
  "playlist-modify-private",
  "user-read-playback-state",
  "user-modify-playback-state",
  "user-read-currently-playing",
  "user-read-recently-played",
  "user-top-read"
];
final List<String> albums=[
  "assets/images/01.png",
  "assets/images/02.png",
  "assets/images/03.png",
  "assets/images/04.png",
  "assets/images/05.png",
  "assets/images/08.png",
  "assets/images/09.png",
];
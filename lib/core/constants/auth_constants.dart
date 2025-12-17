final List<String> scopes = [
  "user-read-private",
  "user-follow-read",
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
final String possibleCharSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
final Map<String,String> contentHeader = {
  'Content-Type': 'application/x-www-form-urlencoded',
};
final String authUrl = "https://accounts.spotify.com/authorize";

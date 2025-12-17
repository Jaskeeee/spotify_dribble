class SpotifyError {
  final String message;
  final int? statusCode;
  final dynamic details;
  SpotifyError({
    required this.message,
    this.details,
    this.statusCode
  });

  @override
  String toString()=>"SPOTIFY_ERROR($statusCode): $message";
}
class SpotifyAuthError extends SpotifyError{
  SpotifyAuthError({required super.message,super.details,super.statusCode});
}
class SpotifyAPIError extends SpotifyError{
  SpotifyAPIError({required super.message,super.details,super.statusCode}); 
}

class SpotifyRateLimitError extends SpotifyError{
  final int retryAfter;
  SpotifyRateLimitError({required this.retryAfter, required super.message});
}
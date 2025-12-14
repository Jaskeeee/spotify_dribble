class AccessToken{
  final String token;
  final String refreshToken;
  final DateTime expiresIn;
  AccessToken({
    required this.token,
    required this.refreshToken,
    required this.expiresIn,
  });

  bool get isValid=>DateTime.now().isBefore(expiresIn);
}
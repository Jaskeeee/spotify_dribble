class Header {
  final String accessToken;
  final Map<String,String>? extraHeaders;
  Header({
    required this.accessToken,
    this.extraHeaders
  });

  Map<String,String> toMap(){
    final Map<String,String> authHeader = {
      "Authorization": "Bearer $accessToken",
    };
    if(extraHeaders!=null){
      authHeader.addAll(extraHeaders!);
      return authHeader;
    }else{
      return authHeader;
    }
    
  }
}
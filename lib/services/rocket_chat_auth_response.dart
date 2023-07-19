class RocketChatAuthResponse {
  String userId;
  String authToken;

  RocketChatAuthResponse({required this.authToken, required this.userId});

  static RocketChatAuthResponse fromJson(Map<String, dynamic>? data) {
    if (data == null) {
      throw UnimplementedError('rocketChatrAUthReponse data null');
    }

    final model = RocketChatAuthResponse(
      authToken: data['authToken'],
      userId: data['userId'],
    );

    return model;
  }
}

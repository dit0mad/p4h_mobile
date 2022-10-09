class SessionUser {
  final String uuid;
  final String canvasId;
  final bool isAuthenticated;
  final bool isActive;
  final bool isAnonymous;

  const SessionUser(
      {required this.uuid,
      required this.canvasId,
      required this.isAuthenticated,
      required this.isActive,
      required this.isAnonymous});

  factory SessionUser.fromJson(Map<String, dynamic> data) {
    final uuid = data['uuid'];
    final canvasId = data['canvasId'];
    final isAuthenticated = data['isAuthenticated'];
    final isActive = data['isActive'];
    final isAnonymous = data['isAnonymous'];

    return SessionUser(
      uuid: uuid,
      canvasId: canvasId,
      isAuthenticated: isAuthenticated,
      isActive: isActive,
      isAnonymous: isAnonymous,
    );
  }

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'canvasId': canvasId,
        'isAuthenticated': isAuthenticated,
        'isActive': isActive,
        'isAnonymous': isAnonymous,
      };
}

String? roomIdValidator(String? roomId) {
  if (roomId == null || roomId.trim().isEmpty) {
    return 'Room ID is required';
  } else if (roomId.trim().length != 24) {
    return 'Invalid room ID';
  } else {
    return null;
  }
}

String? nicknameValidator(String? nickname) {
  if (nickname == null || nickname.trim().isEmpty) {
    return 'Nickname is required';
  } else if (nickname.trim().length < 3) {
    return 'Nickname must be at least 3 characters';
  } else {
    return null;
  }
}

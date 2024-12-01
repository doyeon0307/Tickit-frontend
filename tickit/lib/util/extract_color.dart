String extractColor ({required String rawColor}) {
  final RegExp regex = RegExp(r'\((.*?)\)');
  final match = regex.firstMatch(rawColor);

  if (match != null && match.groupCount >= 1) {
    return match.group(1)!;
  }
  return '';
}

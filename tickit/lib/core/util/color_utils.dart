String extractColor({
  required String rawColor,
}) {
  final RegExp regex = RegExp(r'Color\((0x[a-fA-F0-9]+)\)');
  final match = regex.firstMatch(rawColor);

  if (match != null && match.groupCount >= 1) {
    return match.group(1)!;
  }
  return '';
}

extension StringExtension on String {
  bool isValidApi() {
    return RegExp(
       r'^AIzaSy[A-Za-z0-9_-]{33}$',
    ).hasMatch(this);
  }
}
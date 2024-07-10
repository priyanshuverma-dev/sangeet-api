class DownloadRes {
  final bool success;
  final String? failureMessage;

  DownloadRes({
    required this.success,
    this.failureMessage,
  });
}

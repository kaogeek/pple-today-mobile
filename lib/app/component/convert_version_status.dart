class ConvertVersionStatus {
  final String localVersion;
  final String storeVersion;
  final String appStoreLink;

  ConvertVersionStatus({
    required this.localVersion,
    required this.storeVersion,
    required this.appStoreLink,
  });

  bool get canUpdate {
    final local = localVersion.split('.').map(int.parse).toList();
    final store = storeVersion.split('.').map(int.parse).toList();

    for (var i = 0; i < store.length; i++) {
      if (store[i] > local[i]) {
        return true;
      }

      if (local[i] > store[i]) {
        return false;
      }
    }

    return false;
  }
}

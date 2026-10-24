import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Whether the device can reach the internet, as a value and as changes.
///
/// Built on real reachability checks rather than on the radio state: being
/// on a Wi-Fi network without a working uplink is still "offline" here,
/// which is the case that matters for showing the banner and for knowing
/// when a reload can succeed.
class ConnectivityService {
  ConnectivityService({InternetConnection? checker})
    : _checker = checker ?? InternetConnection();

  final InternetConnection _checker;
  final _controller = StreamController<bool>.broadcast();
  StreamSubscription<InternetStatus>? _subscription;

  bool _isOnline = true;

  /// The last known state. Optimistic until the first check lands, so the
  /// app does not open with a false offline banner.
  bool get isOnline => _isOnline;

  /// Emits only on a change between online and offline.
  Stream<bool> get onChange => _controller.stream;

  /// Starts watching. Safe to call more than once.
  void start() {
    _subscription ??= _checker.onStatusChange.listen((status) {
      final online = status == InternetStatus.connected;
      if (online == _isOnline) return;
      _isOnline = online;
      _controller.add(online);
    });
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
    await _controller.close();
  }
}

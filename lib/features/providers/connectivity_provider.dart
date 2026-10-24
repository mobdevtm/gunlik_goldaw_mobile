import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:gunluk_goldaw_mobile/core/network/connectivity_service.dart';

/// The connection state, for the offline banner.
class ConnectivityProvider extends ChangeNotifier {
  ConnectivityProvider({required ConnectivityService service})
    : _service = service {
    _subscription = _service.onChange.listen((_) => notifyListeners());
  }

  final ConnectivityService _service;
  late final StreamSubscription<bool> _subscription;

  bool get isOffline => !_service.isOnline;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

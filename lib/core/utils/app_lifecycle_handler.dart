import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLifecycleHandler extends WidgetsBindingObserver {
  AppLifecycleHandler();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _onResumed();
        break;
      case AppLifecycleState.inactive:
        _onInactive();
        break;
      case AppLifecycleState.paused:
        _onPaused();
        break;
      case AppLifecycleState.hidden:
        _onHidden();
        break;
      case AppLifecycleState.detached:
        _onDetached();
        break;
    }
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }

  void _onResumed() {
    _log('🟢 App resumed');
  }

  void _onInactive() {
    _log('🟡 App inactive');
  }

  void _onPaused() {
    _log('🟠 App paused');
  }

  void _onHidden() {
    _log('🔵 App hidden');
  }

  void _onDetached() {
    _log('🔴 App detached');
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
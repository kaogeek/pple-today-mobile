import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  AnalyticsService._();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static final AnalyticsService _service = AnalyticsService._();

  factory AnalyticsService() => _service;

  static FirebaseAnalytics get analytics => _service._analytics;

  static FirebaseAnalyticsObserver get observer => _service.getAnalyticsObserver();

  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(
        analytics: _service._analytics,
      );

  Future logEvent({required String name, Map<String, dynamic>? parameters}) async {
    // debugPrint('-- AnalyticsService.logEvent: $name');

    await _analytics.logEvent(name: name, parameters: parameters);
  }

  Future logScreen({required String name, String? screenClassOverride}) async {
    // debugPrint('-- AnalyticsService.logScreen: $name');

    await _analytics.setCurrentScreen(
      screenName: name,
      screenClassOverride: screenClassOverride ?? 'FlutterScreen',
    );
  }

  Future setUserProperties({required String userId}) async {
    debugPrint('-- AnalyticsService.setUserProperties: $userId');

    await _analytics.setUserId(id: userId);
  }
}

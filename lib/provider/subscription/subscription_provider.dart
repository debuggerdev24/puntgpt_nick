import 'package:flutter/foundation.dart';
import 'package:puntgpt_nick/service/subscription/subscription_service.dart';

import '../../core/enum/app_enums.dart';

class SubscriptionProvider extends ChangeNotifier {
  /// Store all active subscriptions
  final Set<SubscriptionTier> _activeSubscriptions = {};

  bool _isSubscriptionProcessing = false;

  bool get isSubscriptionProcessing => _isSubscriptionProcessing;

  bool get isTier1Subscribed =>
      _activeSubscriptions.contains(SubscriptionTier.tier1);
  bool get isTier2Subscribed =>
      _activeSubscriptions.contains(SubscriptionTier.tier2);
  bool get isTier3Subscribed =>
      _activeSubscriptions.contains(SubscriptionTier.tier3);

  // Expose active set read-only
  Set<SubscriptionTier> get activeSubscriptions => {..._activeSubscriptions};

  //todo set
  void setSubscriptionProcessStatus({required bool status}) {
    _isSubscriptionProcessing = status;
    notifyListeners();
  }

  //todo add subscription
  void addSubscription(SubscriptionTier tier) {
    _activeSubscriptions.add(tier);
    notifyListeners();
  }

  //todo remove subscription
  void removeSubscription(SubscriptionTier tier) {
    _activeSubscriptions.remove(tier);
    notifyListeners();
  }

  //todo buy subscription
  Future<void> buy(SubscriptionTier tier) async {
    await SubscriptionService.instance.buy(tier: tier);

    notifyListeners();
  }

  /// Mock Cancel
  Future<void> cancel(SubscriptionTier tier) async {
    // await Future.delayed(const Duration(milliseconds: 500));

    _activeSubscriptions.remove(tier);
    notifyListeners();
  }
}

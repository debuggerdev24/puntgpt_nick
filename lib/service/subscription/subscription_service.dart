import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

import '../../core/enum/app_enums.dart';
import '../../core/helper/log_helper.dart';
import '../../provider/subscription/subscription_provider.dart';

class SubscriptionService {
  SubscriptionService._();
  static final SubscriptionService instance = SubscriptionService._();

  final InAppPurchase _iap = InAppPurchase.instance;

  /// Mock product IDs for now
  static const Map<SubscriptionTier, String> productIds = {
    SubscriptionTier.tier1: "mock.tier1.monthly",
    SubscriptionTier.tier2: "mock.tier2.monthly",
    SubscriptionTier.tier3: "mock.tier3.monthly",
  };

  List<ProductDetails> _products = [];
  StreamSubscription<List<PurchaseDetails>>? _purchaseSub;

  // ---------------------------------------------------------------------------
  // INITIALIZE
  // ---------------------------------------------------------------------------
  Future<void> initialize({required SubscriptionProvider provider}) async {
    final available = await _iap.isAvailable();
    if (!available) {
      Logger.info("Store not available");
      return;
    }

    await _loadProducts();

    _purchaseSub = _iap.purchaseStream.listen(
      (purchases) => _handlePurchases(purchases, provider),
      onError: (e) => Logger.error(e.toString()),
    );
  }

  Future<void> _loadProducts() async {
    final response = await _iap.queryProductDetails(productIds.values.toSet());

    _products = response.productDetails;

    Logger.info("Products loaded: ${_products.map((e) => e.id)}");
  }

  // ---------------------------------------------------------------------------
  // BUY (CALLED BY PROVIDER)
  // ---------------------------------------------------------------------------
  Future<bool> buy({required SubscriptionTier tier}) async {
    try {
      final productId = productIds[tier];
      final product = _products.firstWhere(
        (p) => p.id == productId,
        orElse: () => throw Exception("Product not found"),
      );

      final param = PurchaseParam(productDetails: product);

      await _iap.buyNonConsumable(purchaseParam: param);
      return true;
    } catch (e, s) {
      Logger.error("Buy error: $e\n$s");
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // HANDLE STORE CALLBACKS (NOTIFY PROVIDER)
  // ---------------------------------------------------------------------------
  Future<void> _handlePurchases(
    List<PurchaseDetails> purchases,
    SubscriptionProvider provider,
  ) async {
    for (final p in purchases) {
      if (p.status == PurchaseStatus.purchased ||
          p.status == PurchaseStatus.restored) {
        final tier = _mapProductToTier(p.productID);
        if (tier != null) {
          provider.addSubscription(tier);
        }
        _iap.completePurchase(p);
      }

      if (p.status == PurchaseStatus.canceled) {
        provider.setSubscriptionProcessStatus(status: false);
      }

      if (p.status == PurchaseStatus.error) {
        Logger.error("Purchase error: ${p.error}");
      }
    }
  }

  SubscriptionTier? _mapProductToTier(String id) {
    try {
      return productIds.entries.firstWhere((e) => e.value == id).key;
    } catch (_) {
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // CANCEL (CALLED BY PROVIDER)
  // ---------------------------------------------------------------------------
  Future<bool> cancel({required SubscriptionTier tier}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  void dispose() {
    _purchaseSub?.cancel();
  }
}

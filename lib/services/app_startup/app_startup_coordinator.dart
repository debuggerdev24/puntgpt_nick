import 'package:puntgpt_nick/core/app_imports.dart';
import 'package:puntgpt_nick/main.dart';
import 'package:puntgpt_nick/provider/account/account_provider.dart';
import 'package:puntgpt_nick/provider/home/search_engine/search_engine_provider.dart';
import 'package:puntgpt_nick/provider/punt_club/punter_club_provider.dart';
import 'package:puntgpt_nick/provider/subscription/subscription_provider.dart';

class AppStartupCoordinator {
  AppStartupCoordinator._();

  static Future<void> run({required BuildContext context}) async {
    final accountProvider = context.read<AccountProvider>();
    final searchEngineProvider = context.read<SearchEngineProvider>();
    final puntClubProvider = context.read<PuntClubProvider>();
    final subsProvider = context.read<SubscriptionProvider>();

    // IAP listener must run before restore; plans must load before productId → planId mapping.
    await subsProvider.initialize(context: context);
    await subsProvider.getSubscriptionPlans();
    if (!isGuest) {
      await subsProvider.restorePurchasesAtStartup(context: context);
    }

    final futures = <Future<dynamic>>[
      if (!isGuest) accountProvider.getProfile(),
      searchEngineProvider.getTrackDetails(),
      searchEngineProvider.getDistanceDetails(),
      searchEngineProvider.getBarrierDetails(),
      puntClubProvider.getNotifications(),
      searchEngineProvider.getAllTipSlips(),
    ];

    await Future.wait(futures);
  }
}

import 'package:go_router/go_router.dart';
import 'package:perk_app/features/auth/presentation/page/change-password/change_password.dart';
import 'package:perk_app/features/auth/presentation/page/login/sign_in.dart';
import 'package:perk_app/features/home/presentation/page/mcx/mcx.dart';
import 'package:perk_app/features/home/presentation/page/mcx/symbol/mcx_symbol.dart';
import 'package:perk_app/features/home/presentation/page/nfo/nfo.dart';
import 'package:perk_app/features/home/presentation/page/nfo/symbol/nfo_symbol.dart';
import 'package:perk_app/features/home/presentation/page/splash/splash.dart';
import 'package:perk_app/features/navbar/custom_bottom_navbar.dart';
import 'package:perk_app/features/notifications/presentation/page/notification_panel.dart';
import 'package:perk_app/features/portfolio/presentation/page/active/active_portfolio.dart';
import 'package:perk_app/features/portfolio/presentation/page/closed/close_portfolio.dart';
import 'package:perk_app/features/portfolio/presentation/page/portfolio.dart';
import 'package:perk_app/features/trade/presentation/page/active/active_trade.dart';
import 'package:perk_app/features/trade/presentation/page/trade.dart';
import 'package:perk_app/features/user/presentation/pages/account_settings.dart';
import 'package:perk_app/features/user/presentation/pages/complaint/ledge_compaint.dart';
import 'package:perk_app/features/user/presentation/pages/ledger/ledger_report.dart';
import 'package:perk_app/features/user/presentation/pages/payment/deposit_payment.dart';
import 'package:perk_app/features/user/presentation/pages/payment/payment.dart';
import 'package:perk_app/features/user/presentation/pages/profile/user_profile.dart';
import 'package:perk_app/features/user/presentation/pages/wallet/user_wallet.dart';
import 'package:perk_app/features/user/presentation/pages/withdraw/withdraw.dart';
import 'package:perk_app/features/watchlist/presentation/pages/watchlist.dart';

class AppRoute {
  static const String INITIAL = SplashScreen.routeName;

  static final GoRouter router = GoRouter(
    initialLocation: INITIAL,
    routes: [
      ShellRoute(
        builder: (context, state, child) => GlobalNavBar(child: child),
        routes: [
          GoRoute(
            path: MCXPanel.routeName,
            name: MCXPanel.routeName,
            builder: (context, state) => const MCXPanel(),
          ),
          GoRoute(
            path: McxSymbolPanel.routeName,
            name: McxSymbolPanel.routeName,
            builder: (context, state) => const McxSymbolPanel(),
          ),
          GoRoute(
            path: NFOPanel.routeName,
            name: NFOPanel.routeName,
            builder: (context, state) => const NFOPanel(),
          ),
          GoRoute(
            path: NFOSymbolPanel.routeName,
            name: NFOSymbolPanel.routeName,
            builder: (context, state) => const NFOSymbolPanel(),
          ),

          GoRoute(
            path: WatchList.routeName,
            name: WatchList.routeName,
            builder: (context, state) => const WatchList(),
          ),
          GoRoute(
            path: TradePanel.routeName,
            name: TradePanel.routeName,
            builder: (context, state) {
              final targetIndex = state.extra as int?;
              return TradePanel(targetIndex: targetIndex);
            },
          ),
          GoRoute(
            path: PortfolioPanel.routeName,
            name: PortfolioPanel.routeName,
            builder: (context, state) => const PortfolioPanel(),
          ),
          GoRoute(
            path: ActivePortfolio.routeName,
            name: ActivePortfolio.routeName,
            builder: (context, state) => const ActivePortfolio(),
          ),
          GoRoute(
            path: ClosePortfolio.routeName,
            name: ClosePortfolio.routeName,
            builder: (context, state) => const ClosePortfolio(),
          ),
          GoRoute(
            path: AccountSettingsPanel.routeName,
            name: AccountSettingsPanel.routeName,
            builder: (context, state) => const AccountSettingsPanel(),
          ),
          GoRoute(
            path: ActiveTradePanel.routeName,
            name: ActiveTradePanel.routeName,
            builder: (context, state) => const ActiveTradePanel(),
          ),
          GoRoute(
            path: NotificationPanel.routeName,
            name: NotificationPanel.routeName,
            builder: (context, state) => const NotificationPanel(),
          ),
          GoRoute(
            path: UserProfile.routeName,
            name: UserProfile.routeName,
            builder: (context, state) => const UserProfile(),
          ),
          GoRoute(
            path: WithdrawPanel.routeName,
            name: WithdrawPanel.routeName,
            builder: (context, state) => const WithdrawPanel(),
          ),
          GoRoute(
            path: WalletPanel.routeName,
            name: WalletPanel.routeName,
            builder: (context, state) => const WalletPanel(),
          ),
          GoRoute(
            path: LedgerReport.routeName,
            name: LedgerReport.routeName,
            builder: (context, state) => const LedgerReport(),
          ),
          GoRoute(
            path: PaymentScreen.routeName,
            name: PaymentScreen.routeName,
            builder: (context, state) => const PaymentScreen(),
          ),
          GoRoute(
            path: DepositPayment.routeName,
            name: DepositPayment.routeName,
            builder: (context, state) => const DepositPayment(),
          ),

          GoRoute(
            path: LedgeComplaint.routeName,
            name: LedgeComplaint.routeName,
            builder: (context, state) => const LedgeComplaint(),
          ),

          GoRoute(
            path: ChangePasswordPanel.routeName,
            name: ChangePasswordPanel.routeName,
            builder: (context, state) => const ChangePasswordPanel(),
          ),
        ],
      ),
      GoRoute(
        path: SplashScreen.routeName,
        name: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: SignInPage.routeName,
        name: SignInPage.routeName,
        builder: (context, state) => const SignInPage(),
      ),
    ],
  );
}

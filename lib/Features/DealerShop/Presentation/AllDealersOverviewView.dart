import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/DealerShop/Presentation/_Widgets/DealerOverviewWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ExceptionHandler/MessageController.dart';
import '../../../ExceptionHandler/MessageEmitter.dart';
import '../../../Router/MyRoutes.gr.dart';
import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/ThemeManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';
import '../../AuthenticationFeature/Data/Repositories/AuthController.dart';
import '../../AuthenticationFeature/Domain/User/UserRole.dart';
import '../../SplashFeature/ErrorView.dart';
import '../../SplashFeature/LoadingView.dart';
import 'Providers/DealerProviders.dart';

@RoutePage()
class AllDealersOverviewView extends ConsumerWidget {
  const AllDealersOverviewView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen<AsyncValue<UserRole?>>(authControllerProvider, (previous, next) {
        next.whenData((data) {
          if (data == null) {
            return context.router.replaceAll([const LoginRoute()]);
          }
        });
      })
      ..listen(messageEmitterProvider, (previous, next) {
        next != null
            ? ref
                .read(MessageControllerProvider(context).notifier)
                .showToast(next)
            : null;
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text("التجار المتاحين"),
      ),
      drawer: ref.watch(authControllerProvider).value.runtimeType == Customer
          ? Drawer(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Column(
                  children: [
                    customerButtons(ref, context),
                    SizedBox(
                        height: MediaQuery.sizeOf(context).height * .2,
                        child: Image.asset("assets/Logo1.png")),
                  ],
                ),
              ),
            )
          : null,
      backgroundColor: ColorManager.surface,
      body: Container(
        decoration: ThemeManager.scaffoldBackground,
        child: Padding(
          padding: const EdgeInsets.all(PaddingValuesManager.p20),
          child: ref.watch(allDealersOverviewProvider).when(
                data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => DealerOverviewWidget(
                        dealerOverview: data.elementAt(index))),
                error: (error, stackTrace) => ErrorView(error: error),
                loading: () => const LoadingView(),
              ),
        ),
      ),
    );
  }

  Widget customerButtons(WidgetRef ref, BuildContext context) => Column(
        children: [
          TextButton(
              onPressed: () => context.router.push(const CartRoute()),
              child: const Text("العربة")),
          TextButton(
              onPressed: () =>
                  context.router.push(const CustomerActiveOrdersRoute()),
              child: const Text("الطلبات القائمة")),
          TextButton(
              onPressed: () =>
                  context.router.push(const CustomerOrdersHistoryRoute()),
              child: const Text("سجل الطلبات المنتهية")),
          TextButton(
              onPressed: () => context.router.push(const ProfileRoute()),
              child: const Text("البيانات الشخصية")),
          TextButton(
              onPressed: () =>
                  ref.read(authControllerProvider.notifier).signOut(),
              child: const Text("تسجيل خروج")),
        ],
      );
}

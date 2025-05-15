import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/DealerShop/Domain/DealerOverview.dart';
import 'package:farming_market/Features/DealerShop/Presentation/Providers/DealerProviders.dart';
import 'package:farming_market/Features/DealerShop/Presentation/_Widgets/ProductOverviewWidget.dart';
import 'package:farming_market/Router/MyRoutes.gr.dart';
import 'package:farming_market/utils/Resouces/ThemeManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ExceptionHandler/MessageController.dart';
import '../../../ExceptionHandler/MessageEmitter.dart';
import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';
import '../../AuthenticationFeature/Data/Repositories/AuthController.dart';
import '../../AuthenticationFeature/Domain/User/UserRole.dart';
import '../../SplashFeature/ErrorView.dart';
import '../../SplashFeature/LoadingView.dart';

@RoutePage()
class SingleDealerShopView extends ConsumerWidget {
  final DealerOverview dealerOverview;

  const SingleDealerShopView({super.key, required this.dealerOverview});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (dealerOverview.dealerId ==
        ref.watch(authControllerProvider).value?.user?.uid) {
      ref
        ..listen<AsyncValue<UserRole?>>(authControllerProvider,
            (previous, next) {
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
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("متجر التاجر"),
      ),
      drawer: dealerOverview.dealerId ==
              ref.watch(authControllerProvider).requireValue?.user?.uid
          ? Drawer(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Column(
                  children: [
                    dealerButtons(context),
                    TextButton(
                        onPressed: () =>
                            ref.read(authControllerProvider.notifier).signOut(),
                        child: const Text("تسجيل خروج")),
                    Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.2,
                              child:
                                  const SizedBox()) // Image.asset("assets/Logo.png")),
                          ),
                    ),
                    SizedBox(
                        height: MediaQuery.sizeOf(context).height * .15,
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
          child: ref.watch(dealerAllProductsProvider(dealerOverview)).when(
                data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                        ProductOverviewWidget(product: data.elementAt(index))),
                error: (error, stackTrace) => ErrorView(error: error),
                loading: () => const LoadingView(),
              ),
        ),
      ),
    );
  }

  Widget dealerButtons(BuildContext context) => Column(
        children: [
          TextButton(
              onPressed: () => context.router.push(const AddProductRoute()),
              child: const Text("إضافة منتج زراعي جديد")),
          TextButton(
              onPressed: () =>
                  context.router.push(const DealerAllOrdersRoute()),
              child: const Text("قائمة طلبات الزبائن"))
        ],
      );
}

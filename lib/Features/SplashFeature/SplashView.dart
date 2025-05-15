import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:farming_market/Features/AuthenticationFeature/Domain/User/UserRole.dart';
import 'package:farming_market/Features/DealerShop/Domain/DealerOverview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../Router/MyRoutes.gr.dart';
import '../AuthenticationFeature/Data/Repositories/AuthController.dart';
import 'ErrorView.dart';
import 'LoadingView.dart';
import 'Provider/SharedPrefProvider.dart';

@RoutePage()
class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  int _currentIndex = 0;

  final List<Map<String, String>> _slides = [
    {
      'animation': 'assets/FirstSlide.json',
      'phrase': 'تصفح جميع المتاجر المتاحة!',
    },
    {
      'animation': 'assets/SecondSlide.json',
      'phrase': 'تلذذ بكل أنواع الخضار والفواكه!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    ref.watch(authControllerProvider);
    ref.watch(firstTimeProvider).whenData(
      (value) {
        if (value) return;
        ref.watch(authControllerProvider).whenData((value) async {
          if (value == null) {
            return context.router.replace(const LoginRoute());
          } else {
            switch (value) {
              case Admin():
              //return context.router.replace(MainFeedRoute());
              case Customer():
                return context.router.replace(const AllDealersOverviewRoute());
              case Dealer():
                return context.router.replace(SingleDealerShopRoute(
                    dealerOverview: DealerOverview.fromDealer(value)));
            }
          }
        });
      },
    );

    return Scaffold(
        body: ref.watch(firstTimeProvider).when(
            data: (firstTime) => firstTime
                ? firstTimeWidget()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * .2,
                            child: Image.asset("assets/Logo1.png")),
                        const Text('يجري التحميل'),
                        const SizedBox(height: 16),
                        const LoadingSpinner(),
                      ],
                    ),
                  ),
            error: (error, stackTrace) => ErrorView(error: error),
            loading: () => const LoadingView()));
  }

  Widget firstTimeWidget() => Column(
        children: [
          Expanded(
            flex: 7,
            child: CarouselSlider(
              items: _slides.map((slide) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Lottie.asset(slide["animation"]!)),
                    SizedBox(height: 20),
                    Text(
                      slide['phrase']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              }).toList(),
              options: CarouselOptions(
                height: MediaQuery.sizeOf(context).height * 0.9,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: _currentIndex,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
          _currentIndex == _slides.length - 1
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await ref.watch(authControllerProvider.future);

                      context.router.replaceAll([const LoginRoute()]);
                    },
                    child: const Text("ابدأ التصفح!"),
                  ),
                )
              : Container(), // Show the button only on the last slide
        ],
      );
}

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 16,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
      ),
    );
  }
}

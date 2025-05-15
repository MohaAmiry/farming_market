import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/AuthenticationFeature/Presentation/Notifiers/ProfileNotifier.dart';
import 'package:farming_market/Features/SplashFeature/ErrorView.dart';
import 'package:farming_market/Features/SplashFeature/LoadingView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Router/MyRoutes.gr.dart';
import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/ThemeManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';

@RoutePage()
class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("البيانات الشخصية",
            style: Theme.of(context).textTheme.titleLarge),
        actions: [
          ref.watch(profileNotifierProvider).maybeWhen(
              data: (data) => IconButton(
                  onPressed: () => context.router
                      .push(EditProfileRoute(userResponseDTO: data)),
                  icon: const Icon(Icons.edit)),
              orElse: () => Container())
        ],
      ),
      backgroundColor: ColorManager.surface,
      body: Container(
        height: double.infinity,
        decoration: ThemeManager.scaffoldBackground,
        child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: PaddingValuesManager.p20,
                vertical: PaddingValuesManager.p20),
            child: ref.watch(profileNotifierProvider).when(
                  data: (data) => SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الأسم",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(data.name),
                          Text(
                            "الإيميل",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(data.email),
                          Text(
                            "الموقع",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(data.address ?? ""),
                          Text(
                            "رقم التواصل",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(data.phoneNumber ?? ""),
                        ],
                      ),
                    ),
                  ),
                  error: (error, stackTrace) => ErrorView(error: error),
                  loading: () => const LoadingView(),
                )),
      ),
    );
  }
}

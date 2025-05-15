import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/AuthenticationFeature/Data/RequestsModels/LoginRequest/LoginEntityRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ExceptionHandler/MessageController.dart';
import '../../../ExceptionHandler/MessageEmitter.dart';
import '../../../Router/MyRoutes.gr.dart';
import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/StringsManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';
import '../../DealerShop/Domain/DealerOverview.dart';
import '../Data/Repositories/AuthController.dart';
import '../Domain/User/UserRole.dart';
import '../_CommonWidgets/AuthButton.dart';

@RoutePage()
class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController emailTextEdtController = TextEditingController();
  final TextEditingController passwordTextEdtController =
      TextEditingController();
  LoginRequest loginRequest = const LoginRequest(email: "", password: "");

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref
      ..listen<AsyncValue<UserRole?>>(authControllerProvider, (previous, next) {
        next.whenData((data) {
          if (data != null) {
            switch (data) {
              case Admin():
              //return context.router.replace(MainFeedRoute());
              case Customer():
                return context.router
                    .replaceAll([const AllDealersOverviewRoute()]);
              case Dealer():
                return context.router.replaceAll([
                  SingleDealerShopRoute(
                      dealerOverview: DealerOverview.fromDealer(data))
                ]);
            }
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
      backgroundColor: ColorManager.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PaddingValuesManager.p20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * .1),
              SizedBox(
                  height: MediaQuery.sizeOf(context).height * .2,
                  child: Image.asset("assets/Logo1.png")),
              const SizedBox(height: AppSizeManager.s45),
              Text(
                "تسجيل الدخول",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSizeManager.s45),
              TextFormField(
                  controller: emailTextEdtController,
                  onChanged: (value) => setState(() {
                        loginRequest = loginRequest.copyWith(email: value);
                      }),
                  decoration: const InputDecoration(
                      helperText: StringManager.emptyStr,
                      labelText: "الايميل",
                      hintText: "الايميل")),
              TextFormField(
                  controller: passwordTextEdtController,
                  onChanged: (value) => setState(() {
                        loginRequest = loginRequest.copyWith(password: value);
                      }),
                  decoration: const InputDecoration(
                      helperText: StringManager.emptyStr,
                      labelText: "كلمة المرور",
                      hintText: "كلمة المرور")),
              AuthButton(
                  text: "تسجيل الدخول",
                  onPressed: () async => await ref
                      .read(authControllerProvider.notifier)
                      .signIn(loginRequest)),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: PaddingValuesManager.p10),
                  child: TextButton(
                      onPressed: () {
                        context.router.push(const RegisterAsCustomerRoute());
                      },
                      child: const Text("التسجيل كزبون"))),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: PaddingValuesManager.p10),
                  child: TextButton(
                      onPressed: () {
                        context.router.push(const RegisterAsDealerRoute());
                      },
                      child: const Text("التسجيل كتاجر"))),
            ],
          ),
        ),
      ),
    );
  }
}

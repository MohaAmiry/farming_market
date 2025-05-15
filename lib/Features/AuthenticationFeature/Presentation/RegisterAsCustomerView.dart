import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/AuthenticationFeature/Data/RequestsModels/RegisterRequestsModels/RegisterRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/Resouces/ColorManager.dart';
import '../../../../../utils/Resouces/StringsManager.dart';
import '../../../../../utils/Resouces/ValuesManager.dart';
import '../../../utils/Resouces/ThemeManager.dart';
import '../Data/Repositories/AuthController.dart';
import '../_CommonWidgets/AuthButton.dart';

@RoutePage()
class RegisterAsCustomerView extends ConsumerStatefulWidget {
  const RegisterAsCustomerView({super.key});

  @override
  ConsumerState createState() => _RegisterAsCustomerViewState();
}

class _RegisterAsCustomerViewState
    extends ConsumerState<RegisterAsCustomerView> {
  final TextEditingController emailTextEdtController = TextEditingController();
  final TextEditingController passwordTextEdtController =
      TextEditingController();
  final TextEditingController phoneTextEdtController = TextEditingController();
  final TextEditingController nameTextEdtController = TextEditingController();
  final TextEditingController addressTextEdtController =
      TextEditingController();
  CustomerRegisterRequest registerRequest = const CustomerRegisterRequest(
      userId: "",
      name: "",
      email: "",
      password: "",
      phoneNumber: "",
      address: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.surface,
      appBar: AppBar(),
      body: Container(
        decoration: ThemeManager.scaffoldBackground,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(PaddingValuesManager.p20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * .1),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: PaddingValuesManager.p20,
                  ),
                  child: Text("تسجيل كزبون",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const Divider(thickness: 1),
                const SizedBox(height: AppSizeManager.s20),
                TextFormField(
                    controller: nameTextEdtController,
                    onChanged: (value) {
                      setState(() {
                        registerRequest = registerRequest.copyWith(name: value);
                      });
                    },
                    decoration: const InputDecoration(
                        helperText: StringManager.emptyStr,
                        labelText: "الأسم",
                        hintText: "الأسم")),
                TextFormField(
                    controller: emailTextEdtController,
                    onChanged: (value) => setState(() {
                          registerRequest =
                              registerRequest.copyWith(email: value.trim());
                        }),
                    decoration: const InputDecoration(
                        helperText: StringManager.emptyStr,
                        labelText: "الإيميل",
                        hintText: "الإيميل")),
                TextFormField(
                    controller: addressTextEdtController,
                    onChanged: (value) => setState(() {
                          registerRequest =
                              registerRequest.copyWith(address: value.trim());
                        }),
                    decoration: const InputDecoration(
                        helperText: StringManager.emptyStr,
                        labelText: "العنوان",
                        hintText: "العنوان")),
                TextFormField(
                    controller: phoneTextEdtController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() {
                          registerRequest = registerRequest.copyWith(
                              phoneNumber: value.trim());
                        }),
                    decoration: const InputDecoration(
                        helperText: StringManager.emptyStr,
                        labelText: "رقم الجوال",
                        hintText: "رقم الجوال")),
                TextFormField(
                    controller: passwordTextEdtController,
                    onChanged: (value) => setState(() {
                          registerRequest =
                              registerRequest.copyWith(password: value.trim());
                        }),
                    decoration: const InputDecoration(
                        helperText: StringManager.emptyStr,
                        labelText: "كلمة المرور",
                        hintText: "كلمة المرور")),
                AuthButton(
                    text: "تسجيل",
                    onPressed: () {
                      ref
                          .read(authControllerProvider.notifier)
                          .signUp(registerRequest);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/StringsManager.dart';
import '../../../utils/Resouces/ThemeManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';
import '../Data/Repositories/AuthController.dart';
import '../Data/RequestsModels/RegisterRequestsModels/RegisterRequest.dart';
import '../_CommonWidgets/AuthButton.dart';

@RoutePage()
class RegisterAsDealerView extends ConsumerStatefulWidget {
  const RegisterAsDealerView({super.key});

  @override
  ConsumerState createState() => _RegisterAsDealerViewState();
}

class _RegisterAsDealerViewState extends ConsumerState<RegisterAsDealerView> {
  final TextEditingController emailTextEdtController = TextEditingController();
  final TextEditingController passwordTextEdtController =
      TextEditingController();
  final TextEditingController phoneTextEdtController = TextEditingController();
  final TextEditingController nameTextEdtController = TextEditingController();
  final TextEditingController addressTextEdtController =
      TextEditingController();
  RegisterRequest registerRequest =
      const RegisterRequest(userId: "", name: "", email: "", password: "");

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
                  child: Text("تسجيل كتاجر",
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
                              registerRequest.copyWith(email: value);
                        }),
                    decoration: const InputDecoration(
                        helperText: StringManager.emptyStr,
                        labelText: "الأيميل",
                        hintText: "الأيميل")),
                TextFormField(
                    controller: passwordTextEdtController,
                    onChanged: (value) => setState(() {
                          registerRequest =
                              registerRequest.copyWith(password: value);
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

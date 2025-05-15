import 'package:auto_route/auto_route.dart';
import 'package:farming_market/Features/AuthenticationFeature/Domain/User/UserResponseDTO.dart';
import 'package:farming_market/Features/AuthenticationFeature/Presentation/Notifiers/ProfileNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/StringsManager.dart';
import '../../../utils/Resouces/ThemeManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';

@RoutePage()
class EditProfileView extends ConsumerStatefulWidget {
  final UserResponseDTO userResponseDTO;

  const EditProfileView({super.key, required this.userResponseDTO});

  @override
  ConsumerState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController phoneTextEdtController = TextEditingController();
  final TextEditingController addressTextEdtController =
      TextEditingController();
  UserResponseDTO userResponseDTO = UserResponseDTO.empty();

  @override
  void initState() {
    super.initState();

    Future(() {
      userResponseDTO = widget.userResponseDTO;
      nameEditingController.text = widget.userResponseDTO.name;
      phoneTextEdtController.text = widget.userResponseDTO.phoneNumber ?? "";
      addressTextEdtController.text = widget.userResponseDTO.address ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.surface,
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
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
                  child: Text("تعديل بيانات المستخدم",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const Divider(thickness: 1),
                const SizedBox(height: AppSizeManager.s20),
                TextFormField(
                  controller: nameEditingController,
                  onChanged: (value) =>
                      userResponseDTO = userResponseDTO.copyWith(name: value),
                  decoration: const InputDecoration(
                      helperText: StringManager.emptyStr,
                      labelText: "الأسم",
                      hintText: "الأسم"),
                ),
                TextFormField(
                  controller: phoneTextEdtController,
                  onChanged: (value) => userResponseDTO =
                      userResponseDTO.copyWith(phoneNumber: value),
                  decoration: const InputDecoration(
                      helperText: StringManager.emptyStr,
                      labelText: "رقم التواصل",
                      hintText: "رقم التواصل"),
                ),
                TextFormField(
                  controller: addressTextEdtController,
                  onChanged: (value) => userResponseDTO =
                      userResponseDTO.copyWith(address: value),
                  decoration: const InputDecoration(
                      helperText: StringManager.emptyStr,
                      labelText: "الموقع",
                      hintText: "الموقع"),
                ),
                ElevatedButton(
                    onPressed: () async {
                      var result = await ref
                          .read(profileNotifierProvider.notifier)
                          .updateUserInfo(userResponseDTO);
                      if (result) {
                        if (context.mounted) {
                          context.router.maybePop();
                        }
                      }
                    },
                    child: const Text("إتمام التعديل"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

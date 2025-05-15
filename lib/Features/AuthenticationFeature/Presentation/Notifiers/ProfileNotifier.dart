import 'package:farming_market/Features/AuthenticationFeature/Data/Repositories/AuthController.dart';
import 'package:farming_market/Features/AuthenticationFeature/Domain/User/UserResponseDTO.dart';
import 'package:farming_market/Features/_SharedData/AbstractDataRepository.dart';
import 'package:farming_market/utils/Extensions.dart';
import 'package:farming_market/utils/SharedOperations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ProfileNotifier.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier with SharedUserOperations {
  @override
  Stream<UserResponseDTO> build() {
    return ref
        .read(repositoryClientProvider)
        .authRepository
        .getUserInfoByIdStream(
            ref.watch(authControllerProvider).value?.user?.uid ?? "ss");
  }

  Future<bool> updateUserInfo(UserResponseDTO user) async {
    var result = await ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .authRepository
            .updateUser(user,
                ref.read(authControllerProvider).requireValue!.user!.uid));
    return !result.hasError;
  }
}

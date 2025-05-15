import 'package:farming_market/utils/Extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../ExceptionHandler/MessageEmitter.dart';
import '../../../../ExceptionHandler/MessageTypes.dart';
import '../../../../utils/SharedOperations.dart';
import '../../../_SharedData/AbstractDataRepository.dart';
import '../../Domain/User/UserRole.dart';
import '../RequestsModels/LoginRequest/LoginEntityRequest.dart';
import '../RequestsModels/RegisterRequestsModels/RegisterRequest.dart';

part 'AuthController.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController with SharedUserOperations {
  @override
  FutureOr<UserRole?> build() async {
    try {
      return await ref
          .read(repositoryClientProvider)
          .authRepository
          .getUserTypeDoc();
    } on Exception {
      return null;
    }
  }

  Future<void> signIn(LoginRequest request) async {
    state = const AsyncLoading();
    ref
        .read(messageEmitterProvider.notifier)
        .setMessage(PendingMessage("يتم تسجيل الدخول"));
    state = await AsyncValue.guard(() async =>
        ref.read(repositoryClientProvider).authRepository.signIn(request));
    if (state.hasError) {
      ref
          .read(messageEmitterProvider.notifier)
          .setMessage(FailedMessage(Exception("${state.error}")));
      state = const AsyncData(null);
      return;
    }
    if (state.hasValue) {
      state.requireValue != null
          ? ref
              .read(messageEmitterProvider.notifier)
              .setMessage(SuccessfulMessage("تم تسجيل الدخول بنجاح"))
          : null;
    }
  }

  bool validateRegisterRequest(RegisterRequest request) {
    if (!isValidUserName(request.name)) {
      ref
          .read(messageEmitterProvider.notifier)
          .setMessage(FailedMessage(Exception("الأسم فارغ")));
      return false;
    }
    if (!isValidEmail(request.email)) {
      ref
          .read(messageEmitterProvider.notifier)
          .setMessage(FailedMessage(Exception("ليس شكل ايميل")));
      return false;
    }
    if (!isValidPassword(request.password)) {
      ref
          .read(messageEmitterProvider.notifier)
          .setMessage(FailedMessage(Exception("كلمة المرور اقصر من 6 احرف")));
      return false;
    }
    if (request.runtimeType != CustomerRegisterRequest) {
      return true;
    }
    if (!isValidNumber((request as CustomerRegisterRequest).phoneNumber)) {
      ref
          .read(messageEmitterProvider.notifier)
          .setMessage(FailedMessage(Exception("الرقم غير صالح")));
      return false;
    }
    if (!isValidUserName(request.address)) {
      ref
          .read(messageEmitterProvider.notifier)
          .setMessage(FailedMessage(Exception("عنوانك فارغ")));
      return false;
    }
    return true;
  }

  Future<void> signUp(RegisterRequest request) async {
    var valid = validateRegisterRequest(request);
    if (!valid) return;
    state = const AsyncLoading();
    var res = await ref.operationPipeLine(
        func: () =>
            ref.read(repositoryClientProvider).authRepository.signUp(request));

    if (res.hasValue) {
      state = AsyncData(res.requireValue);
    }
    if (res.hasError) {
      state = const AsyncData(null);
    }
  }

  Future<void> signOut() async {
    await ref.read(repositoryClientProvider).authRepository.signOut();
    state = const AsyncData(null);
  }
}

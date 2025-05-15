import 'package:farming_market/Features/_SharedData/AbstractDataRepository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../AuthenticationFeature/Data/Repositories/AuthController.dart';
import '../../Domain/ChatModel.dart';
import '../../Domain/MessageModel.dart';

part 'ChatController.g.dart';

@riverpod
class ChatController extends _$ChatController {
  @override
  FutureOr<ChatModel> build(String otherID) async {
    ChatModel model = ChatModel.testModel();
    var currentUserRole = ref.read(authControllerProvider).requireValue;

    model = await ref
        .read(repositoryClientProvider)
        .chatRepository
        .getChatModel(currentUserRole!.user!.uid, otherID);

    return model;
  }

  Future<void> onSendMessage(String message) async {
    if (message.isNotEmpty) {
      MessageModel messageModel = MessageModel(
          text: message,
          senderId: state.requireValue.firstSideId,
          sendDateTime: DateTime.now());
      ref
          .read(repositoryClientProvider)
          .chatRepository
          .sendMessage(messageModel, state.requireValue.chatId);
    }
  }

  Stream<List<MessageModel>> messagesStream() => ref
      .watch(repositoryClientProvider)
      .chatRepository
      .getMessages(state.requireValue.chatId);
}

@riverpod
Stream<List<MessageModel>> chatMessages(ChatMessagesRef ref, String otherId) {
  return ref.watch(chatControllerProvider(otherId).notifier).messagesStream();
}

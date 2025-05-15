import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_market/Features/AuthenticationFeature/Domain/User/UserResponseDTO.dart';
import 'package:farming_market/Features/_SharedData/AbstractDataRepository.dart';
import 'package:farming_market/utils/Extensions.dart';
import 'package:farming_market/utils/FirebaseConstants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Domain/ChatModel.dart';
import '../../Domain/MessageModel.dart';

class ChatRepository extends AbstractRepository {
  final Ref ref;

  ChatRepository({required this.ref});

  Future<String> getOtherName(String otherID) async {
    if ((await FirebaseFirestore.instance
            .collection(FirebaseConstants.usersCollection)
            .doc(otherID)
            .get())
        .exists) {
      return (await FirebaseFirestore.instance
                  .collection(FirebaseConstants.usersCollection)
                  .doc(otherID)
                  .get())
              .data()?[UserResponseDTO.firebaseName] ??
          "Null User";
    }
    if ((await FirebaseFirestore.instance
            .collection(FirebaseConstants.usersCollection)
            .doc(otherID)
            .get())
        .exists) {
      return (await FirebaseFirestore.instance
                  .collection(FirebaseConstants.usersCollection)
                  .doc(otherID)
                  .get())
              .data()?[UserResponseDTO.firebaseName] ??
          "Null User";
    }
    return "Nothing";
  }

  Stream<List<MessageModel>> getMessages(String chatID) {
    return firebaseFireStore
        .collection(FirebaseConstants.chatsCollection)
        .doc(chatID)
        .collection(FirebaseConstants.messagesCollection)
        .orderBy(MessageModel.firebaseSendDateTime, descending: false)
        .snapshots()
        .asyncMap((event) =>
            event.docs.map((e) => MessageModel.fromMap(e.data())).toList());
  }

  Future<ChatModel> getChatModel(
      String firstSideID, String secondSideID) async {
    var doesExist = (await firebaseFireStore
            .collection(FirebaseConstants.chatsCollection)
            .doc([firstSideID, secondSideID].constructChatID())
            .get())
        .exists;
    print(doesExist);
    if (!doesExist) {
      print("aaaa");
      await initChat(ChatModel(
          firstSideName: await getOtherName(firstSideID),
          firstSideId: firstSideID,
          secondSideName: await getOtherName(secondSideID),
          secondSideId: secondSideID,
          chatId: [firstSideID, secondSideID].constructChatID()));
    }
    var chatModel = ChatModel.fromMap((await firebaseFireStore
            .collection(FirebaseConstants.chatsCollection)
            .doc([firstSideID, secondSideID].constructChatID())
            .get())
        .data()!);
    if (chatModel.firstSideId == firstSideID) {
      return chatModel;
    }
    var s = chatModel.copyWith();

    chatModel = chatModel.copyWith(
        firstSideId: s.secondSideId,
        firstSideName: s.secondSideName,
        secondSideId: s.firstSideId,
        secondSideName: s.secondSideName);

    return chatModel;
  }

  Future<void> initChat(ChatModel chatModel) async {
    firebaseFireStore
        .collection(FirebaseConstants.chatsCollection)
        .doc(chatModel.chatId)
        .set(chatModel.toMap());
  }

  Future<void> sendMessage(MessageModel messageModel, String chatID) async {
    firebaseFireStore
        .collection(FirebaseConstants.chatsCollection)
        .doc(chatID)
        .collection(FirebaseConstants.messagesCollection)
        .add(messageModel.toMap());
  }
}

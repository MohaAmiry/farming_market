import 'package:dart_mappable/dart_mappable.dart';

part 'ChatModel.mapper.dart';

@MappableClass()
class ChatModel with ChatModelMappable {
  final String firstSideName;
  final String firstSideId;
  final String secondSideName;
  final String secondSideId;
  final String chatId;

  const ChatModel(
      {required this.firstSideName,
      required this.firstSideId,
      required this.secondSideName,
      required this.secondSideId,
      required this.chatId});

  static const fromMap = ChatModelMapper.fromMap;

  static get firebaseChatId => "chatId";

  static get firebaseFirstSideId => "firstSideId";

  static get firebaseFirstSideName => "firstSideName";

  static get firebaseSecondSideId => "secondSideId";

  static get firebaseSecondSideName => "secondSideName";

  factory ChatModel.testModel() => const ChatModel(
        firstSideName: "firstSideName",
        firstSideId: "firstSideID",
        secondSideName: "secondSideName",
        secondSideId: "secondSideID",
        chatId: "firstSideID_secondSideID",
      );
}

import 'package:dart_mappable/dart_mappable.dart';

part 'MessageModel.mapper.dart';

@MappableClass()
class MessageModel with MessageModelMappable {
  final String text;
  final String senderId;
  final DateTime sendDateTime;

  static get firebaseText => "text";
  static get firebaseSenderId => "senderId";
  static get firebaseSendDateTime => "sendDateTime";

  const MessageModel(
      {required this.text, required this.senderId, required this.sendDateTime});

  static const fromMap = MessageModelMapper.fromMap;
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/Resouces/ColorManager.dart';
import '../../../utils/Resouces/ValuesManager.dart';
import '../../SplashFeature/ErrorView.dart';
import 'Controller/ChatController.dart';
import '_Widgets/MessageWidget.dart';

@RoutePage()
class ChatView extends ConsumerStatefulWidget {
  final String otherID;
  final String otherName;

  const ChatView({super.key, required this.otherID, required this.otherName});

  @override
  ConsumerState createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  TextEditingController messageController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = chatControllerProvider(widget.otherID);
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.otherName,
              style: Theme.of(context).textTheme.titleLarge)),
      backgroundColor: ColorManager.surface,
      body: ref.watch(chatProvider).when(
            data: (data) => Column(
              children: [
                Flexible(
                  child: ref.watch(chatMessagesProvider(widget.otherID)).when(
                      data: (data) => ListView(
                          reverse: true,
                          children: data.reversed
                              .map((e) => MessageWidget(
                                  message: e.text,
                                  isMe: e.senderId != widget.otherID))
                              .toList()),
                      error: (error, stackTrace) => ErrorView(error: error),
                      loading: () =>
                          const Center(child: CircularProgressIndicator())),
                ),
                Container(
                  decoration:
                      const BoxDecoration(color: ColorManager.primaryContainer),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 12,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 17,
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                  helperText: null,
                                  errorText: null,
                                  hintText: "ارسل رسالة",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppSizeManager.s5),
                                  )),
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () async {
                                await ref
                                    .read(chatControllerProvider(widget.otherID)
                                        .notifier)
                                    .onSendMessage(
                                        messageController.value.text);
                                messageController.text = "";
                              }),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            error: (error, stackTrace) => ErrorView(error: error),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}

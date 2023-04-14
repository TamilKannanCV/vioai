import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vioai/data/models/message.dart';
import 'package:vioai/data/repositories/repository.dart';
import 'package:vioai/injection.dart';
import 'package:vioai/logger.dart';
import 'package:vioai/views/screens/home/home_screen_viewmodel.dart';
import 'package:vioai/views/widgets/chat_message_vm.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    super.key,
    required this.userMessage,
  });
  final Message userMessage;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<ChatMessageVm>(),
      child: _ChatMsgWidget(userMessage: userMessage),
    );
  }
}

class _ChatMsgWidget extends StatefulWidget {
  const _ChatMsgWidget({required this.userMessage});

  final Message userMessage;

  @override
  State<_ChatMsgWidget> createState() => _ChatMsgWidgetState();
}

class _ChatMsgWidgetState extends State<_ChatMsgWidget> {
  late ChatMessageVm vm;

  @override
  void initState() {
    super.initState();
    vm = Provider.of<ChatMessageVm>(context, listen: false);
    vm.getResponseForQuery("${widget.userMessage.content}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              const SizedBox(width: 5.0),
              const CircleAvatar(
                radius: 12.0,
                foregroundImage: NetworkImage(
                    "https://lh3.googleusercontent.com/ogw/AOLn63GuQXtLaZeMfo3ZIJiDlqdGFFq1uzlC0jJrjPm7gQ=s64-c-mo"),
              ),
              const SizedBox(width: 13.0),
              Expanded(
                child: Text(
                  "${widget.userMessage.content}",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        Consumer<ChatMessageVm>(
          builder: (context, model, child) => Visibility(
            visible: model.botMsg != null,
            replacement: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0)
                  .copyWith(top: 10.0),
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 10.0,
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) => const LinearGradient(
                        colors: [
                          Color(0xFF61b5f0),
                          Color(0xFF375fdf),
                          Color(0xFF61b5f0),
                        ],
                      ).createShader(bounds),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Text("Please wait, I'm thinking..."),
                ],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 3.0),
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) =>
                            const LinearGradient(colors: [
                          Color(0xFF6eb059),
                          Color(0xFFbac81d),
                          Color(0xFFc7bd41),
                        ]).createShader(bounds),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          size: 20.0,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          "${model.botMsg?.content}",
                          style: GoogleFonts.roboto(),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(bottom: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ActionChip(
                          label: const Text("Copy"),
                          avatar: const Icon(Icons.copy),
                          onPressed: () =>
                              Clipboard.setData(const ClipboardData(text: "")),
                        ),
                        const SizedBox(width: 10.0),
                        ActionChip(
                          label: const Text("Speak"),
                          avatar: const Icon(Icons.volume_up_rounded),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

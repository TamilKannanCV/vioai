import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:vioai/gen/assets.gen.dart';
import 'package:vioai/views/widgets/chat_message.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final chats = <ChatMessageWidget>[
    const ChatMessageWidget(
      userMessage: "help me understand the pros/cons of buying an electric one",
    ),
    const ChatMessageWidget(
      userMessage: "help me understand the pros/cons of buying an electric one",
    ),
  ];

  bool lock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf2f5fa),
      bottomNavigationBar: Container(
        height: 65.0,
        margin: const EdgeInsets.symmetric(horizontal: 15.0).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          right: 8.0,
          top: 8.0,
          left: chats.isEmpty ? null : 8.0,
        ),
        child: Row(
          children: [
            if (chats.isNotEmpty) ...[
              IconButton(
                onPressed: () {
                  setState(() {
                    chats.clear();
                  });
                },
                icon: Assets.images.broom.svg(
                  width: 25.0,
                  height: 25.0,
                ),
              ),
              const SizedBox(width: 2.0),
            ],
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter a prompt here",
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 15.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: lock ? null : () {},
              icon: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) => const LinearGradient(
                  colors: [
                    Color(0xFF61b5f0),
                    Color(0xFF375fdf),
                  ],
                ).createShader(bounds),
                child: const Icon(Icons.send_sharp),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const CustomAppBar(),
          chats.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.bubble_chart_outlined,
                        size: 45.0,
                        color: Color(0xFF3e4245),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Start asking questions to VioAI",
                        style: TextStyle(
                          color: Color.fromARGB(255, 110, 113, 116),
                        ),
                      )
                    ],
                  )),
                )
              : SliverList(delegate: SliverChildListDelegate(chats))
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      pinned: false,
      backgroundColor: Colors.transparent,
      title: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: GradientText(
                'AI',
                colors: const [
                  Color(0xFF61b5f0),
                  Color(0xFF375fdf),
                  Color(0xFF78cef8),
                ],
              ),
            ),
          ],
          text: "Vio",
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:vioai/data/openAI/models/enums/role.dart';
import 'package:vioai/data/openAI/models/message.dart';
import 'package:vioai/gen/assets.gen.dart';
import 'package:vioai/views/home/home_screen_viewmodel.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool lock = false;

  late HomeScreenViewModel homeScreenVm;

  TextEditingController queryPrompt = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late ScrollController listScrollController;

  @override
  void initState() {
    super.initState();
    homeScreenVm = Provider.of<HomeScreenViewModel>(context, listen: false);
    homeScreenVm.watchUserAuthStatus();
    listScrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf2f5fa),
      bottomNavigationBar: Consumer<HomeScreenViewModel>(
        builder: (context, model, child) {
          if (model.isLoggedIn == false) {
            return const SizedBox.shrink();
          }
          return Container(
            height: 65.0,
            margin: const EdgeInsets.symmetric(horizontal: 15.0).copyWith(
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              right: 8.0,
              top: 8.0,
              left: model.chatWidgets.isEmpty ? null : 8.0,
            ),
            child: Row(
              children: [
                if (model.chatWidgets.isNotEmpty) ...[
                  IconButton(
                    onPressed: () => model.clearChats(),
                    icon: Assets.images.broom.svg(
                      width: 25.0,
                      height: 25.0,
                    ),
                  ),
                  const SizedBox(width: 2.0),
                ],
                Expanded(
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: queryPrompt,
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
                      validator: (str) {
                        if (str == null || str.trim().isEmpty) {
                          return "no query found";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: lock
                      ? null
                      : () {
                          if (formKey.currentState?.validate() == false) return;
                          model.sendMessage(
                            Message(
                              role: Role.user.name,
                              content: queryPrompt.text.trim(),
                            ),
                          );
                          queryPrompt.clear();
                          listScrollController.animateTo(
                            listScrollController.position.maxScrollExtent,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        },
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
          );
        },
      ),
      body: CustomScrollView(
        controller: listScrollController,
        slivers: [
          const CustomAppBar(),
          Consumer<HomeScreenViewModel>(
            builder: (context, model, child) {
              if (!model.isLoggedIn) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.lock_outline,
                          size: 50.0,
                        ),
                        const SizedBox(height: 8.0),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: const Text(
                            "Create account with Google to start using VioAI.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Builder(
                          builder: (context) {
                            if (model.authenticating) {
                              return const CircularProgressIndicator.adaptive();
                            }
                            return FilledButton(
                              onPressed: () => model.authenticateWithGoogle(),
                              child: const Text("Sign-in with Google"),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (model.messages.isEmpty) {
                return SliverFillRemaining(
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
                );
              }
              return SliverList(
                delegate: SliverChildListDelegate(
                  model.chatWidgets,
                ),
              );
            },
          ),
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

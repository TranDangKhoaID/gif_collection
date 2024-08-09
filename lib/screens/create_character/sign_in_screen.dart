import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gif_collection/common/share_colors.dart';
import 'package:gif_collection/models/character_model.dart';
import 'package:gif_collection/screens/create_character/widgets/character_widget.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'controller/auth_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String url = '';
  //delcaring controller
  final _controller = PageController();
  //name text controller
  //final TextEditingController _txtName = TextEditingController();
  //controller
  final _authController = Get.put(AuthController());

  @override
  void dispose() {
    super.dispose();
    //_txtName.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/bg.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'create_your_character'.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //
                  SizedBox(
                    height: size.height * 0.5,
                    child: PageView.builder(
                      itemCount: characters.length,
                      controller: _controller,
                      itemBuilder: (context, index) {
                        url = characters[index].url.toString();
                        return CharacterWidget(character: characters[index]);
                      },
                    ),
                  ),

                  SmoothPageIndicator(
                    controller: _controller,
                    count: characters.length,
                    effect: WormEffect(
                      activeDotColor: ShareColors.kPrimaryColor,
                      dotColor: ShareColors.kPrimaryColor.withOpacity(0.5),
                      dotHeight: 16,
                      dotWidth: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SignInButton(
                      Buttons.google,
                      text: 'sign_in_with_google'.tr,
                      onPressed: () => _authController.signInWithGoogle(url),
                    ),
                  ),
                  //button
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

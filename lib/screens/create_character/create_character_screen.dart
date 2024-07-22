import 'package:card_tikimon_collection/common/share_colors.dart';
import 'package:card_tikimon_collection/common/share_obs.dart';
import 'package:card_tikimon_collection/common/share_styles.dart';
import 'package:card_tikimon_collection/models/character_model.dart';
import 'package:card_tikimon_collection/screens/create_character/controller/sign_up_controller.dart';
import 'package:card_tikimon_collection/screens/create_character/widgets/character_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateCharacterScreen extends StatefulWidget {
  const CreateCharacterScreen({super.key});

  @override
  State<CreateCharacterScreen> createState() => _CreateCharacterScreenState();
}

class _CreateCharacterScreenState extends State<CreateCharacterScreen> {
  String url = 'Vãi cc';
  //delcaring controller
  final _controller = PageController();
  //name text controller
  final TextEditingController _txtName = TextEditingController();
  //controller
  final signUpController = Get.put(SignUpController());

  @override
  void dispose() {
    super.dispose();
    _txtName.dispose();
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
            padding: EdgeInsets.only(top: 80),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Vui lòng tạo nhân vật của bạn',
                      style: TextStyle(
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
                    child: TextFormField(
                      controller: _txtName,
                      decoration: InputDecoration(
                        focusedBorder: ShareStyles.defaultOutlineBorder,
                        border: ShareStyles.defaultOutlineBorder,
                        enabledBorder: ShareStyles.defaultOutlineBorder,
                        disabledBorder: ShareStyles.defaultOutlineBorder,
                        errorBorder: ShareStyles.defaultOutlineBorder,
                        prefixIcon: const Icon(Icons.abc_outlined),
                        hintText: 'Tên nhân vật của bạn',
                        hintStyle:
                            ShareStyles.boldStyle.copyWith(color: Colors.white),
                        isDense: true,
                      ),
                    ),
                  ),
                  //button
                  TextButton(
                    onPressed: () {
                      signUpController.signUp(
                        name: _txtName.text,
                        url: url,
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // Màu chữ
                      backgroundColor: ShareColors.kPrimaryColor, // Màu nền
                    ),
                    child: const Text('Tạo'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

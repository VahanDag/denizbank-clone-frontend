import 'package:denizbank_clone/core/constants/app_colors.dart';
import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/core/widgets/custom_appbar.dart';
import 'package:denizbank_clone/core/widgets/custom_buttons.dart';
import 'package:denizbank_clone/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part './widgets/register_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  // Bir sonraki sayfaya geçiş için fonksiyon
  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appBarTitle("denizbank müşterisi ol"),
      ),
      body: Center(
          child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [_RegisterReminding(onContinue: _goToNextPage), const RegisterInformation()],
      )),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _RegisterReminding extends StatelessWidget {
  // Callback fonksiyonunu parametre olarak ekleyelim
  final VoidCallback onContinue;

  const _RegisterReminding({required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: context.deviceWidth * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: PaddingConstant.paddingVertical,
                child: Column(
                  children: [
                    _infoTile(context, "Bilgilerinizi Doldurun!",
                        "Bilgilerinizi girerek DenizBank'lı olmaya hemen adım atın.", IconEnum.information),
                    _infoTile(
                        context,
                        "Kimliğinizi Doğrulayalım!",
                        "Yeni kimlik kartına sahipseniz, kimlik doğrulaması için müşteri temsilcimize bağlanacaksınız. T.C kimlik kartınızı yanınızda bulundurmayı unutmayın.",
                        IconEnum.identity),
                    _infoTile(
                        context,
                        "DenizBank'lı Olun!",
                        "Artık MobilDeniz ile dilediğiniz yerden 7x24 işlemlerinizi yapabilir, DenizBank'ın ayrıcalıklarından faydalanabilirsiniz.",
                        IconEnum.shake_hands)
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
                onPressed: onContinue,
                text: "Devam",
                width: context.deviceWidth * 0.9,
                margin: PaddingConstant.paddingOnlyBottomHigh),
          ],
        ),
      ),
    );
  }

  ListTile _infoTile(BuildContext context, String title, String subtitle, IconEnum icon) {
    return ListTile(
      title: Text(title, style: context.textTheme.titleMedium?.copyWith(color: AppColors.mainBlue)),
      subtitle: Text(subtitle),
      leading: Image.asset(icon.iconName),
    );
  }
}

class RegisterInformation extends StatefulWidget {
  const RegisterInformation({super.key});

  @override
  State<RegisterInformation> createState() => _RegisterInformationState();
}

class _RegisterInformationState extends State<RegisterInformation> {
  late final TextEditingController _tcNoController;
  late final TextEditingController _passwordController;
  late final TextEditingController _phoneNumberController;
  @override
  void initState() {
    super.initState();
    _tcNoController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: context.deviceWidth * 0.9,
          child: Column(
            children: [
              const SizedBox(height: 40),
              CustomTextField(
                  margin: PaddingConstant.paddingVerticalHigh,
                  inputFormatters: [LengthLimitingTextInputFormatter(11), FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  title: "T.C. Kimlik Numaranız",
                  hintText: "Giriniz",
                  isPassword: false,
                  controller: _tcNoController),
              CustomTextField(
                  inputFormatters: [LengthLimitingTextInputFormatter(6), FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  title: "Şifre Belirleyin",
                  hintText: "XXXXXX",
                  controller: _passwordController),
              CustomTextField(
                  margin: PaddingConstant.paddingVerticalHigh,
                  inputFormatters: [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  title: "Cep Telefonu Numaranız",
                  hintText: "(5XX XXX XX XX)",
                  isPassword: false,
                  controller: _phoneNumberController),
              CheckboxRichTextWidget(
                richText: '**Kişisel Verilerin Korunması Pazarlama Amaçlı Açık Rıza Metni**\'ni okudum.',
                onChanged: (value) {
                  print('First checkbox changed to: $value');
                },
              ).margin(PaddingConstant.paddingOnlyTopHigh),
              const SizedBox(height: 16),
              CheckboxRichTextWidget(
                richText: '**Kişisel Verilerin Korunması Kanunu ile ilgili Aydınlatma metni**\'ni okudum, anladım.',
                onChanged: (value) {
                  print('Second checkbox changed to: $value');
                },
              ),
              const SizedBox(height: 40),
              CustomButton(
                  onPressed: () {},
                  text: "Müşteri Ol",
                  width: context.deviceWidth * 0.9,
                  margin: PaddingConstant.paddingOnlyBottomHigh),
            ],
          ),
        ),
      ),
    );
  }
}

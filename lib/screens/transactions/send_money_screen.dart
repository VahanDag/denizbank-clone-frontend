import 'package:denizbank_clone/core/constants/app_colors.dart';
import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/core/constants/validators.dart';
import 'package:denizbank_clone/core/widgets/custom_appbar.dart';
import 'package:denizbank_clone/core/widgets/custom_bottomsheet.dart';
import 'package:denizbank_clone/core/widgets/custom_buttons.dart';
import 'package:denizbank_clone/core/widgets/custom_snackbar.dart';
import 'package:denizbank_clone/core/widgets/custom_tabbar.dart';
import 'package:denizbank_clone/core/widgets/custom_textfield.dart';
import 'package:denizbank_clone/cubit/cards/cards_cubit.dart';
import 'package:denizbank_clone/cubit/transaction/transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: appBarTitle("para gönder")),
      body: Column(
        children: [
          CustomTabBar(
            margin: PaddingConstant.paddingAll,
            controller: _tabController,
            tabs: const [
              Text("Hesaptan"),
              Text("Kredi Kartından"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                SendMoneyFromBankCard(),
                Center(child: Text("Yapım Aşamasında")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SendMoneyFromBankCard extends StatefulWidget {
  const SendMoneyFromBankCard({super.key});

  @override
  State<SendMoneyFromBankCard> createState() => _SendMoneyFromBankCardState();
}

class _SendMoneyFromBankCardState extends State<SendMoneyFromBankCard> with TickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _ibanController = TextEditingController();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.index != _currentTabIndex) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);

    _ibanController.dispose();
    _nameController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsCubit, CardsState>(
      builder: (context, state) {
        final selectedCard = context.read<CardsCubit>().selectedDebitCard; // For now
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: context.deviceWidth * 0.95,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Gönderen Hesap", style: context.textTheme.titleMedium?.copyWith(color: AppColors.mainBlue))
                        .margin(PaddingConstant.paddingOnlyTopHigh),
                    Card(
                      child: ListTile(
                        title: Text("Denizbank", style: context.textTheme.titleMedium),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("7890 1234", style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600)),
                            Text("Kullanılabilir Bakiye",
                                style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600)),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.keyboard_arrow_down_rounded),
                            Text("${selectedCard?.balance ?? 0} TL")
                          ],
                        ),
                      ),
                    ),
                    Text("Alıcı Bilgileri", style: context.textTheme.titleMedium?.copyWith(color: AppColors.mainBlue))
                        .margin(PaddingConstant.paddingOnlyTopHigh),
                    CustomTabBar(
                        margin: PaddingConstant.paddingVerticalMedium,
                        controller: _tabController,
                        tabs: const [Text("IBAN"), Text("Hesap No"), Text("Kart")]),
                    IndexedStack(
                      index: _currentTabIndex,
                      children: [
                        // IBAN Tab
                        buildIbanForm(context),
                        // Hesap No Tab
                        const Center(
                            child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("Hesap No\nYapım Aşamasında", textAlign: TextAlign.center),
                        )),
                        // Kart Tab
                        const Center(
                            child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("Kart ile para gönderimi\nYapım Aşamasında", textAlign: TextAlign.center),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildIbanForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            title: "IBAN Numarası",
            hintText: "",
            keyboardType: TextInputType.number,
            inputFormatters: [LengthLimitingTextInputFormatter(24), FilteringTextInputFormatter.digitsOnly],
            prefix: ConstrainedBox(
              constraints: BoxConstraints.loose(const Size(0, 0)),
              child: const Center(child: Text("TR", style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            controller: _ibanController,
            validator: Validators.validateIban,
          ),
          CustomTextField(
            margin: PaddingConstant.paddingVertical,
            title: "Alıcı Adı Soyadı",
            hintText: "Giriniz",
            controller: _nameController,
            validator: Validators.validateFullName,
          ),
          Text("İşlem Bilgileri", style: context.textTheme.titleMedium?.copyWith(color: AppColors.mainBlue))
              .margin(PaddingConstant.paddingOnlyTop),
          CustomTextField(
            margin: PaddingConstant.paddingVertical,
            title: "Tutar",
            hintText: "Giriniz",
            suffix: ConstrainedBox(
              constraints: BoxConstraints.loose(const Size(0, 0)),
              child: Center(child: Text("TL", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade600))),
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: _amountController,
            validator: Validators.validateAmount,
          ),
          CustomTextField(
            margin: PaddingConstant.paddingVertical,
            title: "Açıklama",
            hintText: "Giriniz",
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            suffix: ConstrainedBox(
              constraints: BoxConstraints.loose(const Size(0, 0)),
              child: Center(child: Text("0/50", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade600))),
            ),
            controller: _descriptionController,
            validator: Validators.validateDescription,
          ),
          CustomButton(
              width: double.infinity,
              margin: PaddingConstant.paddingVerticalHigh,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final transactionCubit = context.read<TransactionCubit>();
                  final cardsCubit = context.read<CardsCubit>();

                  final selectedCard = cardsCubit.selectedDebitCard;
                  if (selectedCard?.iban == null) {
                    AppSnackBar.showError(context: context, message: "Gönderen hesap seçilmedi");
                    return;
                  }

                  final amount = double.tryParse(_amountController.text);
                  if (amount == null || amount <= 0) {
                    AppSnackBar.showError(context: context, message: "Geçerli bir tutar giriniz");
                    return;
                  }

                  final success = await transactionCubit
                      .sendMoney(
                        fromIBAN: selectedCard!.iban!,
                        toIBAN: 'TR${_ibanController.text}',
                        amount: amount,
                        description: _descriptionController.text,
                      )
                      .withLoading(context);

                  if (success) {
                    cardsCubit.selectedDebitCard!.balance -= amount;
                    AppSnackBar.showSuccess(context: context, message: "Para transferi başarıyla gerçekleştirildi");
                    customBottomSheet(
                        showCloseButton: false,
                        isDismissible: false,
                        context: context,
                        title: "Transfer Başarılı",
                        child: bottomSheetSuccessWidget(
                            onPressed: () {
                              _amountController.clear();
                              _ibanController.clear();
                              _nameController.clear();
                              _descriptionController.clear();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            text: "${_nameController.text.toUpperCase()} adlı kişiye $amount TL başarıyla gönderildi."));
                  } else {
                    AppSnackBar.showError(context: context, message: "Para transferi başarısız oldu");
                  }
                }
              },
              text: "Gönder")
        ],
      ),
    );
  }
}

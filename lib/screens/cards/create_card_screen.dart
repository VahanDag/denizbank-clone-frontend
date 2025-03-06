import 'package:denizbank_clone/core/constants/app_colors.dart';
import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/core/widgets/custom_appbar.dart';
import 'package:denizbank_clone/core/widgets/custom_bottomsheet.dart';
import 'package:denizbank_clone/core/widgets/custom_buttons.dart';
import 'package:denizbank_clone/core/widgets/custom_snackbar.dart';
import 'package:denizbank_clone/cubit/cards/cards_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key});

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  bool _isDebitCard = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardsCubit, CardsState>(
      buildWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == CardsStatus.loaded) {
          customBottomSheet(
              showCloseButton: false,
              isDismissible: false,
              context: context,
              title: "Tebrikler",
              child: bottomSheetSuccessWidget(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  text: "Kartınız başarılı bir şekilde oluşturuldu. Yeni kartınız hayırlı olsun."));
        } else if (state.status == CardsStatus.error) {
          AppSnackBar.showError(context: context, message: state.errorMessage ?? "Bir şeyler ters gitti");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(title: appBarTitle("KART BAŞVURUSU")),
          body: SingleChildScrollView(
            child: Padding(
              padding: PaddingConstant.paddingAllMedium,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusConstant.borderRadius,
                      border: Border.all(width: 2, color: AppColors.mainBlue),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isDebitCard = true;
                              });
                            },
                            child: Container(
                              padding: PaddingConstant.paddingAllMedium,
                              decoration: BoxDecoration(
                                color: _isDebitCard ? AppColors.mainBlue.withOpacity(0.2) : Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Banka Kartı",
                                style: TextStyle(
                                  fontWeight: _isDebitCard ? FontWeight.bold : FontWeight.normal,
                                  color: _isDebitCard ? AppColors.mainBlue : Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isDebitCard = false;
                              });
                            },
                            child: Container(
                              padding: PaddingConstant.paddingAllMedium,
                              decoration: BoxDecoration(
                                color: !_isDebitCard ? AppColors.mainBlue.withOpacity(0.2) : Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Kredi Kartı",
                                style: TextStyle(
                                  fontWeight: !_isDebitCard ? FontWeight.bold : FontWeight.normal,
                                  color: !_isDebitCard ? AppColors.mainBlue : Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  FutureBuilder(
                    future: context.read<CardsCubit>().getCompanyCards(_isDebitCard),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("Kartlar çekilirken bir hata oluştu"));
                      } else {
                        final cards = snapshot.data ?? [];
                        if (cards.isEmpty) {
                          return const Center(child: Text("Size uygun bir kart bulunamadı"));
                        }
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cards.length,
                          itemBuilder: (BuildContext context, int index) {
                            final card = cards[index];
                            return GestureDetector(
                              onTap: () async =>
                                  await context.read<CardsCubit>().createCard(card.id, _isDebitCard).withLoading(context),
                              child: Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      card.imageURI,
                                      height: 200,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: PaddingConstant.paddingAllLow,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(card.cardName,
                                                style: context.textTheme.titleMedium?.copyWith(color: AppColors.mainBlue)),
                                            const SizedBox(height: 4),
                                            Text(
                                              card.cardDescription,
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text("Kart Türü: "),
                                                Text(_isDebitCard ? 'Banka' : 'Kredi',
                                                    style:
                                                        context.textTheme.titleSmall?.copyWith(color: AppColors.mainBlue)),
                                              ],
                                            ).margin(PaddingConstant.paddingOnlyRight)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:wenia/core/Entities/crypto/coin_entity.dart';
import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/core/utils/style/theme_app.dart';
import 'package:wenia/features/crypto/compare/bloc/compare_bloc.dart';

class CryptoComparePage extends StatefulWidget {
  const CryptoComparePage({super.key});

  @override
  State<CryptoComparePage> createState() => _CryptoComparePageState();
}

class _CryptoComparePageState extends State<CryptoComparePage> {
  
  // [init]
  @override
  void initState() {
    super.initState();
    
    context.read<CompareBloc>().add(DoGetCompareCoins());
  }

  // [Constructor]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          CultureService().getLocalResource("compare-crypto-title"),
          style: ThemeApp.textTheme.bodyLarge?.copyWith(color: ThemeApp.primaryColor)
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getCards(context),
            const SizedBox(height: 15),
            getGoBackButton(context),
          ]
        )
      )
    );
  }

  // [Widgets]
  Widget getCards(BuildContext context) {
    return BlocBuilder<CompareBloc, CompareState>(
      buildWhen: (previous, current) => current is CompareLoaded || current is CompareLoading,
      builder: (context, state) {
        if(state is CompareLoaded) {
          List<Widget> cards = [];
          
          for (var coin in state.coins) {
            cards.add(getCard(coin));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: cards,
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget getCard(CoinEntity coin) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                getName(coin),
                getSymbol(coin),
                getPrice(coin),
                getFavoriteButton(context, coin),
                getIcon(coin)
              ],
            )
          )
      )
    );
  }

  Widget getIcon(CoinEntity coin) {
    return Image.network(
      coin.image,
      height: 35,
      width: 35,
    );
  }

  Widget getSymbol(CoinEntity coin) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(
        coin.symbol.toUpperCase(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget getFavoriteButton(BuildContext context, CoinEntity coin) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: Icon(
        coin.isFavorite ? Icons.star : Icons.star_border,
        color: coin.isFavorite ? Colors.yellow : Colors.grey,
      )
    );
  }

  Widget getName(CoinEntity coin) {
    if(coin.name.split(" ").length > 2) {
      List<Widget> names = [];

      for (var name in coin.name.split(" ")) {
        names.add(Text(
          name,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ));
      }

      return Column(
        children: names);
    }
    else {

      return Text(
        coin.name,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
      );
    }
  }

  Widget getPrice(CoinEntity coin) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              '${formatCurrency(coin.currentPrice)} USD',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getGoBackButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(CultureService().getLocalResource("compare-crypto-go-back-button")),
    );
  }

  // [functions]
  String formatCurrency(double amount) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(amount);
  }
}
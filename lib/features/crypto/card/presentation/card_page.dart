import 'package:flutter/material.dart';
import 'package:wenia/core/Entities/crypto/coin_entity.dart';

class CardPage extends StatefulWidget {
  final CoinEntity coin;
  
  const CardPage({super.key, required this.coin});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  // [Properties]
  CoinEntity coin = CoinEntity.empty();

  void initLocalState() {
    coin = widget.coin;
  }

  // [Constructor]
  @override
  Widget build(BuildContext context) {
    // Read coin from widget
    initLocalState();

    return const Text(
      "Card",
      style: TextStyle(
        color: Colors.black,
      )
    );
  }

  // [Methods]
}
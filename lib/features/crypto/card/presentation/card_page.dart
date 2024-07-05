import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:wenia/core/Entities/crypto/coin_entity.dart';

class CardPage extends StatefulWidget {
  final CoinEntity coin;

  const CardPage({super.key, required this.coin});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  // [Properties]
  late CoinEntity coin;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    coin = widget.coin;
  }

  // [Constructor]
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getIcon(),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getSymbol(),
                        getFavoriteButton()
                      ],
                    ),
                    getName(),
                    getPrice(),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  // [Methods]
  Widget getIcon() {
    return Image.network(
      coin.image,
      height: 35,
      width: 35,
    );
  }

  Widget getSymbol() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(
        coin.symbol.toUpperCase(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      )
    );
  }

  Widget getFavoriteButton() {
    return
      IconButton(
        icon: Icon(
          _isFavorite ? Icons.star : Icons.star_border,
          color: _isFavorite ? Colors.yellow : Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _isFavorite = !_isFavorite;
          });
        },
    );
  }

  Widget getName() {
    return Text(
      coin.name,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 18,
      ),
    );
  }

  Widget getPrice() {
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
          )
      ],
      )
    );
  }

  // [functions]
  String formatCurrency(double amount) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(amount);
  }
}

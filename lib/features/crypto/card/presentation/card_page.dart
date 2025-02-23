import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:wenia/core/Entities/crypto/coin_entity.dart';
import 'package:wenia/core/config/environment_config.dart';
import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/features/common/message/message.dart';
import 'package:wenia/features/crypto/card/bloc/card_bloc.dart';
import 'package:wenia/features/crypto/list/bloc/crypto_list_bloc.dart';

class CardPage extends StatefulWidget {
  final CoinEntity coin;

  const CardPage({super.key, required this.coin});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  // [Properties]
  CoinEntity coin = CoinEntity.empty();

  @override
  void initState() {
    super.initState();
    coin = widget.coin;
  }

  @override
  void didUpdateWidget(CardPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.coin != oldWidget.coin) {
      setState(() {
        coin = widget.coin;
      });
    }
  }

  // [Constructor]
  @override
  Widget build(BuildContext context) {
    return BlocListener<CardBloc, CardState>(
          listener: (context, state) {
            if (state is CardShowMessage) {
              if(state.message.isNotEmpty) {
                Message().showMessage(context, CultureService().getLocalResource(state.message));
              }
            }

            if(state is CardLoaded) {
              context.read<CryptoListBloc>().add(DoGetWhitoutInfoCoins());
            }
          },
          child: Padding(
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
                              getFavoriteButton(context)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getName(),
                              getCheckbox()
                            ],
                          ),
                          getPrice(),
                        ],
                      ),
                    ),
                  ],
                ),
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
      ),
    );
  }

  Widget getFavoriteButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        coin.isFavorite ? Icons.star : Icons.star_border,
        color: coin.isFavorite ? Colors.yellow : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          // Update UX data
          coin.isFavorite = !coin.isFavorite;

          context.read<CardBloc>().add(DoSetFavorite(coin));
        });
      },
    );
  }

  Widget getName() {
    return Text(
      coin.name.length > EnvironmentConfig.maxNameInCard ? '${coin.name.substring(0, EnvironmentConfig.maxNameInCard)}...' : coin.name,
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
          ),
        ],
      ),
    );
  }

  Widget getCheckbox() {
    return Checkbox(
      value: coin.isCompare ?? false,
      onChanged: (bool? newValue) {
        setState(() {
          // Update UX data
          coin.isCompare = newValue ?? false;

          context.read<CardBloc>().add(DoSetCompare(coin));
        });
      },      
    );
  }

  // [functions]
  String formatCurrency(double amount) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(amount);
  }
}

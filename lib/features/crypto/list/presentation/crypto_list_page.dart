import 'package:flutter/material.dart';
import 'package:wenia/core/Entities/crypto/coin_entity.dart';

import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/core/utils/style/theme_app.dart';
import 'package:wenia/features/crypto/card/presentation/card_page.dart';

class CryptoListPage extends StatefulWidget {
  const CryptoListPage({super.key});

  @override
  State<CryptoListPage> createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  // [Properties]
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          CultureService().getLocalResource("crypto-title"),
          style: ThemeApp.textTheme.bodyLarge?.copyWith(color: Colors.white)
        ),
        backgroundColor: ThemeApp.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            getHeaderFilterOptions(),
            const SizedBox(height: 15),
            CardPage(coin: CoinEntity.empty())
          ])
        )
      );
  }

  // [Methods]
  Widget getHeaderFilterOptions() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: ThemeApp.textTheme.bodyMedium?.copyWith(color: ThemeApp.black),
              decoration: InputDecoration(
                hintText: CultureService().getLocalResource("crypto-search"),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none
                )
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                _sortAscending = !_sortAscending;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ThemeApp.primaryColor,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Icon(_sortAscending ? Icons.arrow_downward : Icons.arrow_upward, color: Colors.white),
            )
          )
        ],
      ),
    );
  }
}
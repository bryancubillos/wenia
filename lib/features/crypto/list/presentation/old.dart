import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/core/utils/style/theme_app.dart';
import 'package:wenia/features/crypto/card/presentation/card_page.dart';
import 'package:wenia/features/crypto/list/bloc/crypto_list_bloc.dart';

class CryptoListPage extends StatefulWidget {
  const CryptoListPage({super.key});

  @override
  State<CryptoListPage> createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  // [Properties]
  bool _sortDescending = true;

  // [Init state]
  @override
  void initState() {
    super.initState();
    // Get current user
    context.read<CryptoListBloc>().add(GetCoins(_sortDescending));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          CultureService().getLocalResource("crypto-title"),
          style: ThemeApp.textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: ThemeApp.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            getHeaderFilterOptions(),
            Expanded(child: getCoins(context)),
          ],
        ),
      ),
    );
  }

  // [Methods]
  Widget getHeaderFilterOptions() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: ThemeApp.textTheme.bodyMedium?.copyWith(color: ThemeApp.black),
              decoration: InputDecoration(
                hintText: CultureService().getLocalResource("crypto-search"),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: ThemeApp.secondColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: ThemeApp.secondColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: ThemeApp.secondColor, width: 0.1),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                _sortDescending = !_sortDescending;
                context.read<CryptoListBloc>().add(GetCoins(_sortDescending));
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ThemeApp.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _sortDescending ? Icons.arrow_downward : Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getCoins(BuildContext context) {
    return BlocBuilder<CryptoListBloc, CryptoListState>(
      buildWhen: (previous, current) =>
          current is CryptoListLoaded || current is CryptoListLoading,
      builder: (context, state) {
        if (state is CryptoListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CryptoListLoaded) {
          if (state.coins.isNotEmpty) {
            return ListView.builder(
              key: ValueKey<bool>(_sortDescending), // Agrega esta línea
              itemCount: state.coins.length,
              itemBuilder: (context, index) {
                return CardPage(coin: state.coins[index]);
              },
            );
          } else {
            return const Center(child: Text("No coins available"));
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

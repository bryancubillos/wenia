import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wenia/core/config/environment_config.dart';

import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/core/utils/style/theme_app.dart';
import 'package:wenia/features/crypto/card/bloc/card_bloc.dart';
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
  bool _isFavorite = false;
  String _searchValue = '';
  Timer? _debounce;

  // [Init state]
  @override
  void initState() {
    super.initState();
    // Get current user
    context.read<CryptoListBloc>().add(DoGetCoins(_sortDescending, "", _isFavorite));
  }

  // [Dispose]
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  // [Constructor]
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
        child: Stack(
          children: [
            getHeaderFilterOptions(),
            Expanded(child: getCoins(context)),
            getFloatingActionButton(context),
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
            child: getSearchInput()
          ),
          const SizedBox(width: 8),
          getSortAction(),
          getFavoriteAction(),
        ],
      ),
    );
  }

  Widget getCoins(BuildContext context) {
    return BlocBuilder<CryptoListBloc, CryptoListState>(
      buildWhen: (previous, current) => current is CryptoListLoaded || current is CryptoListLoading,
      builder: (context, state) {
        if (state is CryptoListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CryptoListLoaded) {
          if (state.coins.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 67.0),
              child: ListView.builder(
                key: ValueKey<bool>(_sortDescending),
                itemCount: state.coins.length,
                itemBuilder: (context, index) {
                  return BlocProvider<CardBloc>(
                    create: (_) => CardBloc(),
                    child: CardPage(coin: state.coins[index]),
                  );
                },
              )
            );
          } else {
            return Center(
              child: Text(CultureService().getLocalResource("crypto-no-data"),
              style: ThemeApp.textTheme.bodyMedium?.copyWith(color: ThemeApp.black))
            );
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget getSearchInput() {
    return TextField(
      onChanged: _onSearchChanged,
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
          borderSide: const BorderSide(color: ThemeApp.secondColor, width: 1),
        ),
      ),
    );
  }

  Widget getSortAction() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _sortDescending = !_sortDescending;
          context.read<CryptoListBloc>().add(DoGetCoins(_sortDescending, _searchValue, _isFavorite));
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
    );
  }
  
  Widget getFavoriteAction() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isFavorite = !_isFavorite;
            context.read<CryptoListBloc>().add(DoGetCoins(_sortDescending, _searchValue, _isFavorite));
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ThemeApp.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ThemeApp.secondColor),
          ),
          child: Icon(
            _isFavorite ? Icons.star : Icons.star_border,
            color: _isFavorite ? Colors.yellow : Colors.grey,
          ),
        ),
      )
    );
  }

  Widget getFloatingActionButton(BuildContext context) {
    return BlocBuilder<CryptoListBloc, CryptoListState>(
      buildWhen: (previous, current) => current is CryptoListLoaded,
      builder: (context, state) {
        if(state is CryptoListLoaded) {
          if(state.countCompareCoins == EnvironmentConfig.maxCompareCoins) {
            return Positioned(
              bottom: 11,
              right: 11,
              child: FloatingActionButton(
                onPressed: () {
                  
                },
                backgroundColor: ThemeApp.secondColor,
                foregroundColor: ThemeApp.primaryColor,
                child: const Icon(Icons.compare_arrows),
              ),
            );
          }
        }
        
        return const SizedBox.shrink();
      });
  }

  // [Functions]
  void _onSearchChanged(String value) {
    // Cancel previous debounce
    if(_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    // litlle debounce
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchValue = value;
      });
      
      context.read<CryptoListBloc>().add(DoGetCoins(_sortDescending, _searchValue, _isFavorite));
    });
  }
}

// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:crypto_wallet_checker/WalletTypeScreen.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Wallet Checker',
      theme: ThemeData(brightness: Brightness.dark,accentColor: Colors.deepPurpleAccent),
      home: WalletTypes(),
    );
  }
}

class WalletTypes extends StatefulWidget {
  @override
  _WalletTypes createState() => _WalletTypes();
}

class _WalletTypes extends State<WalletTypes> {
  final _cryptoAddress = 1;
  final _biggerFont = TextStyle(fontSize:18.0);
  final _saved = Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My wallets'),
        actions: [IconButton(icon:Icon(Icons.list),onPressed: _pushSaved),],
      ),
      body: _buildWalletTypeList(), floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>WalletTypesScreen()));
      },
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).accentColor ,
    ),
    );
  }
  Widget _buildWalletTypeList() {
    if(_cryptoAddress>0)
          return GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16.0),
              childAspectRatio: 8.0 / 9.0,
              children:_getWalletTypeCard(),
          );
    else
      return Text("You don't have any address registered yet");
  }

  Widget _buildWallet() {
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }

  List<Widget> _getWalletTypeCard()
  {
    var cardOne = _createWalletTypeCard('graphics/bitcoin.svg', "Bitcoin");
    var cardTwo = _createWalletTypeCard('graphics/bitcoin.svg', "Ethereum");
    return <Widget> [cardOne,cardTwo];
  }

  Card _createWalletTypeCard(String pictureCard,String primaryText)
  {
    var cardOne = Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: SvgPicture.asset(pictureCard),
              ),
                Text(primaryText),
                SizedBox(height: 8.0),
                Text('Secondary Text'),
              ],
            ),
          ),
        ],
      ),
    );
    return cardOne;
  }
}





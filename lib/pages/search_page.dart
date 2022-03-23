import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SearchBar(
            hideLeft: true,
            defaultText: "哈哈",
            hint: "123",
            leftButtonClick: () {
              Navigator.pop(context);
            },
            onChanged: _onTextChanged,
          )
        ],
      ),
    );
  }

  _onTextChanged(text) {}
}

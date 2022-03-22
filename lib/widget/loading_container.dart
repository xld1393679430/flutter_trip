import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final bool cover;

  LoadingContainer(
      {@required this.isLoading, @required this.child, this.cover = false});

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [child, isLoading ? _loadingView : null],
      );
    } else {
      if (isLoading) {
        return _loadingView;
      } else {
        return child;
      }
    }
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

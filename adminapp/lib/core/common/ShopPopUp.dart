import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/banners/screens/shops_banner.dart';

class ShopPopUp extends StatefulWidget {
  List? shops;
  ShopPopUp({Key? key, this.shops}) : super(key: key);

  @override
  State<ShopPopUp> createState() => _ShopPopUpState();
}

class _ShopPopUpState extends State<ShopPopUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('Shops'),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.shops!.length, (index) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(shopMap[widget.shops![index]]),
              );
            })),
      ),
    );
  }
}

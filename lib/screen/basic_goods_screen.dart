import 'package:flutter/material.dart';
import 'package:recipe_app/components/basic_good_tile.dart';
import 'package:recipe_app/components/title_tile.dart';

class BasicGoodScreen extends StatefulWidget {
  BasicGoodScreen({super.key});

  @override
  State<BasicGoodScreen> createState() => _BasicGoodScreenState();
}

class _BasicGoodScreenState extends State<BasicGoodScreen> {
  TextEditingController _addGroceries = new TextEditingController();
  final List _basicGoods = [
    [false, "Diskmedel"],
    [false, "Blöjor"],
    [false, "Toapapper"],
    [false, "Tvättmedel"],
    [false, "Sköljmedel"],
    [false, "Tvättlappar"],
    [false, "Vanish"],
    [false, "Bröd"],
    [false, "Kaffe"],
    [false, "Glass"],
    [false, "test1"],
    [false, "test2"],
    [false, "test3"],
    [false, "tes4"],
    [false, "test5"],
    [false, "test6"],
    [false, "test7"],
    [false, "test8"],
    [false, "test9"],
    [false, "test10"],
  ];

  void addItem(bool? value, int index) {
    setState(() {
      _basicGoods[index][0] = !_basicGoods[index][0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 50,
        child: Column(children: [
          TitleTile(title: "Basic goods"),
          Divider(
            thickness: 3,
          ),
          Text("Missing something on the list?"),
          //TextField but Keyboard overflows...
          SizedBox(
            height: MediaQuery.of(context).size.height - 240,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: _basicGoods.length,
                itemBuilder: (context, index) {
                  return BasicGoodTile(
                      onChanged: (value) {
                        addItem(value, index);
                      },
                      missingItem: _basicGoods[index][0],
                      basicGood: _basicGoods[index][1]);
                }),
          )
        ]),
      ),
    );
  }
}

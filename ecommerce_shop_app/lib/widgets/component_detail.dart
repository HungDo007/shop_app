import 'package:flutter/material.dart';

import '../utils/handle.dart';

class ComponentDetail extends StatefulWidget {
  // const ComponentDetail({ Key? key }) : super(key: key);
  ComponentDetail(this.listComponent, this.price);
  List<Component> listComponent;
  double price;
  @override
  State<ComponentDetail> createState() => _ComponentDetailState();
}

class _ComponentDetailState extends State<ComponentDetail> {
  var selected = [];

  void _handleCompo(int id, int idx) {
    var item = {
      "id": id,
      "index": idx,
    };
    if (selected.any((item) => item["index"] == idx)) {
      setState(() {
        selected.removeWhere((item) => item["index"] == idx);
        selected.add(item);
      });
    } else {
      setState(() {
        selected.add(item);
      });
    }
    setState(() {
      widget.price = 12.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.listComponent
          .asMap()
          .map((index, item) {
            return MapEntry(
              index,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Text(item.name)),
                    Expanded(
                      flex: 4,
                      child: Wrap(
                        children: item.value
                            .map((value) => Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size(80, 50),
                                      backgroundColor: selected
                                              .map((e) => e["id"])
                                              .contains(value.id)
                                          ? const Color(0xFFFF7643)
                                          : null,
                                      primary: selected
                                              .map((e) => e["id"])
                                              .contains(value.id)
                                          ? Colors.white
                                          : null,
                                    ),
                                    onPressed: () =>
                                        _handleCompo(value.id, index),
                                    child: Text(value.name),
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            );
          })
          .values
          .toList(),
    );
  }
}

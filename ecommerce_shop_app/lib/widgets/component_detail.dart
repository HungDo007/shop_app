import 'package:flutter/material.dart';

import '../utils/handle.dart';

class ComponentDetail extends StatefulWidget {
  const ComponentDetail(
      {Key? key, required this.listComponent, required this.price})
      : super(key: key);
  final List<Component> listComponent;
  final double price;
  @override
  State<ComponentDetail> createState() => _ComponentDetailState();
}

class _ComponentDetailState extends State<ComponentDetail> {
  var selected = [];

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
                                    onPressed: () {},
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

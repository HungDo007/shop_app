import 'dart:convert';

import '../providers/products.dart';

class ComponentValue {
  late int id;
  late String name;
}

class Component {
  late String name;
  List<ComponentValue> value = [];
}

class Handle {
  static List<Component> getListComponent(List<ProductDetail> productDetails) {
    List<Component> listCompo = [];
    var num = productDetails[0].componentDetails.length;
    var names = [];
    if (num != 0) {
      for (var i = 0; i < num; i++) {
        var a = Component();
        names.add(productDetails[0].componentDetails[i].name);
        a.name = names[i];
        for (var element in productDetails) {
          if (!a.value.any((item) =>
              item.name ==
              element
                  .componentDetails[element.componentDetails
                      .indexWhere((i) => i.name == a.name)]
                  .value)) {
            var value = ComponentValue();
            value.id = element
                .componentDetails[element.componentDetails
                    .indexWhere((i) => i.name == a.name)]
                .id;
            value.name = element
                .componentDetails[element.componentDetails
                    .indexWhere((i) => i.name == a.name)]
                .value;
            a.value.add(value);
          }
        }
        listCompo.add(a);
      }
    }
    return listCompo;
  }

  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}

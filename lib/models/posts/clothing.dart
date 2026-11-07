import 'dart:developer' as debug;

import '/models/posts/identifeir_symbol.dart';

class Clothing {
  String? clothsPostImageURL;

  Map<int, IdentifeirSymbol> identifierSymbols;
  int orderIndex = -1;

  final int maximumNumberOfAllowedCloths = 3;

  Clothing({required this.identifierSymbols, this.clothsPostImageURL = ''});

  void setClothsPostImageURL(String clothsPostImageURL) =>
      this.clothsPostImageURL = clothsPostImageURL;

  bool canAddMoreCloths() {
    return identifierSymbols.length < maximumNumberOfAllowedCloths;
  }

  void addClothing(IdentifeirSymbol identifeirSymbol) {
    identifierSymbols.putIfAbsent(++orderIndex, () => identifeirSymbol);
    debug.log('order index $orderIndex');
  }

  bool canRemoveClothing() => orderIndex >= 0;

  int removeClothing() {
    if (orderIndex >= 0) {
      int toReturn = identifierSymbols[orderIndex]!.identifeirIndex;
      identifierSymbols.remove(orderIndex--);
      debug.log('order index $orderIndex');
      return toReturn;
    }

    return orderIndex;
  }

  bool hasIdentifiedAtleastOneClothing() {
    return identifierSymbols.isNotEmpty;
  }

  // Careful the date does not result into the null pointer exception.
  Map<String, dynamic> toJson() => {
    'clothsPostImageURL': clothsPostImageURL,
    'identifierSymbols': toStringKeys(),
  };

  Map<String, dynamic> toStringKeys() {
    return identifierSymbols.map(
      (key, value) => MapEntry(key.toString(), value.toJson()),
    );
  }

  static Map<int, IdentifeirSymbol> toIntKeys(Map<String, dynamic> json) {
    return json.map(
      (key, value) =>
          MapEntry(int.parse(key), IdentifeirSymbol.fromJson(value)),
    );
  }

  factory Clothing.fromJson(Map<String, dynamic> json) => Clothing(
    clothsPostImageURL: json['clothsPostImageURL'],
    identifierSymbols: toIntKeys(json['identifierSymbols']),
  );
}

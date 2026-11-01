import 'dart:developer' as debug;

import '/models/posts/identifeir_symbol.dart';

class Clothing {
  DateTime? wearingOn;
  String? clothsPostImageURL;

  Map<int, IdentifeirSymbol> identifierSymbols;
  int orderIndex = -1;

  final int maximumNumberOfAllowedCloths = 3;

  Clothing({
    this.wearingOn,
    required this.identifierSymbols,
    this.clothsPostImageURL = '',
  });

  void setWearingOn() {
    wearingOn = DateTime.now();
  }

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
    'day': wearingOn!.day,
    'month': wearingOn!.month,
    'year': wearingOn!.year,
    'clothing': identifierSymbols,
  };

  factory Clothing.fromJson(dynamic json) => Clothing(
    wearingOn: DateTime(json['year'], json['month'], json['day']),
    identifierSymbols: json['clothing'],
  );
}

import 'dart:developer' as debug;

class IdentifeirSymbol {
  String clothingName;
  int identifeirIndex;
  bool isUsed;
  double? clothingPrice;
  int? numberOfLikes;
  int? numberOfDislikes;
  int? numberOfIgnores;
  int? numberOfHugs;
  int? numberOfPhoneNumberRequests;

  // clothes identifiers [# $ x % & * @...]
  IdentifeirSymbol({
    required this.clothingName,
    required this.identifeirIndex,
    this.clothingPrice,
    this.isUsed = false,
    this.numberOfLikes = 0,
    this.numberOfDislikes = 0,
    this.numberOfIgnores = 0,
    this.numberOfHugs = 0,
    this.numberOfPhoneNumberRequests = 0,
  });

  int computeNumberOfReactionDigits() {
    int numberOfReactionDigits = 0;

    if (numberOfLikes! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfLikes! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfLikes! < 1000) {
      numberOfReactionDigits += 3;
    } else if (numberOfLikes! < 10000) {
      numberOfReactionDigits += 4;
    } else {
      numberOfReactionDigits += 5;
    }

    if (numberOfDislikes! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfDislikes! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfDislikes! < 1000) {
      numberOfReactionDigits += 3;
    } else {
      numberOfReactionDigits += 4;
    }

    if (numberOfIgnores! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfIgnores! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfIgnores! < 1000) {
      numberOfReactionDigits += 3;
    } else {
      numberOfReactionDigits += 4;
    }

    if (numberOfHugs! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfHugs! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfHugs! < 1000) {
      numberOfReactionDigits += 3;
    } else {
      numberOfReactionDigits += 4;
    }

    if (numberOfPhoneNumberRequests! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfPhoneNumberRequests! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfPhoneNumberRequests! < 1000) {
      numberOfReactionDigits += 3;
    } else {
      numberOfReactionDigits += 4;
    }

    return numberOfReactionDigits;
  }

  String getSymbol() {
    switch (identifeirIndex) {
      case 0:
        return '#';
      case 1:
        return '\$';
      case 2:
        return 'x';
      case 3:
        return '%';
      case 4:
        return '&';
      case 5:
        return '*';
      default:
        return '@';
    }
  }

  // clothes identifiers [# $ x % & @ *...]
  String findClothingNameAs() {
    switch (identifeirIndex) {
      case 0:
        return 'Hart';
      case 1:
        return 'Shades';
      case 2:
        return 'Hair';
      case 3:
        return 'TShirt';
      case 4:
        return 'Jacket';
      case 5:
        return 'Trauser';
      default:
        return 'Shoes';
    }
  }

  @override
  String toString() =>
      'Clothing Name\t\t[$clothingName]\nSymbol\t\t[$getSymbol()]\nIdentifier Index\t\t[$identifeirIndex]\nIs Used\t\t[$isUsed]\nPrice\t\t[$clothingPrice]';

  void setClothingPrice(double? price) {
    clothingPrice = price;
  }

  void setClothingName(String clothingName) {
    this.clothingName = clothingName;
  }

  void setIsUsed(bool isUsed) {
    this.isUsed = isUsed;
  }

  Map<String, dynamic> toJson() => {
    'symbol': getSymbol(),
    'clothingName': clothingName,
    'identifeirIndex': identifeirIndex,
    'isUsed': isUsed,
    'clothingPrice': clothingPrice,
    'numberOfLikes': numberOfLikes,
    'numberOfDislikes': numberOfDislikes,
    'numberOfIgnores': numberOfIgnores,
    'numberOfHugs': numberOfHugs,
    'numberOfPhoneNumberRequests': numberOfPhoneNumberRequests,
  };

  factory IdentifeirSymbol.fromJson(Map<String, dynamic> json) =>
      IdentifeirSymbol(
        clothingName: json['clothingName'],
        identifeirIndex: json['identifeirIndex'],
        clothingPrice: json['clothingPrice'],
        isUsed: json['isUsed'],
        numberOfLikes: json['numberOfLikes'],
        numberOfDislikes: json['numberOfDislikes'],
        numberOfIgnores: json['numberOfIgnores'],
        numberOfHugs: json['numberOfHugs'],
        numberOfPhoneNumberRequests: json['numberOfPhoneNumberRequests'],
      );
}

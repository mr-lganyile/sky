import 'dart:developer' as debug;

class IdentifeirSymbol {
  String clothingName;
  int identifeirIndex;
  bool isUsed;
  double? clothingPrice;
  int? numberOfLikes;
  int? numberOfDislikes;
  int? numberOfAwards;
  int? numberOfKisses;
  int? numberOfFallingAsleep;

  int? numberOfGqa;
  int? numberOfHandShakes;
  int? numberOfDaught;
  int? numberOfToBin;

  // clothes identifiers [# $ x % & * @...]
  IdentifeirSymbol({
    required this.clothingName,
    required this.identifeirIndex,
    this.clothingPrice,
    this.isUsed = false,
    this.numberOfLikes = 0,
    this.numberOfDislikes = 0,
    this.numberOfAwards = 0,
    this.numberOfKisses = 0,
    this.numberOfFallingAsleep = 0,
    this.numberOfGqa = 0,
    this.numberOfHandShakes = 0,
    this.numberOfDaught = 0,
    this.numberOfToBin = 0,
  });

  int computeNumberOfReactionDigits() {
    int numberOfReactionDigits = 0;

    if (numberOfLikes! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfLikes! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfLikes! < 1000) {
      numberOfReactionDigits += 3;
    } else {
      numberOfReactionDigits += 4;
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

    if (numberOfAwards! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfAwards! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfAwards! < 1000) {
      numberOfReactionDigits += 3;
    } else {
      numberOfReactionDigits += 4;
    }

    if (numberOfKisses! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfKisses! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfKisses! < 1000) {
      numberOfReactionDigits += 3;
    } else {
      numberOfReactionDigits += 4;
    }

    if (numberOfFallingAsleep! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfFallingAsleep! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfFallingAsleep! < 1000) {
      numberOfReactionDigits += 3;
    } else {
      numberOfReactionDigits += 4;
    }

    if (numberOfGqa! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfGqa! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfGqa! < 1000) {
      numberOfReactionDigits += 3;
    } else {
      numberOfReactionDigits += 4;
    }

    if (numberOfHandShakes! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfHandShakes! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfHandShakes! < 1000) {
      numberOfReactionDigits += 3;
    } else {
      numberOfReactionDigits += 4;
    }

    if (numberOfDaught! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfDaught! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfDaught! < 1000) {
      numberOfReactionDigits += 3;
    } else {
      numberOfReactionDigits += 4;
    }

    if (numberOfToBin! < 10) {
      numberOfReactionDigits++;
    } else if (numberOfToBin! < 100) {
      numberOfReactionDigits += 2;
    } else if (numberOfToBin! < 1000) {
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
    'numberOfAwards': numberOfAwards,
    'numberOfKisses': numberOfKisses,
    'numberOfFallingAsleep': numberOfFallingAsleep,
    'numberOfGqa': numberOfGqa,
    'numberOfHandShakes': numberOfHandShakes,
    'numberOfDaught': numberOfDaught,
    'numberOfToBin': numberOfToBin,
  };

  factory IdentifeirSymbol.fromJson(Map<String, dynamic> json) =>
      IdentifeirSymbol(
        clothingName: json['clothingName'],
        identifeirIndex: json['identifeirIndex'],
        clothingPrice: json['clothingPrice'],
        isUsed: json['isUsed'],
        numberOfLikes: json['numberOfLikes'],
        numberOfDislikes: json['numberOfDislikes'],
        numberOfAwards: json['numberOfAwards'],
        numberOfKisses: json['numberOfKisses'],
        numberOfFallingAsleep: json['numberOfFallingAsleep'],
        numberOfGqa: json['numberOfGqa'],
        numberOfHandShakes: json['numberOfHandShakes'],
        numberOfDaught: json['numberOfDaught'],
        numberOfToBin: json['numberOfToBin'],
      );
}

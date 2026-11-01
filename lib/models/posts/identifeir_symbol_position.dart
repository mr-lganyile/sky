import '/models/posts/identifeir_symbol.dart';

class IdentifeirSymbolPosition {
  int row;
  int column;
  IdentifeirSymbol? identifeirSymbol;

  IdentifeirSymbolPosition({
    required this.row,
    required this.column,
    this.identifeirSymbol,
  });

  void setIdentifeirSymbol(IdentifeirSymbol? identifeirSymbol) =>
      this.identifeirSymbol = identifeirSymbol;

  bool isOccupied() => identifeirSymbol != null;

  Map<String, dynamic> toJson() => {
    'row': row,
    'column': column,
    'identifeirSymbol': identifeirSymbol,
  };

  factory IdentifeirSymbolPosition.fromJson(Map<String, dynamic> json) =>
      IdentifeirSymbolPosition(
        row: json['row'],
        column: json['column'],
        identifeirSymbol: json['identifeirSymbol'],
      );
}

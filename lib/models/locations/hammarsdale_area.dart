import 'section_name.dart';
import 'supported_area.dart';
import 'supported_town_or_institution.dart';
import 'town_or_institution.dart';

class HammarsdaleArea {
  static SupportedTownOrInstitution? toSupportedTownOrInstitution(
      SectionName sectionName) {
    if (sectionName ==
            SectionName.unit1NorthHammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.unit1SouthHammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.unit2NorthHammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.unit2SouthHammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.unit3HammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.unit4HammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.unit5HammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.unit6HammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.unit7HammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.mlabaVillageHammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.georgedaleHammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.amalangaHammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.woodglenHammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.sankontsheHammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.mophelaHammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.stationHammarsdaleDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.webberHammarsdaleDurbanKwaZuluNatalSouthAfrica) {
      return SupportedTownOrInstitution(
        cityFK: "1",
        townOrInstitutionName: TownOrInstitution.hammarsdale,
        townOrInstitutionNo: "9",
      );
    }
    return null;
  }

  static SupportedArea? toSupportedArea(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.unit1NorthHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "72",
        );
      case SectionName.unit1SouthHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "73",
        );
      case SectionName.unit2NorthHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "74",
        );
      case SectionName.unit2SouthHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "75",
        );
      case SectionName.unit3HammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "76",
        );
      case SectionName.unit4HammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "77",
        );
      case SectionName.unit5HammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "78",
        );
      case SectionName.unit6HammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "79",
        );
      case SectionName.unit7HammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "80",
        );
      case SectionName.mlabaVillageHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "81",
        );
      case SectionName.georgedaleHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "82",
        );
      case SectionName.amalangaHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "83",
        );
      case SectionName.woodglenHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "84",
        );
      case SectionName.sankontsheHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "85",
        );
      case SectionName.mophelaHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "86",
        );
      case SectionName.stationHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "87",
        );
      case SectionName.webberHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "9",
          sectionName: sectionName,
          areaNo: "88",
        );
      default:
        return null;
    }
  }

  static SectionName? toSectionName(String section) {
    switch (section) {
      case 'Unit 1 North-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.unit1NorthHammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Unit 1 South-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.unit1SouthHammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Unit 2 North-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.unit2NorthHammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Unit 2 South-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.unit2SouthHammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Unit 3-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.unit3HammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Unit 4-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.unit4HammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Unit 5-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.unit5HammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Unit 6-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.unit6HammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Unit 7-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.unit7HammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Mlaba Village-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.mlabaVillageHammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Georgedale-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.georgedaleHammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Amalanga-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.amalangaHammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Woodglen-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.woodglenHammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Sankontshe-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.sankontsheHammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Mophela-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.mophelaHammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Station-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.stationHammarsdaleDurbanKwaZuluNatalSouthAfrica;
      case 'Webber-Hammarsdale-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.webberHammarsdaleDurbanKwaZuluNatalSouthAfrica;
      default:
        return null;
    }
  }

  static String? asString(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.unit1NorthHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Unit 1 North-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.unit1SouthHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Unit 1 South-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.unit2NorthHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Unit 2 North-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.unit2SouthHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Unit 2 South-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.unit3HammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Unit 3-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.unit4HammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Unit 4-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.unit5HammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Unit 5-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.unit6HammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Unit 6-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.unit7HammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Unit 7-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.mlabaVillageHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Mlaba Village-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.georgedaleHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Georgedale-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.amalangaHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Amalanga-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.woodglenHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Woodglen-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.sankontsheHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Sankontshe-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.mophelaHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Mophela-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.stationHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Station-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.webberHammarsdaleDurbanKwaZuluNatalSouthAfrica:
        return 'Webber-Hammarsdale-Durban-Kwa Zulu Natal-South Africa';

      default:
        return null;
    }
  }
}

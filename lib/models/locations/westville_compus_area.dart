import 'section_name.dart';
import 'supported_area.dart';
import 'supported_town_or_institution.dart';
import 'town_or_institution.dart';

class WestvilleCampusArea {
  static SupportedTownOrInstitution? toSupportedTownOrInstitution(
    SectionName sectionName,
  ) {
    if (sectionName ==
        SectionName.westvilleCampusUKZNDurbanKwaZuluNatalSouthAfrica) {
      return SupportedTownOrInstitution(
        cityFK: "1",
        townOrInstitutionName: TownOrInstitution.westvilleUKZN,
        townOrInstitutionNo: "10",
      );
    }
    return null;
  }

  static SupportedArea? toSupportedArea(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.westvilleCampusUKZNDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "10",
          sectionName: sectionName,
          areaNo: "91",
        );
      default:
        return null;
    }
  }

  static SectionName? toSectionName(String section) {
    switch (section) {
      case 'Westville (UKZN)-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.westvilleCampusUKZNDurbanKwaZuluNatalSouthAfrica;
      default:
        return null;
    }
  }

  static String? asString(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.westvilleCampusUKZNDurbanKwaZuluNatalSouthAfrica:
        return 'Westville (UKZN)-Durban-Kwa Zulu Natal-South Africa';
      default:
        return null;
    }
  }
}

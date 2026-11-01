import 'section_name.dart';
import 'supported_area.dart';
import 'supported_town_or_institution.dart';
import 'town_or_institution.dart';

class EdgewoodArea {
  static SupportedTownOrInstitution? toSupportedTownOrInstitution(
    SectionName sectionName,
  ) {
    if (sectionName ==
        SectionName.edgwoodCampusUKZNPinetownKwaZuluNatalSouthAfrica) {
      return SupportedTownOrInstitution(
        cityFK: "2",
        townOrInstitutionName: TownOrInstitution.edgewoodUKZN,
        townOrInstitutionNo: "12",
      );
    }
    return null;
  }

  static SupportedArea? toSupportedArea(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.edgwoodCampusUKZNPinetownKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "12",
          sectionName: sectionName,
          areaNo: "93",
        );
      default:
        return null;
    }
  }

  static SectionName? toSectionName(String section) {
    switch (section) {
      case 'Edgewood (UKZN)-Pinetown-Kwa Zulu Natal-South Africa':
        return SectionName.edgwoodCampusUKZNPinetownKwaZuluNatalSouthAfrica;
      default:
        return null;
    }
  }

  static String? asString(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.edgwoodCampusUKZNPinetownKwaZuluNatalSouthAfrica:
        return 'Edgewood (UKZN)-Pinetown-Kwa Zulu Natal-South Africa';
      default:
        return null;
    }
  }
}

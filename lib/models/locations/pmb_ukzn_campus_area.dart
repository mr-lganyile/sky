import 'section_name.dart';
import 'supported_area.dart';
import 'supported_town_or_institution.dart';
import 'town_or_institution.dart';

class PmbUKZNCampusArea {
  static SupportedTownOrInstitution? toSupportedTownOrInstitution(
    SectionName sectionName,
  ) {
    if (sectionName ==
        SectionName.pmbCampusUKZNPietermaritzburgKwaZuluNatalSouthAfrica) {
      return SupportedTownOrInstitution(
        cityFK: "3",
        townOrInstitutionName: TownOrInstitution.pmbUKZN,
        townOrInstitutionNo: "13",
      );
    }
    return null;
  }

  static SupportedArea? toSupportedArea(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.pmbCampusUKZNPietermaritzburgKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "13",
          sectionName: sectionName,
          areaNo: "94",
        );
      default:
        return null;
    }
  }

  static SectionName? toSectionName(String section) {
    switch (section) {
      case 'PMB (UKZN)-Pietermaritzburg-Kwa Zulu Natal-South Africa':
        return SectionName.pmbCampusUKZNPietermaritzburgKwaZuluNatalSouthAfrica;
      default:
        return null;
    }
  }

  static String? asString(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.pmbCampusUKZNPietermaritzburgKwaZuluNatalSouthAfrica:
        return 'PMB (UKZN)-Pietermaritzburg-Kwa Zulu Natal-South Africa';
      default:
        return null;
    }
  }
}

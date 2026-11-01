import 'section_name.dart';
import 'supported_area.dart';
import 'supported_town_or_institution.dart';
import 'town_or_institution.dart';

class NelsonMandelaArea {
  static SupportedTownOrInstitution? toSupportedTownOrInstitution(
    SectionName sectionName,
  ) {
    if (sectionName ==
        SectionName.nelsonMandelaCampusUKZNDurbanKwaZuluNatalSouthAfrica) {
      return SupportedTownOrInstitution(
        cityFK: "1",
        townOrInstitutionName: TownOrInstitution.nelsonMandelUKZN,
        townOrInstitutionNo: "11",
      );
    }
    return null;
  }

  static SupportedArea? toSupportedArea(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.nelsonMandelaCampusUKZNDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "11",
          sectionName: sectionName,
          areaNo: "92",
        );
      default:
        return null;
    }
  }

  static SectionName? toSectionName(String section) {
    switch (section) {
      case 'Nelson Mandela (UKZN)-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.nelsonMandelaCampusUKZNDurbanKwaZuluNatalSouthAfrica;
      default:
        return null;
    }
  }

  static String? asString(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.nelsonMandelaCampusUKZNDurbanKwaZuluNatalSouthAfrica:
        return 'Nelson Mandela (UKZN)-Durban-Kwa Zulu Natal-South Africa';
      default:
        return null;
    }
  }
}

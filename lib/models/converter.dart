import '../controllers/shared_resources_controller.dart';
import '/models/locations/edgewood_area.dart';
import '/models/locations/nelson_mandela_area.dart';
import '/models/locations/pmb_ukzn_campus_area.dart';
import '/models/locations/westville_compus_area.dart';

import '/models/locations/hammarsdale_area.dart';

import '/models/locations/durban_central_area.dart';
import '/models/locations/mayville_area.dart';
import '/models/locations/nanda_area.dart';
import '/models/locations/sydenham_area.dart';
import '/models/locations/umlazi_area.dart';

import 'locations/dut_area.dart';
import 'locations/howard_area.dart';
import 'locations/mut_area.dart';
import 'locations/section_name.dart';
import 'locations/supported_area.dart';
import 'locations/supported_town_or_institution.dart';
import 'locations/town_or_institution.dart';

// groups_crud -> group_resources_crud ->  create_group_resources_front_end
class Converter {
  // e.g. 2460 hugs -> 2.4k hugs.
  static String convertNoOfReactions(int number) {
    int numberOfThousands = number ~/ 1000;
    int remainingHundreds = number % 1000;

    if (numberOfThousands == 0) {
      return '$number';
    }
    // there is a single digit before a comma e.g 2.4k, 9.5k, 3.4k, etc
    else if (numberOfThousands < 10) {
      if (remainingHundreds > 0) {
        return '$numberOfThousands.${remainingHundreds ~/ 100}k';
      }
      return '${numberOfThousands}k';
    } else {
      return '10k+';
    }
  }

  static String toPostForAsString(PostFor postFor) {
    switch (postFor) {
      case PostFor.alcohol:
        return 'Alcohol';
      default:
        return 'Clothing';
    }
  }

  static PostFor toPostFor(String postFor) {
    switch (postFor) {
      case 'Alcohol':
        return PostFor.alcohol;
      default:
        return PostFor.clothing;
    }
  }

  // Default durban central
  static SupportedTownOrInstitution toSupportedTownOrInstitution(
    SectionName sectionName,
  ) {
    SupportedTownOrInstitution? supportedTownOrInstitution =
        UmlaziArea.toSupportedTownOrInstitution(sectionName);

    supportedTownOrInstitution ??= MutArea.toSupportedTownOrInstitution(
      sectionName,
    );
    supportedTownOrInstitution ??= DutArea.toSupportedTownOrInstitution(
      sectionName,
    );
    supportedTownOrInstitution ??= HowardArea.toSupportedTownOrInstitution(
      sectionName,
    );
    supportedTownOrInstitution ??=
        WestvilleCampusArea.toSupportedTownOrInstitution(sectionName);
    supportedTownOrInstitution ??=
        NelsonMandelaArea.toSupportedTownOrInstitution(sectionName);
    supportedTownOrInstitution ??= EdgewoodArea.toSupportedTownOrInstitution(
      sectionName,
    );
    supportedTownOrInstitution ??=
        PmbUKZNCampusArea.toSupportedTownOrInstitution(sectionName);
    supportedTownOrInstitution ??= MayvilleArea.toSupportedTownOrInstitution(
      sectionName,
    );
    supportedTownOrInstitution ??= SydenhamArea.toSupportedTownOrInstitution(
      sectionName,
    );
    supportedTownOrInstitution ??=
        DurbanCentralArea.toSupportedTownOrInstitution(sectionName);
    supportedTownOrInstitution ??= NandaArea.toSupportedTownOrInstitution(
      sectionName,
    );
    supportedTownOrInstitution ??= HammarsdaleArea.toSupportedTownOrInstitution(
      sectionName,
    );

    supportedTownOrInstitution ??= SupportedTownOrInstitution(
      cityFK: "1",
      townOrInstitutionName: TownOrInstitution.durbanCentral,
      townOrInstitutionNo: "7",
    );

    return supportedTownOrInstitution;
  }

  // Default durban central [berea]
  static SupportedArea toSupportedArea(SectionName sectionName) {
    SupportedArea? supportedArea = UmlaziArea.toSupportedArea(sectionName);

    supportedArea ??= MutArea.toSupportedArea(sectionName);
    supportedArea ??= DutArea.toSupportedArea(sectionName);
    supportedArea ??= HowardArea.toSupportedArea(sectionName);
    supportedArea ??= WestvilleCampusArea.toSupportedArea(sectionName);
    supportedArea ??= NelsonMandelaArea.toSupportedArea(sectionName);
    supportedArea ??= EdgewoodArea.toSupportedArea(sectionName);
    supportedArea ??= PmbUKZNCampusArea.toSupportedArea(sectionName);
    supportedArea ??= MayvilleArea.toSupportedArea(sectionName);
    supportedArea ??= SydenhamArea.toSupportedArea(sectionName);
    supportedArea ??= DurbanCentralArea.toSupportedArea(sectionName);
    supportedArea ??= NandaArea.toSupportedArea(sectionName);
    supportedArea ??= HammarsdaleArea.toSupportedArea(sectionName);

    supportedArea ??= SupportedArea(
      townOrInstitutionFK: "7",
      sectionName: sectionName,
      areaNo: "44",
    );

    return supportedArea;
  }

  // Default to Berea
  static SectionName toSectionName(String section) {
    SectionName? sectionName = UmlaziArea.toSectionName(section);

    sectionName ??= MutArea.toSectionName(section);
    sectionName ??= DutArea.toSectionName(section);
    sectionName ??= HowardArea.toSectionName(section);
    sectionName ??= WestvilleCampusArea.toSectionName(section);
    sectionName ??= NelsonMandelaArea.toSectionName(section);
    sectionName ??= EdgewoodArea.toSectionName(section);
    sectionName ??= PmbUKZNCampusArea.toSectionName(section);
    sectionName ??= MayvilleArea.toSectionName(section);
    sectionName ??= SydenhamArea.toSectionName(section);
    sectionName ??= DurbanCentralArea.toSectionName(section);
    sectionName ??= NandaArea.toSectionName(section);
    sectionName ??= HammarsdaleArea.toSectionName(section);

    sectionName ??= SectionName.bereaDurbanCentralDurbanKwaZuluNatalSouthAfrica;
    return sectionName;
  }

  // Default to Berea
  static String asString(SectionName sectionName) {
    String? section = UmlaziArea.asString(sectionName);

    section ??= MutArea.asString(sectionName);
    section ??= DutArea.asString(sectionName);
    section ??= HowardArea.asString(sectionName);
    section ??= WestvilleCampusArea.asString(sectionName);
    section ??= NelsonMandelaArea.asString(sectionName);
    section ??= EdgewoodArea.asString(sectionName);
    section ??= PmbUKZNCampusArea.asString(sectionName);
    section ??= MayvilleArea.asString(sectionName);
    section ??= SydenhamArea.asString(sectionName);
    section ??= DurbanCentralArea.asString(sectionName);
    section ??= NandaArea.asString(sectionName);
    section ??= HammarsdaleArea.asString(sectionName);

    section ??= 'Berea-Durban Central-Durban-Kwa Zulu Natal-South Africa';

    return section;
  }

  static bool isInstitution(SectionName sectionName) {
    String sectionNameAsString = Converter.asString(sectionName);
    String firstPortion = sectionNameAsString.substring(
      0,
      sectionNameAsString.indexOf('-'),
    );
    return firstPortion.contains('DUT') ||
        firstPortion.contains('Howard College (UKZN)') ||
        firstPortion.contains('Westville (UKZN)') ||
        firstPortion.contains('Nelson Mandela (UKZN)') ||
        firstPortion.contains('Edgewood (UKZN)') ||
        firstPortion.contains('PMB (UKZN)') ||
        firstPortion.contains('Mangosuthu (MUT)');
  }

  // Default to durban central
  static int townOrInstitutionAsNumber(TownOrInstitution townOrInstitution) {
    switch (townOrInstitution) {
      case TownOrInstitution.umlazi:
        return 1;
      case TownOrInstitution.mut:
        return 2;
      case TownOrInstitution.dut:
        return 3;
      case TownOrInstitution.howardUKZN:
        return 4;
      case TownOrInstitution.mayville:
        return 5;
      case TownOrInstitution.sydenham:
        return 6;
      case TownOrInstitution.nanda:
        return 8;
      case TownOrInstitution.hammarsdale:
        return 9;
      case TownOrInstitution.westvilleUKZN:
        return 10;
      case TownOrInstitution.nelsonMandelUKZN:
        return 11;
      case TownOrInstitution.edgewoodUKZN:
        return 12;
      case TownOrInstitution.pmbUKZN:
        return 13;
      default:
        return 7;
    }
  }

  // Default to durban central
  static String townOrInstitutionAsString(TownOrInstitution townOrInstitution) {
    switch (townOrInstitution) {
      case TownOrInstitution.umlazi:
        return 'Umlazi';
      case TownOrInstitution.mut:
        return 'Mangosuthu (MUT)';
      case TownOrInstitution.dut:
        return 'DUT';
      case TownOrInstitution.howardUKZN:
        return 'Howard College (UKZN)';
      case TownOrInstitution.westvilleUKZN:
        return 'Westville (UKZN)';
      case TownOrInstitution.nelsonMandelUKZN:
        return 'Nelson Mandela (UKZN)';
      case TownOrInstitution.edgewoodUKZN:
        return 'Edgewood (UKZN)';
      case TownOrInstitution.pmbUKZN:
        return 'PMB (UKZN)';
      case TownOrInstitution.mayville:
        return 'Mayville';
      case TownOrInstitution.sydenham:
        return 'Sydenham';
      case TownOrInstitution.nanda:
        return 'Nanda';
      case TownOrInstitution.hammarsdale:
        return 'Hammarsdale';
      default:
        return 'Durban Central';
    }
  }

  // Default to durban central
  static TownOrInstitution toTownOrInstitution(String townOrInstitution) {
    switch (townOrInstitution.toLowerCase()) {
      case 'umlazi':
        return TownOrInstitution.umlazi;
      case 'mangosuthu (mut)':
        return TownOrInstitution.mut;
      case 'dut':
        return TownOrInstitution.dut;
      case 'howard college (ukzn)':
        return TownOrInstitution.howardUKZN;
      case 'westville (ukzn)':
        return TownOrInstitution.westvilleUKZN;
      case 'nelson mandela (ukzn)':
        return TownOrInstitution.nelsonMandelUKZN;
      case 'edgewood (ukzn)':
        return TownOrInstitution.edgewoodUKZN;
      case 'pmb (ukzn)':
        return TownOrInstitution.pmbUKZN;
      case 'mayville':
        return TownOrInstitution.mayville;
      case 'sydenham':
        return TownOrInstitution.sydenham;
      case 'nanda':
        return TownOrInstitution.nanda;
      case 'hammarsdale':
        return TownOrInstitution.hammarsdale;
      default:
        return TownOrInstitution.durbanCentral;
    }
  }
}

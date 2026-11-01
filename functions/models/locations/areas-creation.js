/* eslint-disable*/
import LocationCreation from './location-creation.js';
import SupportedArea from "./supported-area.js";
import LocationController from '../../controllers/location-controller.js';

// Last area number is 94 (PMB UKZN).
class AreasCreation extends LocationCreation {

    constructor() {
        super();
        this.locationController = new LocationController();
    }

    // Town/Institution 1
    async createUmlaziSupportedAreas() {
        const aSection = new SupportedArea("1",
            "A Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "1");
        await this.locationController.createSupportedArea(aSection.toJson());
        const aaSection = new SupportedArea("1",
            "AA Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "2");
        await this.locationController.createSupportedArea(aaSection.toJson());
        const bSection = new SupportedArea("1",
            "B Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "3");
        await this.locationController.createSupportedArea(bSection.toJson());
        const bbSection = new SupportedArea("1",
            "BB Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "4");
        await this.locationController.createSupportedArea(bbSection.toJson());
        const cSection = new SupportedArea("1",
            "C Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "5");
        await this.locationController.createSupportedArea(cSection.toJson());
        const ccSection = new SupportedArea("1",
            "CC Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "6");
        await this.locationController.createSupportedArea(ccSection.toJson());
        const dSection = new SupportedArea("1",
            "D Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "7");
        await this.locationController.createSupportedArea(dSection.toJson());
        const eSection = new SupportedArea("1",
            "E Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "8");
        await this.locationController.createSupportedArea(eSection.toJson());
        const fSection = new SupportedArea("1",
            "F Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "9");
        await this.locationController.createSupportedArea(fSection.toJson());
        const gSection = new SupportedArea("1",
            "G Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "10");
        await this.locationController.createSupportedArea(gSection.toJson());
        const hSection = new SupportedArea("1",
            "H Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "11");
        await this.locationController.createSupportedArea(hSection.toJson());
        const jSection = new SupportedArea("1",
            "J Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "12");
        await this.locationController.createSupportedArea(jSection.toJson());
        const kSection = new SupportedArea("1",
            "K Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "13");
        await this.locationController.createSupportedArea(kSection.toJson());
        const lSection = new SupportedArea("1",
            "L Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "14");
        await this.locationController.createSupportedArea(lSection.toJson());
        const mSection = new SupportedArea("1",
            "M Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "15");
        await this.locationController.createSupportedArea(mSection.toJson());
        const nSection = new SupportedArea("1",
            "N Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "16");
        await this.locationController.createSupportedArea(nSection.toJson());
        const pSection = new SupportedArea("1",
            "P Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "17");
        await this.locationController.createSupportedArea(pSection.toJson());
        const qSection = new SupportedArea("1",
            "Q Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "18");
        await this.locationController.createSupportedArea(qSection.toJson());
        const rSection = new SupportedArea("1",
            "R Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "19");
        await this.locationController.createSupportedArea(rSection.toJson());
        const sSection = new SupportedArea("1",
            "S Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "20");
        await this.locationController.createSupportedArea(sSection.toJson());
        const uSection = new SupportedArea("1",
            "U Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "21");
        await this.locationController.createSupportedArea(uSection.toJson());
        const vSection = new SupportedArea("1",
            "V Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "22");
        await this.locationController.createSupportedArea(vSection.toJson());
        const wSection = new SupportedArea("1",
            "W Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "23");
        await this.locationController.createSupportedArea(wSection.toJson());
        const malukazi = new SupportedArea("1",
            "Malukazi-Umlazi-Durban-Kwa Zulu Natal-South Africa", "24");
        await this.locationController.createSupportedArea(malukazi.toJson());
        const philani = new SupportedArea("1",
            "Philani-Umlazi-Durban-Kwa Zulu Natal-South Africa", "25");
        await this.locationController.createSupportedArea(philani.toJson());
        const ySection = new SupportedArea("1",
            "Y Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "26");
        await this.locationController.createSupportedArea(ySection.toJson());
        const zSection = new SupportedArea("1",
            "Z Section-Umlazi-Durban-Kwa Zulu Natal-South Africa", "27");
        await this.locationController.createSupportedArea(zSection.toJson());

    };

    // Town/Institution 2
    async createMUTSupportedAreas() {

        const mut = new SupportedArea("2",
            "Mangosuthu (MUT)-Durban-Kwa Zulu Natal-South Africa", "28");
        await this.locationController.createSupportedArea(mut.toJson());
    };

    // Town/Institution 3
    async createDUTSupportedAreas() {
        const dut = new SupportedArea("3",
            "DUT-Durban-Kwa Zulu Natal-South Africa", "29");
        await this.locationController.createSupportedArea(dut.toJson());
    };

    // Town/Institution 4, 10, 11, 12, 13 
    async createUKZNSupportedAreas() {

        const howard = new SupportedArea("4",
            "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa", "30");
        await this.locationController.createSupportedArea(howard.toJson())

        const westville = new SupportedArea("10",
            "Westville (UKZN)-Durban-Kwa Zulu Natal-South Africa", "91");
        await this.locationController.createSupportedArea(westville.toJson())

        const nelsonMandela = new SupportedArea("11",
            "Nelson Mandela (UKZN)-Durban-Kwa Zulu Natal-South Africa", "92");
        await this.locationController.createSupportedArea(nelsonMandela.toJson())

        const edgewoood = new SupportedArea("12",
            "Edgewood (UKZN)-Pinetown-Kwa Zulu Natal-South Africa", "93");
        await this.locationController.createSupportedArea(edgewoood.toJson())

        const pietermaritzburg = new SupportedArea("13",
            "PMB (UKZN)-Pietermaritzburg-Kwa Zulu Natal-South Africa", "94");
        await this.locationController.createSupportedArea(pietermaritzburg.toJson())
    };

    // Town/Institution 5
    async createMayvilleSupportedAreas() {


        const catoCrest = new SupportedArea("5",
            "Cato Crest-Mayville-Durban-Kwa Zulu Natal-South Africa", "31");
        await this.locationController.createSupportedArea(catoCrest.toJson());
        const catoManor = new SupportedArea("5",
            "Cato Manor-Mayville-Durban-Kwa Zulu Natal-South Africa", "32");
        await this.locationController.createSupportedArea(catoManor.toJson());
        const richView = new SupportedArea("5",
            "Richview-Mayville-Durban-Kwa Zulu Natal-South Africa", "33");
        await this.locationController.createSupportedArea(richView.toJson());
        const masxha = new SupportedArea("5",
            "Masxha-Mayville-Durban-Kwa Zulu Natal-South Africa", "34");
        await this.locationController.createSupportedArea(masxha.toJson());
        const bonela = new SupportedArea("5",
            "Bonela-Mayville-Durban-Kwa Zulu Natal-South Africa", "35");
        await this.locationController.createSupportedArea(bonela.toJson());
        const nsimbini = new SupportedArea("5",
            "Nsimbini-Mayville-Durban-Kwa Zulu Natal-South Africa", "36");
        await this.locationController.createSupportedArea(nsimbini.toJson());
        const galway = new SupportedArea("5",
            "Galway-Mayville-Durban-Kwa Zulu Natal-South Africa", "89");
        await this.locationController.createSupportedArea(galway.toJson());
        const nkanini = new SupportedArea("5",
            "Nkanini-Mayville-Durban-Kwa Zulu Natal-South Africa", "90");
        await this.locationController.createSupportedArea(nkanini.toJson());
    };

    // Town/Institution 6
    async createSydenhamSupportedAreas() {
        const foreman = new SupportedArea("6",
            "Foreman-Sydenham-Durban-Kwa Zulu Natal-South Africa", "37");
        await this.locationController.createSupportedArea(foreman.toJson());
        const kennedy = new SupportedArea("6",
            "Kennedy-Sydenham-Durban-Kwa Zulu Natal-South Africa", "38");
        await this.locationController.createSupportedArea(kennedy.toJson());
        const burnwood = new SupportedArea("6",
            "Burnwood-Sydenham-Durban-Kwa Zulu Natal-South Africa", "39");
        await this.locationController.createSupportedArea(burnwood.toJson());
        const palmet = new SupportedArea("6",
            "Palmet-Sydenham-Durban-Kwa Zulu Natal-South Africa", "40");
        await this.locationController.createSupportedArea(palmet.toJson());
        const sydenhamHeight = new SupportedArea("6",
            "Sydenham Height-Sydenham-Durban-Kwa Zulu Natal-South Africa", "41");
        await this.locationController.createSupportedArea(sydenhamHeight.toJson());
        const threeRand = new SupportedArea("6",
            "3 Rand-Sydenham-Durban-Kwa Zulu Natal-South Africa", "42");
        await this.locationController.createSupportedArea(threeRand.toJson());

    };

    // Town/Institution 7
    async createDurbanCentralSupportedAreas() {
        const glenwood = new SupportedArea("7",
            "Glenwood-Durban Central-Durban-Kwa Zulu Natal-South Africa", "43");
        await this.locationController.createSupportedArea(glenwood.toJson());
        const berea = new SupportedArea("7",
            "Berea-Durban Central-Durban-Kwa Zulu Natal-South Africa", "44");
        await this.locationController.createSupportedArea(berea.toJson());
        const southBeach = new SupportedArea("7",
            "South Beach-Durban Central-Durban-Kwa Zulu Natal-South Africa", "45");
        await this.locationController.createSupportedArea(southBeach.toJson());
        const masgrave = new SupportedArea("7",
            "Masgrave-Durban Central-Durban-Kwa Zulu Natal-South Africa", "46");
        await this.locationController.createSupportedArea(masgrave.toJson());
    };

    // Town/Institution 8
    async createNandaSupportedAreas() {
        const bhambayi = new SupportedArea("8",
            "Bhambayi-Nanda-Durban-Kwa Zulu Natal-South Africa", "47");
        await this.locationController.createSupportedArea(bhambayi.toJson());
        const ezimangweni = new SupportedArea("8",
            "Ezimangweni-Nanda-Durban-Kwa Zulu Natal-South Africa", "48");
        await this.locationController.createSupportedArea(ezimangweni.toJson());
        const dikwe = new SupportedArea("8",
            "Dikwe-Nanda-Durban-Kwa Zulu Natal-South Africa", "49");
        await this.locationController.createSupportedArea(dikwe.toJson());
        const mshayazafe = new SupportedArea("8",
            "Mshayazafe-Nanda-Durban-Kwa Zulu Natal-South Africa", "50");
        await this.locationController.createSupportedArea(mshayazafe.toJson());
        const jackport = new SupportedArea("8",
            "Jackport-Nanda-Durban-Kwa Zulu Natal-South Africa", "51");
        await this.locationController.createSupportedArea(jackport.toJson());
        const ohlange = new SupportedArea("8",
            "Ohlange-Nanda-Durban-Kwa Zulu Natal-South Africa", "52");
        await this.locationController.createSupportedArea(ohlange.toJson());
        const africa = new SupportedArea("8",
            "Africa-Nanda-Durban-Kwa Zulu Natal-South Africa", "53");
        await this.locationController.createSupportedArea(africa.toJson());
        const congo = new SupportedArea("8",
            "Congo-Nanda-Durban-Kwa Zulu Natal-South Africa", "54");
        await this.locationController.createSupportedArea(congo.toJson());
        const maoti = new SupportedArea("8",
            "Maoti-Nanda-Durban-Kwa Zulu Natal-South Africa", "55");
        await this.locationController.createSupportedArea(maoti.toJson());
        const newtownA = new SupportedArea("8",
            "Newtown A-Nanda-Durban-Kwa Zulu Natal-South Africa", "56");
        await this.locationController.createSupportedArea(newtownA.toJson());
        const newtownB = new SupportedArea("8",
            "Newtown B-Nanda-Durban-Kwa Zulu Natal-South Africa", "57");
        await this.locationController.createSupportedArea(newtownB.toJson());
        const kaG = new SupportedArea("8",
            "Ka G-Nanda-Durban-Kwa Zulu Natal-South Africa", "58");
        await this.locationController.createSupportedArea(kaG.toJson());
        const matendeni = new SupportedArea("8",
            "Matendeni-Nanda-Durban-Kwa Zulu Natal-South Africa", "59");
        await this.locationController.createSupportedArea(matendeni.toJson());
        const mtshebheni = new SupportedArea("8",
            "Mtshebheni-Nanda-Durban-Kwa Zulu Natal-South Africa", "60");
        await this.locationController.createSupportedArea(mtshebheni.toJson());
        const zinkawini = new SupportedArea("8",
            "Zinkawini-Nanda-Durban-Kwa Zulu Natal-South Africa", "61");
        await this.locationController.createSupportedArea(zinkawini.toJson());
        const tafuleni = new SupportedArea("8",
            "Tafuleni-Nanda-Durban-Kwa Zulu Natal-South Africa", "62");
        await this.locationController.createSupportedArea(tafuleni.toJson());
        const ngoqokazi = new SupportedArea("8",
            "Ngoqokazi-Nanda-Durban-Kwa Zulu Natal-South Africa", "63");
        await this.locationController.createSupportedArea(ngoqokazi.toJson());
        const matikwe = new SupportedArea("8",
            "Matikwe-Nanda-Durban-Kwa Zulu Natal-South Africa", "64");
        await this.locationController.createSupportedArea(matikwe.toJson());

        const stop8 = new SupportedArea("8",
            "Stop 8-Nanda-Durban-Kwa Zulu Natal-South Africa", "65");
        await this.locationController.createSupportedArea(stop8.toJson());
        const mafuya = new SupportedArea("8",
            "Mafuya-Nanda-Durban-Kwa Zulu Natal-South Africa", "66");
        await this.locationController.createSupportedArea(mafuya.toJson());
        const nhlungwane = new SupportedArea("8",
            "Nhlungwane-Nanda-Durban-Kwa Zulu Natal-South Africa", "67");
        await this.locationController.createSupportedArea(nhlungwane.toJson());
        const newTownC = new SupportedArea("8",
            "Newtown C-Nanda-Durban-Kwa Zulu Natal-South Africa", "68");
        await this.locationController.createSupportedArea(newTownC.toJson());
        const machobeni = new SupportedArea("8",
            "Machobeni-Nanda-Durban-Kwa Zulu Natal-South Africa", "69");
        await this.locationController.createSupportedArea(machobeni.toJson());
        const mzomusha = new SupportedArea("8",
            "Mzomusha-Nanda-Durban-Kwa Zulu Natal-South Africa", "70");
        await this.locationController.createSupportedArea(mzomusha.toJson());
        const whiteCity = new SupportedArea("8",
            "White City-Nanda-Durban-Kwa Zulu Natal-South Africa", "71");
        await this.locationController.createSupportedArea(whiteCity.toJson());

    };

    // Town/Institution 9
    async createHammarsdaleSupportedAreas() {
        const oneNorth = new SupportedArea("9",
            "Unit 1 North-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "72");
        await this.locationController.createSupportedArea(oneNorth.toJson());
        const oneSouth = new SupportedArea("9",
            "Unit 1 South-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "73");
        await this.locationController.createSupportedArea(oneSouth.toJson());
        const twoNorth = new SupportedArea("9",
            "Unit 2 North-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "74");
        await this.locationController.createSupportedArea(twoNorth.toJson());
        const twoSouth = new SupportedArea("9",
            "Unit 2 South-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "75");
        await this.locationController.createSupportedArea(twoSouth.toJson());
        const three = new SupportedArea("9",
            "Unit 3-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "76");
        await this.locationController.createSupportedArea(three.toJson());
        const four = new SupportedArea("9",
            "Unit 4-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "77");
        await this.locationController.createSupportedArea(four.toJson());
        const five = new SupportedArea("9",
            "Unit 5-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "78");
        await this.locationController.createSupportedArea(five.toJson());
        const six = new SupportedArea("9",
            "Unit 6-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "79");
        await this.locationController.createSupportedArea(six.toJson());
        const seven = new SupportedArea("9",
            "Unit 7-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "80");
        await this.locationController.createSupportedArea(seven.toJson());
        const emlaba = new SupportedArea("9",
            "Mlaba Village-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "81");
        await this.locationController.createSupportedArea(emlaba.toJson());
        const georgedale = new SupportedArea("9",
            "Georgedale-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "82");
        await this.locationController.createSupportedArea(georgedale.toJson());
        const amalanga = new SupportedArea("9",
            "Amalanga-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "83");
        await this.locationController.createSupportedArea(amalanga.toJson());
        const woodglen = new SupportedArea("9",
            "Woodglen-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "84");
        await this.locationController.createSupportedArea(woodglen.toJson());
        const sankontshe = new SupportedArea("9",
            "Sankontshe-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "85");
        await this.locationController.createSupportedArea(sankontshe.toJson());
        const mophela = new SupportedArea("9",
            "Mophela-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "86");
        await this.locationController.createSupportedArea(mophela.toJson());
        const station = new SupportedArea("9",
            "Station-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "87");
        await this.locationController.createSupportedArea(station.toJson());
        const webber = new SupportedArea("9",
            "Webber-Hammarsdale-Durban-Kwa Zulu Natal-South Africa", "88");
        await this.locationController.createSupportedArea(webber.toJson());
    }



    async createSupportedAreas() {
        await this.createUmlaziSupportedAreas();
        await this.createMUTSupportedAreas();
        await this.createDUTSupportedAreas();
        await this.createUKZNSupportedAreas();
        await this.createMayvilleSupportedAreas();
        await this.createSydenhamSupportedAreas();
        await this.createDurbanCentralSupportedAreas();
        await this.createNandaSupportedAreas();
        await this.createHammarsdaleSupportedAreas();
    };

}

export default AreasCreation
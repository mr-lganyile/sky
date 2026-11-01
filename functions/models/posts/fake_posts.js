/* eslint-disable*/
import { getFirestore } from "firebase-admin/firestore";

class FakePosts {
    constructor() {

    }

    async createFakePosts() {

        let postId;
        let postCreator;

        let whereWereYouText = '';
        let whereWereYouImageURL = '';
        let whereWereYouVoiceRecordURL = '';
        let whereWereYouVideoURL = '';

        let whoWereYouWithText = '';
        let whoWereYouWithImageURL = '';
        let whoWereYouWithVoiceRecordURL = '';
        let whoWereYouWithVideoURL = '';

        let whatHappenedText = '';
        let whatHappenedVoiceRecordURL = '';
        let whatHappenedVideoURL = '';

        let reference;

        let post;

        // Umlazi Posts
        postCreator = {
            userId: "hpYGVKLfoOnXbXHdTsfsl17Uw6Kg",
            profileImageURL: "umlazi/alcoholics/profile_images/+27666666666.jpg",
            phoneNumber: "+27666666666",
            area: {
                townOrInstitutionFK: "1",
                areaName: "H Section-Umlazi-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "11",
            },
            username: "Thulani",
            password: "1rred12",
        };

        reference = getFirestore().collection("alcohol_posts").doc('hpYGVKLfoOnXbXHdTsfsl17Uw6Kg');
        postId = reference.id;

        whereWereYouText = 'Ay Ebhorabhora Kuyafiwa Ubumnandi';

        post = {
            postId: postId,
            postCreator: postCreator,
            forTownOrInstitutionNo: "1",
            dateCreated: {
                year: 2026,
                month: 4,
                date: 8,
                hour: 19,
                minute: 5
            },
            whereWereYouText: whereWereYouText,
            whereWereYouImageURL: whereWereYouImageURL,
            whereWereYouVoiceRecordURL: whereWereYouVoiceRecordURL,
            whereWereYouVideoURL: whereWereYouVideoURL,

            whoWereYouWithText: whoWereYouWithText,
            whoWereYouWithImageURL: whoWereYouWithImageURL,
            whoWereYouWithVoiceRecordURL: whoWereYouWithVoiceRecordURL,
            whoWereYouWithVideoURL: whoWereYouWithVideoURL,

            whatHappenedText: whatHappenedText,
            whatHappenedVoiceRecordURL: whatHappenedVoiceRecordURL,
            whatHappenedVideoURL: whatHappenedVideoURL,
        }

        await reference.set(post);

        // MUT Posts
        postCreator = {
            userId: "hpYGVKLfoOnXbppppnv4l17Uw6Kg",
            profileImageURL: "mangosuthu (mut)/alcoholics/profile_images/+27610101010.jpg",
            phoneNumber: "+27610101010",
            area: {
                townOrInstitutionFK: "2",
                areaName: "Mangosuthu (MUT)-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "28",
            },
            username: "Thola",
            password: "12a",
        };

        reference = getFirestore().collection("alcohol_posts").doc('pYGVKLfoOnXbppppnv4l17Uw6Kg');
        postId = reference.id;

        whereWereYouText = ''
        whereWereYouImageURL = `mangosuthu (mut)/alcohol_posts/where_were_you/images/${postId}.jpg`;

        post = {
            postId: postId,
            postCreator: postCreator,
            forTownOrInstitutionNo: "2",
            dateCreated: {
                year: 2026,
                month: 4,
                date: 8,
                hour: 18,
                minute: 5
            },
            whereWereYouText: whereWereYouText,
            whereWereYouImageURL: whereWereYouImageURL,
            whereWereYouVoiceRecordURL: whereWereYouVoiceRecordURL,
            whereWereYouVideoURL: whereWereYouVideoURL,

            whoWereYouWithText: whoWereYouWithText,
            whoWereYouWithImageURL: whoWereYouWithImageURL,
            whoWereYouWithVoiceRecordURL: whoWereYouWithVoiceRecordURL,
            whoWereYouWithVideoURL: whoWereYouWithVideoURL,

            whatHappenedText: whatHappenedText,
            whatHappenedVoiceRecordURL: whatHappenedVoiceRecordURL,
            whatHappenedVideoURL: whatHappenedVideoURL,
        }

        await reference.set(post);

        // DUT Posts
        postCreator = {
            userId: "hpYGVKLfoOnXbXHdTnv4kkmmw6Kg",
            profileImageURL: "dut/alcoholics/profile_images/+276887654321.jpg",
            phoneNumber: "+276887654321",
            area: {
                townOrInstitutionFK: "3",
                areaName: "DUT-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "29",
            },
            username: "Sne",
            password: "ytcc",
        };

        reference = getFirestore().collection("alcohol_posts").doc('hpYGVKLfoOnXbXHdTnv4kkmmw6Kg');
        postId = reference.id;

        whereWereYouImageURL = `dut/alcohol_posts/where_were_you/images/${postId}.jpg`;

        post = {
            postId: postId,
            postCreator: postCreator,
            forTownOrInstitutionNo: "3",
            dateCreated: {
                year: 2026,
                month: 4,
                date: 8,
                hour: 17,
                minute: 45
            },
            whereWereYouText: whereWereYouText,
            whereWereYouImageURL: whereWereYouImageURL,
            whereWereYouVoiceRecordURL: whereWereYouVoiceRecordURL,
            whereWereYouVideoURL: whereWereYouVideoURL,

            whoWereYouWithText: whoWereYouWithText,
            whoWereYouWithImageURL: whoWereYouWithImageURL,
            whoWereYouWithVoiceRecordURL: whoWereYouWithVoiceRecordURL,
            whoWereYouWithVideoURL: whoWereYouWithVideoURL,

            whatHappenedText: whatHappenedText,
            whatHappenedVoiceRecordURL: whatHappenedVoiceRecordURL,
            whatHappenedVideoURL: whatHappenedVideoURL,
        }

        await reference.set(post);

        // UKZN
        postCreator = {
            userId: 'aHs3EWiJjPINmkj50051ij2dyLuu',
            profileImageURL: "ukzn/alcoholics/profile_images/+27611111111.jpg",
            phoneNumber: "+27611111111",
            area: {
                townOrInstitutionFK: "4",
                areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "30",
            },
            username: "Thabiso",
            password: "kwl-guy1",
        };

        reference = getFirestore().collection("alcohol_posts").doc('aHs3EWiJjPINmkj50051ij2dyLuu');
        postId = reference.id;

        whereWereYouImageURL = ''
        whoWereYouWithImageURL = `ukzn/alcohol_posts/who_were_you_with/images/${postId}.jpeg`;

        post = {
            postId: postId,
            forTownOrInstitutionNo: "4",
            postCreator: postCreator,
            dateCreated: {
                year: 2026,
                month: 4,
                date: 9,
                hour: 2,
                minute: 5
            },
            whereWereYouText: whereWereYouText,
            whereWereYouImageURL: whereWereYouImageURL,
            whereWereYouVoiceRecordURL: whereWereYouVoiceRecordURL,
            whereWereYouVideoURL: whereWereYouVideoURL,

            whoWereYouWithText: whoWereYouWithText,
            whoWereYouWithImageURL: whoWereYouWithImageURL,
            whoWereYouWithVoiceRecordURL: whoWereYouWithVoiceRecordURL,
            whoWereYouWithVideoURL: whoWereYouWithVideoURL,

            whatHappenedText: whatHappenedText,
            whatHappenedVoiceRecordURL: whatHappenedVoiceRecordURL,
            whatHappenedVideoURL: whatHappenedVideoURL,
        }

        await reference.set(post);

        postCreator = {
            userId: 'aHs3EWiJjPINmklll051ij2dyLkN',
            profileImageURL: "ukzn/alcoholics/profile_images/+27622222222.jpg",
            phoneNumber: "+27622222222",
            area: {
                townOrInstitutionFK: "4",
                areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "30",
            },
            username: "Lunga",
            password: "kwl-guy2",
        };

        reference = getFirestore().collection("alcohol_posts").doc('aHs3EWiJjPINmklll051ij2dyLkN');
        postId = reference.id;

        whoWereYouWithImageURL = ''
        whatHappenedVideoURL = `ukzn/alcohol_posts/what_happened/videos/${postId}.mp4`;

        post = {
            postId: postId,
            forTownOrInstitutionNo: "4",
            postCreator: postCreator,
            dateCreated: {
                year: 2026,
                month: 4,
                date: 9,
                hour: 1,
                minute: 5
            },
            whereWereYouText: whereWereYouText,
            whereWereYouImageURL: whereWereYouImageURL,
            whereWereYouVoiceRecordURL: whereWereYouVoiceRecordURL,
            whereWereYouVideoURL: whereWereYouVideoURL,

            whoWereYouWithText: whoWereYouWithText,
            whoWereYouWithImageURL: whoWereYouWithImageURL,
            whoWereYouWithVoiceRecordURL: whoWereYouWithVoiceRecordURL,
            whoWereYouWithVideoURL: whoWereYouWithVideoURL,

            whatHappenedText: whatHappenedText,
            whatHappenedVoiceRecordURL: whatHappenedVoiceRecordURL,
            whatHappenedVideoURL: whatHappenedVideoURL,
        }

        await reference.set(post);

        postCreator = {
            userId: 'aHs3EWiJjPINmkj50051ij2dyLkN',
            profileImageURL: "ukzn/alcoholics/profile_images/+27611111111.jpg",
            phoneNumber: "+27611111111",
            area: {
                townOrInstitutionFK: "4",
                areaName: "Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "30",
            },
            username: "Thabiso",
            password: "kwl-guy1",
        };

        reference = getFirestore().collection("alcohol_posts").doc('aHs3EWiJjPINmkj50051ij2dyLkN');
        postId = reference.id;

        whatHappenedVideoURL = ''
        whoWereYouWithImageURL = '';
        whereWereYouText = 'Last night was awesome in florida @Hooters!!!'

        post = {
            postId: postId,
            forTownOrInstitutionNo: "4",
            postCreator: postCreator,
            dateCreated: {
                year: 2026,
                month: 3,
                date: 28,
                hour: 15,
                minute: 5
            },
            whereWereYouText: whereWereYouText,
            whereWereYouImageURL: whereWereYouImageURL,
            whereWereYouVoiceRecordURL: whereWereYouVoiceRecordURL,
            whereWereYouVideoURL: whereWereYouVideoURL,

            whoWereYouWithText: whoWereYouWithText,
            whoWereYouWithImageURL: whoWereYouWithImageURL,
            whoWereYouWithVoiceRecordURL: whoWereYouWithVoiceRecordURL,
            whoWereYouWithVideoURL: whoWereYouWithVideoURL,

            whatHappenedText: whatHappenedText,
            whatHappenedVoiceRecordURL: whatHappenedVoiceRecordURL,
            whatHappenedVideoURL: whatHappenedVideoURL,
        }

        await reference.set(post);

        // Mayville Posts
        postCreator = {
            userId: "hpYGVKLfoOnXbXHdTnv4l17Uw6Kg",
            profileImageURL: "mayville/alcoholics/profile_images/+27610101010.jpg",
            phoneNumber: "+27610101010",
            area: {
                townOrInstitutionFK: "5",
                areaName: "Cato Crest-Mayville-Durban-Kwa Zulu Natal-South ",
                areaNo: "31",
            },
            username: "Sakhile",
            password: "12abc12",
        };

        reference = getFirestore().collection("alcohol_posts").doc('hpYGVKLfoOnXbXHdTnv4l17Uw6Kg');
        postId = reference.id;

        whereWereYouText = 'Ay Besenza Amasimba Izolo KaSbu E-Carwash...'
        whereWereYouImageURL = ''
        whoWereYouWithImageURL = '';

        post = {
            postId: postId,
            postCreator: postCreator,
            forTownOrInstitutionNo: "5",
            dateCreated: {
                year: 2026,
                month: 4,
                date: 8,
                hour: 19,
                minute: 5
            },
            whereWereYouText: whereWereYouText,
            whereWereYouImageURL: whereWereYouImageURL,
            whereWereYouVoiceRecordURL: whereWereYouVoiceRecordURL,
            whereWereYouVideoURL: whereWereYouVideoURL,

            whoWereYouWithText: whoWereYouWithText,
            whoWereYouWithImageURL: whoWereYouWithImageURL,
            whoWereYouWithVoiceRecordURL: whoWereYouWithVoiceRecordURL,
            whoWereYouWithVideoURL: whoWereYouWithVideoURL,

            whatHappenedText: whatHappenedText,
            whatHappenedVoiceRecordURL: whatHappenedVoiceRecordURL,
            whatHappenedVideoURL: whatHappenedVideoURL,
        }

        await reference.set(post);

        // Sydenham Posts
        postCreator = {
            userId: "18owxmmIxijTyF2fGmAeFXNk3ktM",
            profileImageURL: "sydenham/alcoholics/profile_images/+27634567890.jpg",
            phoneNumber: "+27634567890",
            area: {
                townOrInstitutionFK: "6",
                areaName: "Foreman-Sydenham-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "37",
            },
            username: "Luyolo",
            password: "czwe21",
        };

        reference = getFirestore().collection("alcohol_posts").doc('18owxmmIxijTyF2fGmAeFXNk3ktM');
        postId = reference.id;

        whereWereYouText = '';
        whereWereYouImageURL = ''
        whatHappenedVideoURL = `sydenham/alcohol_posts/what_happened/videos/${postId}.mp4`;

        post = {
            postId: postId,
            forTownOrInstitutionNo: "6",
            postCreator: postCreator,
            dateCreated: {
                year: 2026,
                month: 4,
                date: 7,
                hour: 16,
                minute: 5
            },
            whereWereYouText: whereWereYouText,
            whereWereYouImageURL: whereWereYouImageURL,
            whereWereYouVoiceRecordURL: whereWereYouVoiceRecordURL,
            whereWereYouVideoURL: whereWereYouVideoURL,

            whoWereYouWithText: whoWereYouWithText,
            whoWereYouWithImageURL: whoWereYouWithImageURL,
            whoWereYouWithVoiceRecordURL: whoWereYouWithVoiceRecordURL,
            whoWereYouWithVideoURL: whoWereYouWithVideoURL,

            whatHappenedText: whatHappenedText,
            whatHappenedVoiceRecordURL: whatHappenedVoiceRecordURL,
            whatHappenedVideoURL: whatHappenedVideoURL,
        }

        await reference.set(post);



        // Durban Central
        postCreator = {
            userId: "ezz5IaZtY6h52Dg04MFBSbWhKIsY",
            profileImageURL: "durban central/alcoholics/profile_images/+27767890123.jpg",
            phoneNumber: "+27723456789",
            area: {
                townOrInstitutionFK: "7",
                areaName: "Berea-Durban Central-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "44",
            },
            username: "Andy",
            password: "cii0",
        };

        reference = getFirestore().collection("alcohol_posts").doc('ezz5IaZtY6h52Dg04MFBSbWhKIsY');
        postId = reference.id;

        whatHappenedVideoURL = '';
        whereWereYouImageURL = ''
        whoWereYouWithImageURL = `durban central/alcohol_posts/who_were_you_with/images/${postId}.jpg`


        post = {
            postId: postId,
            forTownOrInstitutionNo: "7",
            postCreator: postCreator,
            dateCreated: {
                year: 2025,
                month: 4,
                date: 1,
                hour: 4,
                minute: 5
            },
            whereWereYouText: whereWereYouText,
            whereWereYouImageURL: whereWereYouImageURL,
            whereWereYouVoiceRecordURL: whereWereYouVoiceRecordURL,
            whereWereYouVideoURL: whereWereYouVideoURL,

            whoWereYouWithText: whoWereYouWithText,
            whoWereYouWithImageURL: whoWereYouWithImageURL,
            whoWereYouWithVoiceRecordURL: whoWereYouWithVoiceRecordURL,
            whoWereYouWithVideoURL: whoWereYouWithVideoURL,

            whatHappenedText: whatHappenedText,
            whatHappenedVoiceRecordURL: whatHappenedVoiceRecordURL,
            whatHappenedVideoURL: whatHappenedVideoURL,
        }

        await reference.set(post);

        // Nanda Posts
        postCreator = {
            userId: "hpYGVKLfoOnXbXHdred4l17Uw6Kg",
            profileImageURL: "nanda/alcoholics/profile_images/+27811111111.jpg",
            phoneNumber: "+27811111111",
            area: {
                townOrInstitutionFK: "8",
                areaName: "Newtown C-Nanda-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "68",
            },
            username: "Bo",
            password: "12aok12",
        };

        reference = getFirestore().collection("alcohol_posts").doc('hpYGVKLfoOnXbXHdred4l17Uw6Kg');
        postId = reference.id;

        whereWereYouText = 'Ay Iyashawa Iplaki Enanda Bafe2...';
        whereWereYouImageURL = ''
        whoWereYouWithImageURL = '';

        post = {
            postId: postId,
            postCreator: postCreator,
            forTownOrInstitutionNo: "8",
            dateCreated: {
                year: 2026,
                month: 4,
                date: 8,
                hour: 19,
                minute: 5
            },
            whereWereYouText: whereWereYouText,
            whereWereYouImageURL: whereWereYouImageURL,
            whereWereYouVoiceRecordURL: whereWereYouVoiceRecordURL,
            whereWereYouVideoURL: whereWereYouVideoURL,

            whoWereYouWithText: whoWereYouWithText,
            whoWereYouWithImageURL: whoWereYouWithImageURL,
            whoWereYouWithVoiceRecordURL: whoWereYouWithVoiceRecordURL,
            whoWereYouWithVideoURL: whoWereYouWithVideoURL,

            whatHappenedText: whatHappenedText,
            whatHappenedVoiceRecordURL: whatHappenedVoiceRecordURL,
            whatHappenedVideoURL: whatHappenedVideoURL,
        }

        await reference.set(post);

        // Hamarsdale Posts
        postCreator = {
            userId: "hpYGVKLfoOnXbXHdredyyyyUw6Kg",
            profileImageURL: "hamarsdale/alcoholics/profile_images/+27677889900.jpg",
            phoneNumber: "+2+27677889900",
            area: {
                townOrInstitutionFK: "9",
                areaName: "Mlaba Village-Hammarsdale-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "81",
            },
            username: "Thanda",
            password: "12aok12",
        };

        reference = getFirestore().collection("alcohol_posts").doc('hpYGVKLfoOnXbXHdredyyyyUw6Kg');
        postId = reference.id;

        whereWereYouText = '';
        whatHappenedVideoURL = `hamarsdale/alcohol_posts/what_happened/videos/${postId}.mp4`;

        post = {
            postId: postId,
            postCreator: postCreator,
            forTownOrInstitutionNo: "9",
            dateCreated: {
                year: 2026,
                month: 4,
                date: 8,
                hour: 19,
                minute: 5
            },
            whereWereYouText: whereWereYouText,
            whereWereYouImageURL: whereWereYouImageURL,
            whereWereYouVoiceRecordURL: whereWereYouVoiceRecordURL,
            whereWereYouVideoURL: whereWereYouVideoURL,

            whoWereYouWithText: whoWereYouWithText,
            whoWereYouWithImageURL: whoWereYouWithImageURL,
            whoWereYouWithVoiceRecordURL: whoWereYouWithVoiceRecordURL,
            whoWereYouWithVideoURL: whoWereYouWithVideoURL,

            whatHappenedText: whatHappenedText,
            whatHappenedVoiceRecordURL: whatHappenedVoiceRecordURL,
            whatHappenedVideoURL: whatHappenedVideoURL,
        }

        await reference.set(post);
    }
}

export default FakePosts
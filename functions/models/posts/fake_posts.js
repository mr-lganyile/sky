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

        // DBN Central Posts
        postCreator = {
            userId: "2umY4uSkQYfxoMKcGiRVlyAfW3U2",
            profileImageURL: "durban central/users/profile_images/+27633333333.jpg",
            phoneNumber: "+27633333333",
            area: {
                townOrInstitutionFK: "7",
                areaName: "Glenwood-Durban Central-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "43",
            },
            username: "Jackie",
            password: "gold321",
        };

        reference = getFirestore().collection("alcohol_posts").doc('2umY4uSkQYfxoMKcGiRVlyAfW3U2');
        postId = reference.id;

        whereWereYouText = 'Florida Is The Best Place In DBN!!!';

        post = {
            postId: postId,
            postCreator: postCreator,
            forTownOrInstitutionNo: "7",
            dateCreated: {
                year: 2026,
                month: 11,
                date: 4,
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


        postCreator = {
            userId: "a9XM9iTAevdr2EvYXvR5IwBb6EC3",
            profileImageURL: "durban central/users/profile_images/+27622222222.jpg",
            phoneNumber: "+27622222222",
            area: {
                townOrInstitutionFK: "7",
                areaName: "South Beach-Durban Central-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "45",
            },
            username: "Amanda",
            password: "silver56",
        };

        reference = getFirestore().collection("alcohol_posts").doc('a9XM9iTAevdr2EvYXvR5IwBb6EC3');
        postId = reference.id;

        whereWereYouText = ''
        whereWereYouImageURL = `durban central/alcohol_posts/where_were_you/images/${postId}.jpg`;

        post = {
            postId: postId,
            postCreator: postCreator,
            forTownOrInstitutionNo: "7",
            dateCreated: {
                year: 2026,
                month: 11,
                date: 3,
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

        postCreator = {
            userId: "b2AoEffPghRBA5RF2fS5RqAeqSl1",
            profileImageURL: "durban central/users/profile_images/+27644444444.jpg",
            phoneNumber: "+27644444444",
            area: {
                townOrInstitutionFK: "7",
                areaName: "Berea-Durban Central-Durban-Kwa Zulu Natal-South Africa",
                areaNo: "44",
            },
            username: "Yo",
            password: "kwl",
        };

        reference = getFirestore().collection("alcohol_posts").doc('b2AoEffPghRBA5RF2fS5RqAeqSl1');
        postId = reference.id;

        whereWereYouImageURL = '';
        whatHappenedVideoURL = `durban central/alcohol_posts/what_happened/videos/${postId}.jpg`;

        post = {
            postId: postId,
            postCreator: postCreator,
            forTownOrInstitutionNo: "7",
            dateCreated: {
                year: 2026,
                month: 3,
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
            profileImageURL: "ukzn/users/profile_images/+27611111111.jpg",
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
            profileImageURL: "ukzn/users/profile_images/+27622222222.jpg",
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
            profileImageURL: "ukzn/users/profile_images/+27611111111.jpg",
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
    }
}

export default FakePosts
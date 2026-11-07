/* eslint-disable*/
"use strict";

// [START all]
// [START import]

import { onDocumentCreated, onDocumentDeleted, onDocumentUpdated }
    from "firebase-functions/v2/firestore";

import { onRequest } from "firebase-functions/v2/https";

// The Firebase Admin SDK to access Firestore.
import { initializeApp, applicationDefault } from "firebase-admin/app";
import { getFirestore, Timestamp } from "firebase-admin/firestore";



initializeApp({
    credential: applicationDefault(),
    databaseURL: 'https://sky-4all.firebaseio.com'
});


import CountriesCreation from "./models/locations/countries-creation.js";
import ProvinciesOrStatesCreation from "./models/locations/provinces-or-states-creation.js";
import CitiesCreation from "./models/locations/cities-creation.js";
import TownsOrInstitutionsCreation from "./models/locations/towns-or-institutions-creation.js";
import AreasCreation from "./models/locations/areas-creation.js";

import FakeUsers from "./models/users/fake_users.js";
import FakePosts from "./models/posts/fake_posts.js";

const fakeUsers = new FakeUsers();
const fakePosts = new FakePosts();


// http://127.0.0.1:5001/sky-and-stars/africa-south1/createSupportedLocations/
// http://127.0.0.1:5001/sky-and-stars/africa-south1/createFakeUsers
// http://127.0.0.1:5001/sky-and-stars/africa-south1/saveFakePosts


// https://createsupportedlocations-e7pngdclvq-bq.a.run.app
// https://createfakeusers-e7pngdclvq-bq.a.run.app
// https://savefakeposts-e7pngdclvq-bq.a.run.app



// ###################Production Functions [Start]########################

// ==============================On Request [Start]==============================

// http://127.0.0.1:5001/sky-and-stars/africa-south1/createSupportedLocations/
export const createSupportedLocations = onRequest(
    { region: "africa-south1" },
    async (req, res) => {

        const countriesCreation = new CountriesCreation();
        await countriesCreation.createSupportedCountries();
        const provinciesOrStatesCreation = new ProvinciesOrStatesCreation();
        await provinciesOrStatesCreation.createSupportedProvincesOrStates()
        const citiesCreation = new CitiesCreation();
        await citiesCreation.createSupportedCities();
        const townsOrInstitutionsCreation = new TownsOrInstitutionsCreation();
        await townsOrInstitutionsCreation.createSupportedTownsOrInstitutions();
        const areasCreation = new AreasCreation();
        await areasCreation.createSupportedAreas();
        res.json({ result: `Supported Areas Created Successfully.` });
    });

// ==============================On Request [End]==============================

// ==============================On Document Created [Start]==============================

export const setAlcoholPostDate = onDocumentCreated(
    {
        document: "/alcohol_posts/{postId}",
        region: "africa-south1"
    }, async (event) => {

        const docReference = getFirestore()
            .collection("alcohol_posts").doc(event.params.postId);

        const dateObject = Timestamp.now().toDate();

        const year = dateObject.getFullYear();
        const month = dateObject.getMonth() + 1;
        const date = dateObject.getDate();
        const hour = dateObject.getHours() + 2;
        const minute = dateObject.getMinutes();

        const dateMap = {
            'year': year,
            'month': month,
            'date': date,
            'hour': hour,
            'minute': minute
        };

        await docReference.update({ dateCreated: dateMap });
        // log('Update Performed...');
    });

export const setClothingPostDate = onDocumentCreated(
    {
        document: "/clothing_posts/{postId}",
        region: "africa-south1"
    }, async (event) => {

        const docReference = getFirestore()
            .collection("clothing_posts").doc(event.params.postId);

        const dateObject = Timestamp.now().toDate();

        const year = dateObject.getFullYear();
        const month = dateObject.getMonth() + 1;
        const date = dateObject.getDate();
        const hour = dateObject.getHours() + 2;
        const minute = dateObject.getMinutes();

        const dateMap = {
            'year': year,
            'month': month,
            'date': date,
            'hour': hour,
            'minute': minute
        };

        await docReference.update({ dateCreated: dateMap });
        // log('Update Performed...');
    });

// ==============================On Document Created [End]==============================

// ##################Production Functions [End]########################

// ########Development Functions [Start]###############

// http://127.0.0.1:5001/sky-and-stars/africa-south1/createFakeUsers
export const createFakeUsers = onRequest(
    {
        region: "africa-south1"
    }, async (req, res) => {

        // True means use online auth users, otherwise use emulator's.
        fakeUsers.createFakeUsers(false);
        // Send back a message that we"ve successfully written to the db.
        res.json({ result: `Fake Users Saved.` });
    });

// http://127.0.0.1:5001/sky-and-stars/africa-south1/saveFakePosts
export const saveFakePosts = onRequest(
    {
        region: "africa-south1"
    },
    async (req, res) => {

        fakePosts.createFakePosts();
        res.json({ result: `Fake Posts Successfully Created.` });

    });

// ########Development Functions [End]###############



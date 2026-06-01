/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { setGlobalOptions } = require("firebase-functions");
const { onRequest } = require("firebase-functions/https");
const logger = require("firebase-functions/logger");

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({ maxInstances: 10 });

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const axios = require('axios');
admin.initializeApp();
const cors = require('cors')({ origin: true });

const { onCall, HttpsError } = require("firebase-functions/https");
const { defineSecret } = require("firebase-functions/params");



const BREVO_API_KEY = defineSecret("BREVO_API_KEY");

exports.sendEmail = functions.https.onCall(
  { secrets: [BREVO_API_KEY] },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "Non authentifié",
        "Vous devez etre enregistrer pour utiliser ce functionnalité"
      );

    }
    const { firstname, lastname, email, phone, subject, message } = request.data;

    const apiKey = BREVO_API_KEY.value();


    try {
      const response = await axios.post(
        "https://api.brevo.com/v3/smtp/email",
        {
          sender: {
            name: "Amadou Dieng",
            email: "amadiengdieng@gmail.com",
          },
          to: [
            {
              email,
              name: `${lastname} ${firstname}` || "User",
            },
          ],
          subject: `${subject}`,
          htmlContent: `${message}` ,
        },
        {
          headers: {
            "api-key": apiKey,
            "content-type": "application/json",
            accept: "application/json",
          },
        }
      );

      return { success: true, data: response.data };
    } catch (error) {
      console.error(error);
      return {
        success: false,
        error: error.message,
      };
    }
  }
);


/*
exports.setAdminRole = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    try {

      if (!req.auth) {
        throw new HttpsError(
          "Non authentifié",
          "Vous devez etre enregistrer pour utiliser ce functionnalité"
        );
      }
      const uid = req.body.uid;
      const role = req.body.role;

      await admin.auth().setCustomUserClaims(uid, {
        role: role,
      });

      res.status(200).send({ success: true });
    } catch (error) {
      res.status(500).send({ error: error.message });
    }
  });

});
*/


exports.setSuperAdminRole = functions.https.onRequest(async (req, res) => {

  cors(req, res, async () => {
    try {
      const uid = req.body.uid;
      const role = req.body.role;

      await admin.auth().setCustomUserClaims(uid, {
        role: role,
      });

      res.status(200).send({ success: true });
    } catch (error) {
      res.status(500).send({ error: error.message });
    }
  });



});



exports.createUser = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    try {
      // Get token from Authorization header
      const authHeader = req.headers.authorization;
      console.log(authHeader);
      if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({
          error: 'Unauthorized',
        });
      }

      // Extract token
      const idToken = authHeader.split('Bearer ')[1];
      // Verify Firebase token
      const decodedToken = await admin.auth().verifyIdToken(idToken);

      // Example: only admins can create users
      if (decodedToken.role !== 'Admin' && decodedToken.role !== 'SuperAdmin') {
        return res.status(403).json({
          error: 'Forbidden',
        });
      }

      const { email, password, role } = req.body;

      // Create user
      const user = await admin.auth().createUser({
        email,
        password,
      });

      await admin.auth().setCustomUserClaims(user.uid, {
        role: role,
      });

      res.status(200).json({
        uid: user.uid,
        email: user.email,
        role: role
      });

    } catch (e) {
      console.error(e);

      res.status(401).json({
        error: e.message,
      });
    }
  })
});

async function authenticate(req) {
  const authHeader = req.headers.authorization;

  if (!authHeader?.startsWith('Bearer ')) {
    throw new Error('Unauthorized');
  }

  const token = authHeader.split('Bearer ')[1];

  return await admin.auth().verifyIdToken(token);
}

exports.geocodeAddress = functions.https.onRequest(async (req, res) => {

  cors(req, res, async () => {
    try {
      const address = req.query.address;

      if (!address) {
        return res.status(400).json({
          error: "Address is required",
        });
      }

      const url =
        `https://nominatim.openstreetmap.org/search` +
        `?q=${encodeURIComponent(address)}` +
        `&format=json&limit=1`;

      const response = await axios.get(url, {
        headers: {
          "User-Agent": "FirebaseGeocoder/1.0",
        },
      });

      const data = response.data;

      if (!data || data.length === 0) {
        return res.status(404).json({
          error: "Location not found",
        });
      }

      return res.json({
        latitude: parseFloat(data[0].lat),
        longitude: parseFloat(data[0].lon),
      });

    } catch (error) {
      res.status(500).send({ error: error.message });
    }
  });



});

exports.createUserWithoutPassword = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    try {
      // Get token from Authorization header
      const authHeader = req.headers.authorization;
      console.log(authHeader);
      if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({
          error: 'Unauthorized',
        });
      }

      // Extract token
      const idToken = authHeader.split('Bearer ')[1];
      // Verify Firebase token
      const decodedToken = await admin.auth().verifyIdToken(idToken);

      // Example: only admins can create users
      if (decodedToken.role !== 'Admin' && decodedToken.role !== 'SuperAdmin') {
        return res.status(403).json({
          error: 'Forbidden',
        });
      }

      const { email, name, role } = req.body;

      // Create user
      const user = await admin.auth().createUser({
        email,
        name
      });

      await admin.auth().setCustomUserClaims(user.uid, {
        role: role,
      });

      const resetLink = await admin.auth().generatePasswordResetLink(email);

      res.status(200).json({
        uid: user.uid,
        email: user.email,
        role: role,
        link: resetLink
      });

    } catch (e) {
      console.error(e);

      res.status(401).json({
        error: e.message,
      });
    }
  })
});
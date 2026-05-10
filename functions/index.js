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
admin.initializeApp();
const cors = require('cors')({ origin: true });

/*
const BREVO_API_KEY = defineSecret("BREVO_API_KEY");

export const sendEmail = onCall(
  { secrets: [BREVO_API_KEY] },
  async (request) => {
    if(!request.auth){
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
          subject: `${subject} ${phone}`,
          htmlContent: message,
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
*/


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
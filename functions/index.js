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
const { getAuth } = require("firebase-admin/auth");
const axios = require('axios');
admin.initializeApp();
const cors = require('cors')({ origin: true });

const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");



const BREVO_API_KEY = defineSecret("BREVO_API_KEY");

// Must match the UserRole enum in lib/services/interfaces/i_user_service.dart
const USER_ROLES = ["Admin", "User", "Employe", "Guest", "SuperAdmin", "Manager", "Support", "Driver", "Owner"];
const ADMIN_ROLES = ["Admin", "SuperAdmin"];

// Only a SuperAdmin may hand out Admin or SuperAdmin; Admins may grant the rest.
function canAssignRole(callerRole, role) {
  if (!USER_ROLES.includes(role)) return false;
  if (ADMIN_ROLES.includes(role)) return callerRole === "SuperAdmin";
  return ADMIN_ROLES.includes(callerRole);
}

// Map Firebase Auth errors to a proper HTTP status instead of always 401.
function authErrorStatus(e) {
  switch (e.code) {
    case "auth/email-already-exists": return 409;
    case "auth/invalid-email":
    case "auth/invalid-password":
    case "auth/invalid-display-name": return 400;
    case "auth/id-token-expired":
    case "auth/id-token-revoked":
    case "auth/argument-error": return 401;
    default: return 500;
  }
}

exports.sendEmail = onCall(
  { secrets: [BREVO_API_KEY] },
  async (request) => {
    if (!request.auth) {
      throw new HttpsError(
        "unauthenticated",
        "Vous devez etre enregistrer pour utiliser ce functionnalité"
      );

    }
    // The Brevo sender is ours: only admins may send, otherwise any signed-in
    // user could relay arbitrary HTML to any address.
    if (!ADMIN_ROLES.includes(request.auth.token.role)) {
      throw new HttpsError("permission-denied", "Forbidden");
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
              name: `${lastname ?? ""} ${firstname ?? ""}`.trim() || "User",
            },
          ],
          subject: `${subject}`,
          htmlContent: `${message}`,
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


exports.setSuperAdminRole = functions.https.onRequest(async (req, res) => {
  console.log("FIREBASE_AUTH_EMULATOR_HOST:", process.env.FIREBASE_AUTH_EMULATOR_HOST);
  
  cors(req, res, async () => {
    // Auth is not emulated on purpose: roles are written to the production
    // Firebase Auth shared with the movegui client app.
    let caller;
    try {
      caller = await authenticate(req);
    } catch (e) {
      return res.status(401).send({ error: "Unauthorized" });
    }

    const { uid, role } = req.body;

    if (!USER_ROLES.includes(role)) {
      return res.status(400).send({ error: `Invalid role: ${role}` });
    }

    // A SuperAdmin can set any role. The only other case allowed is the
    // dev bootstrap in main_dev.dart, where a freshly created user sets its
    // own role - and only from a locally running functions emulator, never
    // from the deployed function.
    const isSuperAdmin = caller.role === "SuperAdmin";
    const isEmulatorBootstrap =
      process.env.FUNCTIONS_EMULATOR === "true" && caller.uid === uid;
    if (!isSuperAdmin && !isEmulatorBootstrap) {
      return res.status(403).send({ error: "Forbidden" });
    }

    try {
      console.log("UID received:", uid);
      console.log("ROLE received:", role);

      const user = await getAuth().getUser(uid);

      console.log("Found Firebase user:", user.email);
  
      await getAuth().setCustomUserClaims(uid, {
        role: role,
      });
      

      res.status(200).send({ success: true });
    } catch (error) {
      console.error("Error setting custom claims:", error);
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
      const decodedToken = await getAuth().verifyIdToken(idToken);

      // Example: only admins can create users
      if (decodedToken.role !== 'Admin' && decodedToken.role !== 'SuperAdmin') {
        return res.status(403).json({
          error: 'Forbidden',
        });
      }

      const { email, password, role } = req.body;

      if (!canAssignRole(decodedToken.role, role)) {
        return res.status(403).json({
          error: `Not allowed to assign role: ${role}`,
        });
      }

      // Create user
      const user = await getAuth().createUser({
        email,
        password,
      });

      await getAuth().setCustomUserClaims(user.uid, {
        role: role,
      });

      res.status(200).json({
        uid: user.uid,
        email: user.email,
        role: role
      });

    } catch (e) {
      console.error(e);

      res.status(authErrorStatus(e)).json({
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

  return await getAuth().verifyIdToken(token);
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
      const authHeader = req.headers.authorization;
      console.log(authHeader);
      if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({
          error: 'Unauthorized',
        });
      }

      const idToken = authHeader.split('Bearer ')[1];
      const decodedToken = await getAuth().verifyIdToken(idToken);
      if (decodedToken.role !== 'Admin' && decodedToken.role !== 'SuperAdmin') {
        return res.status(403).json({
          error: 'Forbidden',
        });
      }
      const { email, name, role } = req.body;

      if (!canAssignRole(decodedToken.role, role)) {
        return res.status(403).json({
          error: `Not allowed to assign role: ${role}`,
        });
      }

      const user = await getAuth().createUser({
        email,
        displayName: name || undefined,
      });

      await getAuth().setCustomUserClaims(user.uid, {
        role: role,
      });
      const resetLink = await getAuth().generatePasswordResetLink(email);
      res.status(200).json({
        uid: user.uid,
        email: user.email,
        role: role,
        link: resetLink
      });

    } catch (e) {
      console.error(e);

      res.status(authErrorStatus(e)).json({
        error: e.message,
      });
    }
  })
}); 

exports.addressFromGeoCoord = functions.https.onRequest(
  async (req, res) => {
    cors(req, res, async () => {
      try {
        const latitude = req.query.latitude;
        const longitude = req.query.longitude;

        if (!latitude || !longitude) {
          return res.status(400).json({
            error: "latitude and longitude are required",
          });
        }

        const url =
          `https://nominatim.openstreetmap.org/reverse` +
          `?lat=${latitude}` +
          `&lon=${longitude}` +
          `&format=jsonv2`;

        const response = await axios.get(url, {
          headers: {
            "User-Agent": "MoveGui/1.0",
          },
        });

        const data = response.data;

        if (!data || !data.display_name) {
          return res.status(404).json({
            error: "Address not found",
          });
        }

        return res.status(200).json({
          address: data.display_name,
          latitude,
          longitude,
        });
      } catch (error) {
        console.error(error);

        return res.status(500).json({
          error: error.message,
        });
      }
    });
  }
);



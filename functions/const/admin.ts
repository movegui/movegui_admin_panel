const { getFirestore, Firestore, FieldValue } = require("firebase-admin/firestore");
export const db = getFirestore();
import { onDocumentCreated, onDocumentWritten, onDocumentUpdated } from "firebase-functions/firestore";


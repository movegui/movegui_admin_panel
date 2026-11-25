import { getFirestore } from "firebase-admin/firestore";
import { onDocumentWritten } from "firebase-functions/v2/firestore";
import { EstablishmentType } from "../models/establishment_discovery.model";
import { toEstablishmentDiscovery } from "../mapper/establishment.mapper";
const db = getFirestore();


export function createEstablishmentDiscoverySync(
  establishmentTypeModel: EstablishmentType,
) {
  return onDocumentWritten(
    `${establishmentTypeModel.collectionName}/{establishmentId}`,
    async (event) => {
      const establishmentId = event.params.establishmentId;

      const after = event.data?.after;

      // ID unique dans establishment_discovery
      const discoveryId =
        `${establishmentTypeModel.id}_${establishmentId}`;

      const discoveryRef = db
        .collection("establishment_dicovery_collection")
        .doc(discoveryId);

      // --------------------------------
      // DELETE
      // --------------------------------

      if (!after?.exists) {
        await discoveryRef.delete();

        console.log(
          `Discovery deleted: ${discoveryId}`,
        );

        return;
      }

      // --------------------------------
      // CREATE / UPDATE
      // --------------------------------

      const data = after.data();

      if (!data) {
        return;
      }

      const discovery = toEstablishmentDiscovery(
        discoveryId,
        establishmentId,
        establishmentTypeModel,
        data,
      );

      await discoveryRef.set(discovery);

      console.log(
        `Discovery synchronized: ${discoveryId}`,
      );
    },
  );
}
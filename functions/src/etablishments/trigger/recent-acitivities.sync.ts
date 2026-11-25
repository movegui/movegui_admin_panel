

import { onDocumentWritten } from "firebase-functions/firestore";
import { EstablishmentType } from "../models/establishment_discovery.model";
import {
  ActivityType,
  RecentActivitiesModel
} from "../models/recent-activities.model";
import { COLLECTION_RECENTE_CTIVITES } from "../../../const/establishment-type";
import { db } from "../../../const/admin";

export function recentActivitySync(
  establishmentType: EstablishmentType,
  activityType: ActivityType
) {
  return onDocumentWritten(
    {
      document: `${establishmentType.collectionName}/{establishmentId}`,
    },
    async (event) => {

      const establishmentId = event.params.establishmentId;
      const establishment = event.data?.after.data();

      // DELETE
      if (!establishment) {
        console.log(
          `Establishment deleted: ${establishmentType.id}/${establishmentId}`
        );
        return;
      }

      const activityId =
        `${establishmentType.id}_${activityType.name}_${establishmentId}`;

      const recentActivity: RecentActivitiesModel = {
        id: activityId,

        establishmentId,

        establishmentType,
        establishmentCategory:
          establishment.establishmentCategory,

        activityType,

        name:
          `${establishmentType.id}_${activityType.name}`,

        title:
          activityType.titleKey,

        description:
          activityType.descriptionKey,

        createdAt: new Date(),

        isActive:
          establishment.isActive ?? false,

        iconName:
          establishment.iconName ?? null,

        colorValue:
          establishment.colorValue ?? null,
      };

      await db
        .collection(COLLECTION_RECENTE_CTIVITES)
        .doc(activityId)
        .set(recentActivity);
    }
  );
}


/*
import { onDocumentWritten } from "firebase-functions/firestore";
import { EstablishmentType } from "../models/establishment_discovery.model";
import { ActivityType, RecentActivitiesModel } from "../models/recent-activities.model";
import { COLLECTION_RECENTE_CTIVITES } from "../../../const/establishment-type";
import { db } from "../../../const/admin";



export function recentActivitySync(establishmentType: EstablishmentType, activityType: ActivityType) {

  return onDocumentWritten({
    document: `${establishmentType.collectionName}/{establishmentId}`,
  }, async (event) => {

    const establishment = event.data?.after.data();

    if (!establishment) {
      console.log('No Document found');
      return;
    }

    const establishmentId = event.params.establishmentId ?? establishment.id ?? event.data?.after.id;
    const activityId = `${establishmentType.id}_${activityType.name}_${establishmentId}`;

    const recentActivity: RecentActivitiesModel = {
      establishmentType: establishmentType,
      activityType: activityType,
      establishmentCategory: establishment.establishmentCategory,
      title: activityType.titleKey,
      establishmentId: establishmentId,
      id: activityId,
      name: `${establishmentType.id}_${activityType.name}`,
      createdAt: new Date(),
      description: activityType.descriptionKey,
      isActive: establishment.isActive ?? false,
      iconName: establishment.iconName ?? null,
      colorValue: establishment.colorValue ?? null
    }

    await db.collection(COLLECTION_RECENTE_CTIVITES).doc(activityId).set(recentActivity)

  });

}
*/
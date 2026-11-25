import { EstablishmentType } from "../src/etablishments/models/establishment_discovery.model";
import { ActivityType } from "../src/etablishments/models/recent-activities.model";

export const PRESSING: EstablishmentType = {
  id: "laundry",
  nameKey: "module_pressing_name",
  collectionName: "pressings_collection",
};

export const RESTAURANT: EstablishmentType = {
  id: "restaurant",
  nameKey: "module_restaurant_name",
  collectionName: "restaurants_collection",
};

  export const ESTABLISHMENT_CREATED: ActivityType = {
    id: "establishment_created",
    name: "created",
     titleKey: 'recent_activity_title',
    descriptionKey: "recent_activity_description",
  };

  export const ESTABLISHMENT_UPDATED: ActivityType = {
    id: 'establishment_updated',
    name: 'updated',
    titleKey: 'recent_activity_title',
    descriptionKey: 'recent_activity_description',
  };

export const COLLECTION_RECENTE_CTIVITES = 'activity_logs';
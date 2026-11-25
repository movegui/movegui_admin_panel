import { AdressModel } from "./adress.model";
import { Model } from "./model";
import { OpenHoursModel } from "./open_hours.model";

export interface EstablishmentDiscoveryModel extends Model{
    establishmentId: string;
    establishmentType: EstablishmentType;
    address: AdressModel;
    imageUrl: string;
    rating: number;
    establishmentCategory: EstablishmentCategory;
    weeklyHours: OpenHoursModel[];
}


export interface EstablishmentType {
  id: string;
  nameKey: string;
  collectionName: string;
}

export interface EstablishmentCategory {
  id: string;
  name: string;
  establishmentType: EstablishmentType,
}




/*

models/
├── address.model.ts
├── open-hours.model.ts
├── establishment-type.model.ts
└── establishment-discovery.model.ts

discovery/
├── establishment-discovery.mapper.ts
└── establishment-discovery.sync.ts

triggers/
├── pressing.trigger.ts
├── pharmacy.trigger.ts
├── restaurant.trigger.ts
└── supermarket.trigger.ts
*/
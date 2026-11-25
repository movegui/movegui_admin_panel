import { AdressModel } from "./adress.model";
import { EstablishmentCategory, EstablishmentType } from "./establishment_discovery.model";
import { Model } from "./model";

export interface RecentActivitiesModel extends Model {
    establishmentType: EstablishmentType;
    activityType: ActivityType;
    establishmentCategory: EstablishmentCategory;
    title: string;
    establishmentId: string;
}


export interface ActivityType {
    id: string;
    name: string;
    titleKey: string;
    descriptionKey: string;
}

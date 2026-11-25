import { Model } from "./model";

export interface AdressModel extends Model {
    geoCordinates: GeoCordinatesModel;
    zoneId: string
    address: string;
    district: string;
    minucipality: string;
    dressType: AdressType;
    zipCode: string;
    ville: string;
    pays: string;
    houseNumber: number;
    appartementNumber: number;
    floor: number;
    isDefault: boolean;
};


interface GeoCordinatesModel {
    longitude: number;
    latitude: number;
}

enum AdressType {
    HOME = 'h',
    OFFICE = 'o',
    NEIGHBOR = 'n',
    OTHER = 'ot',
}

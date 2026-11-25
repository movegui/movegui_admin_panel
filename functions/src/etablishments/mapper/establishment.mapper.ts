import { EstablishmentDiscoveryModel, EstablishmentTypeModel } from "../models/establishment_discovery.model";

export function toEstablishmentDiscovery(
  id: string,
  establishmentId: string,
  establishmentType: EstablishmentTypeModel,
  data: FirebaseFirestore.DocumentData,
): EstablishmentDiscoveryModel {

  return {
    id: id,
    establishmentId: establishmentId,
    name: data.name,
    createdAt: data.createdAt,
    description: data.description,
    isActive: data.isActive  === true,
    iconName: data.iconName,
    colorValue: data.colorValue,
    establishmentType: establishmentType,
    address: data.address,
    imageUrl: data.imageUrl ?? null,
    rating: Number(data.rating ?? 0),
    weeklyHours: data.weeklyHours
};
}
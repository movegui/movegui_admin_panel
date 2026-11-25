export interface OpenHoursModel {
    day: string
    isOpen: boolean;
    slots: OpeningTimeSlot[];

}

interface OpeningTimeSlot {
    openingTime: string;
    closingTime: string;
}


extension String {
    static func localizedNavTitle(resourceID: String.LocalizationValue) -> String {
        return String(localized: resourceID, table: "Navigation")
    }
    
    static func localizedShuttleItem(resourceID: String.LocalizationValue) -> String {
        return String(localized: resourceID, table: "Shuttle")
    }
    
    static func localizedItem(resourceID: String.LocalizationValue) -> String {
        return String(localized: resourceID, table: "Localizable")
    }
    
    static func localizedBusItem(resourceID: String.LocalizationValue) -> String {
        return String(localized: resourceID, table: "Bus")
    }
    
    static func localizedSubwayItem(resourceID: String.LocalizationValue) -> String {
        return String(localized: resourceID, table: "Subway")
    }
    
    static func localizedCafeteriaItem(resourceID: String.LocalizationValue, arguments: CVarArg...) -> String {
        return String(localized: resourceID, table: "Cafeteria")
    }
    
    static func localizedReadingRoomItem(resourceID: String.LocalizationValue) -> String {
        return String(localized: resourceID, table: "ReadingRoom")
    }
}

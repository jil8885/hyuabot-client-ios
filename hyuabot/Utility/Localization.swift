extension String {
    static func localizedNavTitle(resourceID: String.LocalizationValue) -> String {
        return String(localized: resourceID, table: "Navigation")
    }
}

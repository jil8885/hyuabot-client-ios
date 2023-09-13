import UIKit

extension UIFont {
    static func poppins(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "Poppins"
        var weightString: String

        switch weight {
            case .black: weightString = "Black"
            case .bold: weightString = "Bold"
            case .heavy: weightString = "ExtraBold"
            case .ultraLight: weightString = "ExtraLight"
            case .light: weightString = "Light"
            case .medium: weightString = "Medium"
            case .regular: weightString = "Regular"
            case .semibold: weightString = "SemiBold"
            case .thin: weightString = "Thin"
            default: weightString = "Regular"
        }
        return UIFont(name: "\(familyName)-\(weightString)", size: size) ?? UIFont.godo(size: size, weight: weight)
    }
    
    static func godo(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let familyName = "Godo"
        var weightString: String
        switch weight {
            case .regular: weightString = "M"
            case .bold: weightString = "B"
            default: weightString = "M"
        }
        return UIFont(name: "\(familyName)\(weightString)", size: size) ?? UIFont.godo(size: size, weight: weight)
    }

    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        UIFont.godo(size: size, weight: .regular)
    }

    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        UIFont.godo(size: size, weight: .bold)
    }

    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        UIFont.godo(size: size, weight: .regular)
    }

    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String
        else {
            self.init(myCoder: aDecoder)
            return
        }

        var fontName = ""
        switch fontAttribute {
            case "CTFontRegularUsage":
                fontName = "GodoM"
            case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                fontName = "GodoB"
            case "CTFontObliqueUsage":
                fontName = "GodoM"
            default:
                fontName = "GodoM"
        }

        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }

    class func overrideInitialize() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)

            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)

            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod!, myItalicSystemFontMethod!)

            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:)))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
        }
    }
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let tabVC = TabBarViewController()

        window?.rootViewController = tabVC
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
        
        let theme = UserDefaults.standard.string(forKey: "theme") ?? "system"
        if theme == "dark" {
            window?.overrideUserInterfaceStyle = .dark
        } else if theme == "light" {
            window?.overrideUserInterfaceStyle = .light
        } else if theme == "system" {
            window?.overrideUserInterfaceStyle = .unspecified
        }
    }
}

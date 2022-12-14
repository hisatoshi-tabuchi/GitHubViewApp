//
//  AppDelegate.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/05.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var config = Realm.Configuration()
        config.migrationBlock = { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
//                migration.enumerateObjects(ofType: User.className()) { (oldObject, newObject) in
//                    let firstName = oldObject!["firstName"] as! String
//                    let lastName = oldObject!["lastName"] as! String
//                    newObject!["fullName"] = firstName + lastName
//                }
//
//                let realm = try! Realm()
//
//                try! realm.write {
//                  realm.deleteAll()
//                }
                
            }
        }

        config.schemaVersion = 1
        Realm.Configuration.defaultConfiguration = config

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


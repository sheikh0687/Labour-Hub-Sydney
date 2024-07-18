//
//  WelcomeVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 18/03/23.
//

import UIKit

struct AppStoreResponse: Codable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let releaseNotes: String
    let releaseDate: String
    let version: String
}

private extension Bundle {
    var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }
}

struct AppStoreUpdateChecker {
    static func isNewVersionAvailable() async -> Bool {
        guard let bundleID = Bundle.main.bundleIdentifier,
                let currentVersionNumber = Bundle.main.releaseVersionNumber,
                let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(bundleID)") else {
            // Invalid inputs
            return false
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let appStoreResponse = try JSONDecoder().decode(AppStoreResponse.self, from: data)

            guard let latestVersionNumber = appStoreResponse.results.first?.version else {
                // No app with matching bundleID found
                return false
            }

            return currentVersionNumber != latestVersionNumber
        }
        catch {
            // TODO: Handle error
            print(error)
            return false
        }
    }
}

// Usage:


class WelcomeVC: UIViewController {

    let currentAppVersion = "1.7"
       
       // Replace this with the App Store URL of your app
    let appStoreURL = "https://appstoreconnect.apple.com/apps/6449774743/appstore/info"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func checkForAppUpdate() {
           // Get the latest version from the App Store
           getVersionFromAppStore { latestVersion in
               // Compare the current app version with the latest version
               if self.isUpdateAvailable(latestVersion: latestVersion) {
                   // If there's an update available, display an alert
                   self.alert(alertmessage: "A new version of the app is available. Please update to the latest version from app store!")
               }
           }
       }

    func getVersionFromAppStore(completion: @escaping (String) -> Void) {
        let appLookupURL = "https://appstoreconnect.apple.com/lookup?bundleId=jf.Labour-Hub-Sydeny"

        URLSession.shared.dataTask(with: URL(string: appLookupURL)!) { data, _, error in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let results = json["results"] as? [[String: Any]],
               let version = results.first?["version"] as? String {
                print(version)
                completion(version)
            } else {
                completion("")
            }
        }.resume()
    }

       func isUpdateAvailable(latestVersion: String) -> Bool {
           return latestVersion.compare(currentAppVersion, options: .numeric) == .orderedDescending
       }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSignUpVC(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpTypeVC") as! SignUpTypeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

enum VersionError: Error {
    case invalidBundleInfo
    case invalidResponse
    case versionUnavailable
}

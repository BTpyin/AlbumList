//
//  Constant.swift
//  AlbumList
//
//  Created by Bowie Tso on 30/3/2023.
//

import Foundation
import SwiftyUserDefaults
import Rswift

var BASE_URL: URL {
    let url = "https://itunes.apple.com"
    return url.url!
}

extension StringResource {
    public func string(_ language: String = "") -> String {
        guard let basePath = bundle.path(forResource: "Base", ofType: "lproj"), let baseBundle = Bundle(path: basePath) else {
            return self.key
        }
        
        let fallback = baseBundle.localizedString(forKey: key, value: key, table: tableName)
        guard let localizedPath = bundle.path(forResource: currentLanguageIdentifier, ofType: "lproj"),
              let localizedBundle = Bundle(path: localizedPath)
        else {
            return fallback
        }
        return localizedBundle.localizedString(forKey: key, value: fallback, table: tableName)
    }
}

extension String {
    public func string(_ language: String = "") -> String {
        guard let basePath = Bundle.main.path(forResource: "Base", ofType: "lproj"), let baseBundle = Bundle(path: basePath) else {
            return self
        }
        
        let fallback = baseBundle.localizedString(forKey: self, value: self, table: nil)
        
        guard let localizedPath = Bundle.main.path(forResource: currentLanguageIdentifier, ofType: "lproj"),
              let localizedBundle = Bundle(path: localizedPath)
        else {
            return fallback
        }
        
        return localizedBundle.localizedString(forKey: self, value: fallback, table: nil)
    }
}

typealias localized = R.string.localizable

var isLanguageEN: Bool {
    get {
        return Defaults[\.LANGUAGE] ==  "en"
    }
}

var currentLanguageIdentifier: String {
    get {
        if Defaults[\.LANGUAGE].isNilOrEmpty {
            return Locale.current.identifier
        }
        return Defaults[\.LANGUAGE] == "en" ? "en" : "zh-Hant"
    }
}

var preferredLanguages: [String] {
    get {
        return isLanguageEN ? ["en"] : ["zh-HK", "zh-Hant"]
    }
}

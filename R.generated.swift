//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 4 storyboards.
  struct storyboard {
    /// Storyboard `Home`.
    static let home = _R.storyboard.home()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    /// Storyboard `Setting`.
    static let setting = _R.storyboard.setting()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Home", bundle: ...)`
    static func home(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.home)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Setting", bundle: ...)`
    static func setting(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.setting)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 3 images.
  struct image {
    /// Image `arrow_right`.
    static let arrow_right = Rswift.ImageResource(bundle: R.hostingBundle, name: "arrow_right")
    /// Image `back`.
    static let back = Rswift.ImageResource(bundle: R.hostingBundle, name: "back")
    /// Image `more`.
    static let more = Rswift.ImageResource(bundle: R.hostingBundle, name: "more")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "arrow_right", bundle: ..., traitCollection: ...)`
    static func arrow_right(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.arrow_right, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "back", bundle: ..., traitCollection: ...)`
    static func back(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.back, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "more", bundle: ..., traitCollection: ...)`
    static func more(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.more, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"
            static let uiSceneStoryboardFile = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneStoryboardFile") ?? "Main"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 4 nibs.
  struct nib {
    /// Nib `AlbumCollectionViewCell`.
    static let albumCollectionViewCell = _R.nib._AlbumCollectionViewCell()
    /// Nib `FavouriteListTableViewCell`.
    static let favouriteListTableViewCell = _R.nib._FavouriteListTableViewCell()
    /// Nib `SettingTableViewCell`.
    static let settingTableViewCell = _R.nib._SettingTableViewCell()
    /// Nib `SettingTableViewMyFavouriteCell`.
    static let settingTableViewMyFavouriteCell = _R.nib._SettingTableViewMyFavouriteCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "AlbumCollectionViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.albumCollectionViewCell) instead")
    static func albumCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.albumCollectionViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "FavouriteListTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.favouriteListTableViewCell) instead")
    static func favouriteListTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.favouriteListTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SettingTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.settingTableViewCell) instead")
    static func settingTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.settingTableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "SettingTableViewMyFavouriteCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.settingTableViewMyFavouriteCell) instead")
    static func settingTableViewMyFavouriteCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.settingTableViewMyFavouriteCell)
    }
    #endif

    static func albumCollectionViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> AlbumCollectionViewCell? {
      return R.nib.albumCollectionViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? AlbumCollectionViewCell
    }

    static func favouriteListTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> FavouriteListTableViewCell? {
      return R.nib.favouriteListTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? FavouriteListTableViewCell
    }

    static func settingTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SettingTableViewCell? {
      return R.nib.settingTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SettingTableViewCell
    }

    static func settingTableViewMyFavouriteCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SettingTableViewMyFavouriteCell? {
      return R.nib.settingTableViewMyFavouriteCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SettingTableViewMyFavouriteCell
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 3 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `AlbumCollectionViewCell`.
    static let albumCollectionViewCell: Rswift.ReuseIdentifier<AlbumCollectionViewCell> = Rswift.ReuseIdentifier(identifier: "AlbumCollectionViewCell")
    /// Reuse identifier `FavouriteListTableViewCell`.
    static let favouriteListTableViewCell: Rswift.ReuseIdentifier<FavouriteListTableViewCell> = Rswift.ReuseIdentifier(identifier: "FavouriteListTableViewCell")
    /// Reuse identifier `SettingTableViewCell`.
    static let settingTableViewCell: Rswift.ReuseIdentifier<SettingTableViewCell> = Rswift.ReuseIdentifier(identifier: "SettingTableViewCell")

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 3 localization tables.
  struct string {
    /// This `R.string.launchScreen` struct is generated, and contains static references to 0 localization keys.
    struct launchScreen {
      fileprivate init() {}
    }

    /// This `R.string.localizable` struct is generated, and contains static references to 14 localization keys.
    struct localizable {
      /// en translation: Cancel
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let cancel = Rswift.StringResource(key: "cancel", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: Choose Language
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let setting_choose_language = Rswift.StringResource(key: "setting_choose_language", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: Country
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let album_detail_country = Rswift.StringResource(key: "album_detail_country", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: Favourite Album
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let favourite_album_title = Rswift.StringResource(key: "favourite_album_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: Home
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let bottom_tab_bar_home = Rswift.StringResource(key: "bottom_tab_bar_home", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: Language
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let setting_language = Rswift.StringResource(key: "setting_language", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: No. Of Track
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let album_detail_no_of_tracks = Rswift.StringResource(key: "album_detail_no_of_tracks", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: Price
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let album_detail_price = Rswift.StringResource(key: "album_detail_price", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: Primary Genre
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let album_detail_primary_genre = Rswift.StringResource(key: "album_detail_primary_genre", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: Released on
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let album_detail_released_on = Rswift.StringResource(key: "album_detail_released_on", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: Remove album
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let favourite_album_title_remove = Rswift.StringResource(key: "favourite_album_title_remove", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: Setting
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let bottom_tab_bar_setting = Rswift.StringResource(key: "bottom_tab_bar_setting", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: Show Album On Apple Music
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let album_detail_show_album_on_apple_music = Rswift.StringResource(key: "album_detail_show_album_on_apple_music", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)
      /// en translation: Show Artist On Apple Music
      ///
      /// Locales: zh-HK, zh-Hant, en
      static let album_detail_show_artist_on_apple_music = Rswift.StringResource(key: "album_detail_show_artist_on_apple_music", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant", "en"], comment: nil)

      /// en translation: Cancel
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func cancel(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("cancel", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "cancel"
        }

        return NSLocalizedString("cancel", bundle: bundle, comment: "")
      }

      /// en translation: Choose Language
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func setting_choose_language(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("setting_choose_language", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "setting_choose_language"
        }

        return NSLocalizedString("setting_choose_language", bundle: bundle, comment: "")
      }

      /// en translation: Country
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func album_detail_country(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("album_detail_country", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "album_detail_country"
        }

        return NSLocalizedString("album_detail_country", bundle: bundle, comment: "")
      }

      /// en translation: Favourite Album
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func favourite_album_title(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("favourite_album_title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "favourite_album_title"
        }

        return NSLocalizedString("favourite_album_title", bundle: bundle, comment: "")
      }

      /// en translation: Home
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func bottom_tab_bar_home(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("bottom_tab_bar_home", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "bottom_tab_bar_home"
        }

        return NSLocalizedString("bottom_tab_bar_home", bundle: bundle, comment: "")
      }

      /// en translation: Language
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func setting_language(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("setting_language", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "setting_language"
        }

        return NSLocalizedString("setting_language", bundle: bundle, comment: "")
      }

      /// en translation: No. Of Track
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func album_detail_no_of_tracks(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("album_detail_no_of_tracks", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "album_detail_no_of_tracks"
        }

        return NSLocalizedString("album_detail_no_of_tracks", bundle: bundle, comment: "")
      }

      /// en translation: Price
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func album_detail_price(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("album_detail_price", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "album_detail_price"
        }

        return NSLocalizedString("album_detail_price", bundle: bundle, comment: "")
      }

      /// en translation: Primary Genre
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func album_detail_primary_genre(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("album_detail_primary_genre", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "album_detail_primary_genre"
        }

        return NSLocalizedString("album_detail_primary_genre", bundle: bundle, comment: "")
      }

      /// en translation: Released on
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func album_detail_released_on(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("album_detail_released_on", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "album_detail_released_on"
        }

        return NSLocalizedString("album_detail_released_on", bundle: bundle, comment: "")
      }

      /// en translation: Remove album
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func favourite_album_title_remove(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("favourite_album_title_remove", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "favourite_album_title_remove"
        }

        return NSLocalizedString("favourite_album_title_remove", bundle: bundle, comment: "")
      }

      /// en translation: Setting
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func bottom_tab_bar_setting(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("bottom_tab_bar_setting", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "bottom_tab_bar_setting"
        }

        return NSLocalizedString("bottom_tab_bar_setting", bundle: bundle, comment: "")
      }

      /// en translation: Show Album On Apple Music
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func album_detail_show_album_on_apple_music(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("album_detail_show_album_on_apple_music", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "album_detail_show_album_on_apple_music"
        }

        return NSLocalizedString("album_detail_show_album_on_apple_music", bundle: bundle, comment: "")
      }

      /// en translation: Show Artist On Apple Music
      ///
      /// Locales: zh-HK, zh-Hant, en
      static func album_detail_show_artist_on_apple_music(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("album_detail_show_artist_on_apple_music", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "album_detail_show_artist_on_apple_music"
        }

        return NSLocalizedString("album_detail_show_artist_on_apple_music", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    /// This `R.string.main` struct is generated, and contains static references to 2 localization keys.
    struct main {
      /// zh-HK translation: Item
      ///
      /// Locales: zh-HK, zh-Hant
      static let eEdMaNf9Title = Rswift.StringResource(key: "eEd-ma-Nf9.title", tableName: "Main", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant"], comment: nil)
      /// zh-HK translation: Item
      ///
      /// Locales: zh-HK, zh-Hant
      static let m1pGgIOvTitle = Rswift.StringResource(key: "m1p-gg-IOv.title", tableName: "Main", bundle: R.hostingBundle, locales: ["zh-HK", "zh-Hant"], comment: nil)

      /// zh-HK translation: Item
      ///
      /// Locales: zh-HK, zh-Hant
      static func eEdMaNf9Title(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("eEd-ma-Nf9.title", tableName: "Main", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Main", preferredLanguages: preferredLanguages) else {
          return "eEd-ma-Nf9.title"
        }

        return NSLocalizedString("eEd-ma-Nf9.title", tableName: "Main", bundle: bundle, comment: "")
      }

      /// zh-HK translation: Item
      ///
      /// Locales: zh-HK, zh-Hant
      static func m1pGgIOvTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("m1p-gg-IOv.title", tableName: "Main", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Main", preferredLanguages: preferredLanguages) else {
          return "m1p-gg-IOv.title"
        }

        return NSLocalizedString("m1p-gg-IOv.title", tableName: "Main", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try nib.validate()
    #endif
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _AlbumCollectionViewCell.validate()
      try _FavouriteListTableViewCell.validate()
      try _SettingTableViewCell.validate()
    }

    struct _AlbumCollectionViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = AlbumCollectionViewCell

      let bundle = R.hostingBundle
      let identifier = "AlbumCollectionViewCell"
      let name = "AlbumCollectionViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> AlbumCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? AlbumCollectionViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "heart", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'heart' is used in nib 'AlbumCollectionViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    struct _FavouriteListTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = FavouriteListTableViewCell

      let bundle = R.hostingBundle
      let identifier = "FavouriteListTableViewCell"
      let name = "FavouriteListTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> FavouriteListTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? FavouriteListTableViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "more", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'more' is used in nib 'FavouriteListTableViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    struct _SettingTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = SettingTableViewCell

      let bundle = R.hostingBundle
      let identifier = "SettingTableViewCell"
      let name = "SettingTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SettingTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SettingTableViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "arrow_right", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'arrow_right' is used in nib 'SettingTableViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    struct _SettingTableViewMyFavouriteCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "SettingTableViewMyFavouriteCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SettingTableViewMyFavouriteCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SettingTableViewMyFavouriteCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try home.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try setting.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct home: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let albumDetailViewController = StoryboardViewControllerResource<AlbumDetailViewController>(identifier: "AlbumDetailViewController")
      let bundle = R.hostingBundle
      let favouriteListViewController = StoryboardViewControllerResource<FavouriteListViewController>(identifier: "FavouriteListViewController")
      let homeViewController = StoryboardViewControllerResource<HomeViewController>(identifier: "HomeViewController")
      let name = "Home"

      func albumDetailViewController(_: Void = ()) -> AlbumDetailViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: albumDetailViewController)
      }

      func favouriteListViewController(_: Void = ()) -> FavouriteListViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: favouriteListViewController)
      }

      func homeViewController(_: Void = ()) -> HomeViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: homeViewController)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "house", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'house' is used in storyboard 'Home', but couldn't be loaded.") }
        if UIKit.UIImage(named: "house.fill", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'house.fill' is used in storyboard 'Home', but couldn't be loaded.") }
        if UIKit.UIImage(named: "magnifyingglass.circle.fill", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'magnifyingglass.circle.fill' is used in storyboard 'Home', but couldn't be loaded.") }
        if UIKit.UIImage(named: "suit.heart", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'suit.heart' is used in storyboard 'Home', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.home().albumDetailViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'albumDetailViewController' could not be loaded from storyboard 'Home' as 'AlbumDetailViewController'.") }
        if _R.storyboard.home().favouriteListViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'favouriteListViewController' could not be loaded from storyboard 'Home' as 'FavouriteListViewController'.") }
        if _R.storyboard.home().homeViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'homeViewController' could not be loaded from storyboard 'Home' as 'HomeViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let name = "Main"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct setting: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let name = "Setting"
      let settingViewController = StoryboardViewControllerResource<SettingViewController>(identifier: "SettingViewController")

      func settingViewController(_: Void = ()) -> SettingViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: settingViewController)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "gearshape", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'gearshape' is used in storyboard 'Setting', but couldn't be loaded.") }
        if UIKit.UIImage(named: "gearshape.fill", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'gearshape.fill' is used in storyboard 'Setting', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.setting().settingViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'settingViewController' could not be loaded from storyboard 'Setting' as 'SettingViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}

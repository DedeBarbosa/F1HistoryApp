//
//  NetworkingExtensions.swift
//  F1HistoryApp
//
//  Created by Dmitry Pavlov on 09.07.2021.
//

import Foundation
import Networking

struct CountryCodes {
    static let countryFlags = [
        "American": "🇺🇸", "USA": "🇺🇸", "United States": "🇺🇸",
        "russia": "🇷🇺", "Russia": "🇷🇺", "Russian": "🇷🇺",
        "italy": "🇮🇹", "Italy": "🇮🇹", "Italian": "🇮🇹",
        "united kingdom": "🇬🇧", "United Kingdom": "🇬🇧", "uk": "🇬🇧", "UK": "🇬🇧", "england": "🇬🇧", "England": "🇬🇧", "British": "🇬🇧",
        "canada": "🇨🇦", "Canada": "🇨🇦", "Canadian": "🇨🇦",
        "japan": "🇯🇵", "Japan": "🇯🇵", "Japanese": "🇯🇵",
        "germany": "🇩🇪", "Germany": "🇩🇪", "German": "🇩🇪",
        "israel": "🇮🇱", "Israel": "🇮🇱",
        "france": "🇫🇷", "France": "🇫🇷",
        "netherlands": "🇳🇱", "Netherlands": "🇳🇱", "the netherlands": "🇳🇱", "The Netherlands": "🇳🇱",
        "belgium": "🇧🇪", "Belgium": "🇧🇪",
        "denmark": "🇩🇰", "Denmark": "🇩🇰",
        "norway": "🇳🇴", "Norway": "🇳🇴",
        "china": "🇨🇳", "China": "🇨🇳", "CHINA": "🇨🇳", "PRC": "🇨🇳", "prc": "🇨🇳",
        "spain": "🇪🇸", "Spain": "🇪🇸",
        "india": "🇮🇳", "India": "🇮🇳",
        "brazil": "🇧🇷", "Brazil": "🇧🇷",
        "sweden": "🇸🇪", "Sweden": "🇸🇪",
        "greece": "🇬🇷", "Greece": "🇬🇷",
        "estonia": "🇪🇪", "Estonia": "🇪🇪",
        "austria": "🇦🇹", "Austria": "🇦🇹",
        "czech republic": "🇨🇿", "Czech Republic": "🇨🇿", "czech": "🇨🇿", "Czech": "🇨🇿",
        "switzerland": "🇨🇭", "Switzerland": "🇨🇭", "switz": "🇨🇭", "Switz": "🇨🇭",
        "finland": "🇫🇮", "Finland": "🇫🇮",
        "hungary": "🇭🇺", "Hungary": "🇭🇺",
        "poland": "🇵🇱", "Poland": "🇵🇱",
        "luxembourg": "🇱🇺", "Luxembourg": "🇱🇺",
        "romainia": "🇷🇴", "Romainia": "🇷🇴",
        "portugal": "🇵🇹", "Portugal": "🇵🇹",
        "ireland": "🇮🇪", "Ireland": "🇮🇪",
        "UAE": "🇦🇪", "uae": "🇦🇪", "U.A.E.": "🇦🇪", "United Arab Emirates": "🇦🇪", "united arab emirates": "🇦🇪"]
}

extension Driver {
    var driverName: String {
        "\(familyName ?? "")\(familyName != nil ? " " : "")\(givenName ?? "")"
    }

    func emojiNationalityFlag() -> String? {
        guard
            let nationality = nationality,
            let flag = CountryCodes.countryFlags[nationality]
        else { return nil }
            return flag
    }

    
}

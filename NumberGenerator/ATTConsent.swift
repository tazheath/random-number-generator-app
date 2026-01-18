//
//  ATTConsent.swift
//  Random Num.
//
//  Created by Taz Heath on 1/16/26.
//

import Foundation
import AppTrackingTransparency
import AdSupport
import GoogleMobileAds

enum ATTAuthorization {
    static func requestIfNeeded() {

        if ATTrackingManager.trackingAuthorizationStatus != .notDetermined {
            MobileAds.shared.start()
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ATTrackingManager.requestTrackingAuthorization { _ in
                DispatchQueue.main.async {
                    MobileAds.shared.start()
                }
            }
        }
    }
}

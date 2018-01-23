//
//  AppleLocationService.swift
//  UsingPods
//
//  Created by Alex Paul on 1/22/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import Foundation
import CoreLocation

protocol AppleLocationServiceDelegate: class {
    func appleLocationService(_ appleLocationService: AppleLocationService, didReceiveCoordinates coordinate: CLLocationCoordinate2D)
}

class AppleLocationService {
    
    private var geocoder: CLGeocoder!
    
    weak var delegate: AppleLocationServiceDelegate?
    
    init() {
        geocoder = CLGeocoder()
    }
    
    public func geocodeAddress(address: String) {
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                print(error)
            } else if let placemarks = placemarks {
                print(placemarks)
                guard let coordinate = placemarks.first?.location?.coordinate else { print("placemarks is nil"); return }
                self.delegate?.appleLocationService(self, didReceiveCoordinates: coordinate)
            }
        }
    }
    
    public func reverseGeocodeAddress(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print(error)
            } else if let placemarks = placemarks {
                print(placemarks)
            }
        }
    }
}

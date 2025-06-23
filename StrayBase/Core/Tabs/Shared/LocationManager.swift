//
//  LocationManager.swift
//  StrayBase
//
//  Created by Nino Nozadze on 23.06.25.
//

import SwiftUI
import MapKit

enum MapDetails {
    // გმირთა მოედანი ავიღე default მნიშვნელობად
    static let startingLocation = CLLocationCoordinate2D(
        latitude: 41.7132045,
        longitude: 44.7824601
    )
    static let defaultSpan = MKCoordinateSpan(
        latitudeDelta: 0.5,
        longitudeDelta: 0.5
    )
}


class LocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var region = MKCoordinateRegion(
        center: MapDetails.startingLocation,
        span: MapDetails.defaultSpan
    )

    private var locationManager: CLLocationManager?

    func setupLocationManager() {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest

        let status = manager.authorizationStatus
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        }

        self.locationManager = manager
    }

    private func updateRegionIfPossible() {
        guard let location = locationManager?.location else { return }
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MapDetails.defaultSpan
            )
        }
    }

    private func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager?.startUpdatingLocation()
            updateRegionIfPossible()
        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorizationStatus(manager.authorizationStatus)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: newLocation.coordinate,
                span: MapDetails.defaultSpan
            )
        }
    }
}


//
//  ContentViewModel.swift
//  UserLocation
//
//  Created by Bekir Berke Yılmaz on 3.11.2023.
//

import Foundation
import MapKit
final class ContentViewModel:NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.015137, longitude: 28.979530), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    var locationManager: CLLocationManager?
    
    func checkIfLocationServiceIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            checkLocationAuthorization()
            locationManager?.delegate = self
        }else{
            print("No Perm")
        }
    }
    
    private func checkLocationAuthorization(){
        guard let locationManager = locationManager else {return}
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

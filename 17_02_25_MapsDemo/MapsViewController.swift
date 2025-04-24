//
//  MapsViewController.swift
//  17_02_25_MapsDemo
//
//  Created by Vishal Jagtap on 22/04/25.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController {
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    var puneCoordinates = CLLocationCoordinate2D(
        latitude: 18.5204,
        longitude: 73.8567
    )

    var mumbaiCoorinates = CLLocationCoordinate2D(
        latitude: 19.076,
        longitude: 72.877
    )
    
    var nagpurCoorinates = CLLocationCoordinate2D(
        latitude: 21.1458,
        longitude: 79.0882
    )
    
    var mumbaiMarker : GMSMarker?
    var nagpurMarker : GMSMarker?
    var circle : GMSCircle?
    var polygon : GMSPolygon?
    var polyline : GMSPolyline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSettings()
        cameraSettings(position: puneCoordinates)
        drawCircle(centerCoordinate: puneCoordinates        )
        
        mumbaiMarker = createMarker(markerPostion: mumbaiCoorinates)
        mumbaiMarker?.map = googleMapView
        mumbaiMarker?.snippet = "Mumbai!"
        mumbaiMarker?.title = "This is Mumbai!"
//        mumbaiMarker?.icon = UIImage(named: "test_image_1")
        mumbaiMarker?.rotation = 45.0
        
        nagpurMarker = createMarker(markerPostion: nagpurCoorinates)
        nagpurMarker?.map = googleMapView
        nagpurMarker?.snippet = "Nagpur"
        nagpurMarker?.rotation = 30.0
        nagpurMarker?.title = "This is Nagpur!"
//        nagpurMarker?.icon = UIImage(named: "test_image_1")
    }
    
    func createMarker(markerPostion : CLLocationCoordinate2D) -> GMSMarker{
        return GMSMarker(position: markerPostion)
    }
    
    func cameraSettings(position : CLLocationCoordinate2D){
        var cameraPosition = GMSCameraPosition(
            latitude: position.latitude,
            longitude: position.longitude,
            zoom: 20.0
        )
        
        googleMapView.camera = cameraPosition
    }
    
    func initSettings(){
        googleMapView.delegate = self
        googleMapView.settings.compassButton = true
        googleMapView.settings.rotateGestures = true
        googleMapView.settings.scrollGestures = true
        googleMapView.settings.myLocationButton = true
        googleMapView.settings.zoomGestures = true
        googleMapView.isBuildingsEnabled = true
        googleMapView.isBuildingsEnabled = true
        googleMapView.isTrafficEnabled = true
        googleMapView.mapType = .normal
    }
    
    func drawCircle(centerCoordinate : CLLocationCoordinate2D){
        var circle = GMSCircle(
            position: centerCoordinate,
            radius: 20.0
        )
        
        circle.fillColor = .lightGray
        circle.strokeColor = .brown
        circle.strokeWidth = 5.0
        circle.title = "This is Pune!"
        circle.map = googleMapView
        circle.zIndex = 10
    }
    
    func drawPolygon(){
        
    }
    
    func drawPolyline(){
        
    }
}

extension MapsViewController : GMSMapViewDelegate{
    
    
    
}

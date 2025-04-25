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
        drawCircle(centerCoordinate: puneCoordinates)
        drawPolygon()
        drawPolyline()
        
        mumbaiMarker = createMarker(markerPostion: mumbaiCoorinates)
        mumbaiMarker?.map = googleMapView
        mumbaiMarker?.snippet = "Mumbai!"
        mumbaiMarker?.title = "This is Mumbai!"
//        mumbaiMarker?.icon = UIImage(named: "test_image_1")
        mumbaiMarker?.rotation = 45.0
        mumbaiMarker?.isDraggable = true
        
        nagpurMarker = createMarker(markerPostion: nagpurCoorinates)
        nagpurMarker?.map = googleMapView
        nagpurMarker?.snippet = "Nagpur"
        nagpurMarker?.rotation = 30.0
        nagpurMarker?.title = "This is Nagpur!"
        nagpurMarker?.isDraggable = true
//        nagpurMarker?.icon = UIImage(named: "test_image_1")
    }
    
    func createMarker(markerPostion : CLLocationCoordinate2D) -> GMSMarker{
        return GMSMarker(position: markerPostion)
    }
    
    func cameraSettings(position : CLLocationCoordinate2D){
        var cameraPosition = GMSCameraPosition(
            latitude: position.latitude,
            longitude: position.longitude,
            zoom: 5.0
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
        
        let gmsPathForPolygon = GMSMutablePath()
        gmsPathForPolygon.add(
            CLLocationCoordinate2D(
                latitude: 12.9716,
                longitude: 77.5946)
        )
        gmsPathForPolygon.add(
            CLLocationCoordinate2D(
                latitude: 17.6869,
                longitude: 83.2185)
        )
        gmsPathForPolygon.add(
            CLLocationCoordinate2D(
                latitude: 21.1458,
                longitude: 79.0882)
        )
        gmsPathForPolygon.add(
            CLLocationCoordinate2D(
                latitude: 18.5091,
                longitude: 73.8324)
        )
        
        polygon = GMSPolygon(path: gmsPathForPolygon)
        polygon?.strokeColor = .brown
        polygon?.strokeWidth = 10.0
        polygon?.fillColor = .cyan
        polygon?.map = googleMapView
    }
    
    func drawPolyline(){
        let gmsPolylinePath = GMSMutablePath()
        gmsPolylinePath.add(CLLocationCoordinate2D(latitude: 28.1732, longitude: 77.1024))
        gmsPolylinePath.add(CLLocationCoordinate2D(latitude: 26.2492, longitude: 80.3319))
        gmsPolylinePath.add(CLLocationCoordinate2D(latitude: 22.7196, longitude: 75.8500))
        gmsPolylinePath.add(CLLocationCoordinate2D(latitude: 24.5926, longitude: 72.7156))
        gmsPolylinePath.add(CLLocationCoordinate2D(latitude: 28.1732, longitude: 77.1024))

        polyline = GMSPolyline(path: gmsPolylinePath)
        
        polyline?.strokeColor = .orange
        polyline?.strokeWidth = 10.0
        polyline?.map = googleMapView
        polyline?.title = "Polyline"
        polyline?.zIndex = 15
    }
}

extension MapsViewController : GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("didTapAt method -- Latitude \(coordinate.latitude) -- Longitude \(coordinate.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        print("didTapAtMyLocation method -- Latitude \(location.latitude) -- Longitude \(location.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf method -- Latitude \(marker.position.latitude) -- Longitude \(marker.position.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let cgRectForInfoWindow = CGRect(x: 0, y: 0, width: 200, height: 100)
        
        let infoWindiwView = UIView(frame: cgRectForInfoWindow)
        infoWindiwView.backgroundColor = .cyan
        
        
        let cgRectForLabelOne = CGRect(x: 20, y: 20, width: 160, height: 30)
        
        let labelOne = UILabel(frame: cgRectForLabelOne)
        labelOne.text = "\(marker.title!)"
        
        labelOne.backgroundColor = .lightGray
        labelOne.textAlignment = .center
        
        infoWindiwView.addSubview(labelOne)
        
        let cgRectForLabelTwo = CGRect(x: 20, y: 65, width: 160, height: 30)
        
        let labelTwo = UILabel(frame: cgRectForLabelTwo)
        labelTwo.backgroundColor = .lightGray
        labelTwo.text = "\(marker.snippet!)"
        
        infoWindiwView.addSubview(labelTwo)
        
        return infoWindiwView
    }
    

    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        print("did close info window")
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("didDrag method -- Latitude \(marker.position.latitude) -- Longitude \(marker.position.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("didBeginDragging method -- Latitude \(marker.position.latitude) -- Longitude \(marker.position.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("didEndDragging method -- Latitude \(marker.position.latitude) -- Longitude \(marker.position.longitude)")
    }
}

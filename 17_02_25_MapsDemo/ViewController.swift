//
//  ViewController.swift
//  17_02_25_MapsDemo
//
//  Created by Vishal Jagtap on 22/04/25.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var appleMapView: MKMapView!
    
    var puneCoordinate = CLLocationCoordinate2D(
        latitude: 18.5204,
        longitude: 73.8567
    )

    var mkMarkerView = MKMarkerAnnotationView(
        frame: CGRect(x: 50, y: 50, width: 50, height: 50)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSettings()
    }
    
    func initSettings(){
        appleMapView.isScrollEnabled = true
        appleMapView.isZoomEnabled = true
        appleMapView.isRotateEnabled = true
        appleMapView.mapType = .standard
        appleMapView.addAnnotation(mkMarkerView as! MKAnnotation)
    }
}

extension ViewController : MKMapViewDelegate{
    
}

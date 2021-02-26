//
//  MapViewController.swift
//  pTweet
//
//  Created by Eddy Wister on 26/02/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    //mark outlets
    @IBOutlet weak var  mapContainer: UIView!
    
    var posts = [Post]()
    private var map: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpMap()

    }
    private func setUpMap(){
        map = MKMapView(frame: mapContainer.bounds)
        mapContainer.addSubview(map ?? UIView())
    }
    private func setMakers(){
        posts.forEach{item in
            let marker = MKPointAnnotation()
            marker.coordinate = CLLocationCoordinate2D(latitude: item.location.latitude, longitude: item.location.longitude)
            marker.title = item.text
            marker.subtitle = item.author.names
            map?.addAnnotation(marker)
        }
    }
}

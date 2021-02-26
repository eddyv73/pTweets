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
    
    private var posts = [Post]()
    private var map: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
        // Do any additional setup after loading the view.
    }
    
    private func setUpMap(){
        map = MKMapView(frame: mapContainer.bounds)
        mapContainer.addSubview(map ?? UIView())
    }
}

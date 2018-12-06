//
//  DonationCenterViewController.swift
//  SADJZIOS
//
//  Created by Afshawn Lotfi on 12/5/18.
//  Copyright © 2018 Afshawn Lotfi. All rights reserved.
//

import UIKit
import MapKit


class DonationCenterViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    private var region:RegionModel?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        
        
        let rest = RestInterfacer<RegionModel,String>()
        if let tokenModel = TokenInterfacer.getToken(){
            rest.getRequest(endpoint: RestEndpoints.Region, args: "atlanta", token: tokenModel.token){ response, error in
                if let region = response {
                    self.region = region;
                    DispatchQueue.main.async {
                        
                        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                        let mkregion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: region.regionCoords.latitude, longitude: region.regionCoords.longitude), span: span)
                        self.mapView.setRegion(mkregion, animated: true)
                        for(index, location) in  region.locations.enumerated(){

                            let annotation = CustomPointAnnotation()
                            annotation.subtitle = String(index);
                            annotation.coordinate = CLLocationCoordinate2DMake(location.coords.latitude, location.coords.longitude)
                            annotation.title = location.name
                            annotation.imageName = "flag.png"
                            self.mapView.addAnnotation(annotation)
                            
                        }
                    }

                } else {
                    print(error ?? "")
                }
            }
        }
        
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //do what you need here
        mapView.deselectAnnotation(view.annotation, animated: true)
        if let region = self.region{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let locationNavController = storyboard.instantiateViewController(withIdentifier: "LocationNavController") as? LocationNavController{
            
                self.present(locationNavController, animated: true)
                
                if let annotation = view.annotation{
                    if let subtitle = annotation.subtitle{
                        locationNavController.displayLocation(locationModel: region.locations[Int(subtitle!) ?? 0 ])
                        
                    }
                    
                }
                
            }
            
            
        }

        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}

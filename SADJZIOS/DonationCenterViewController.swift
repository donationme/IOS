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
    public var searchDelegate:SearchDelegate?
    private var goSearchAfter = false;
    
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
    
    func searchAfterChoose(){
        
        self.goSearchAfter = true


    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //do what you need here
        mapView.deselectAnnotation(view.annotation, animated: true)
        if let region = self.region{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            var locationModel:LocationModel?
            
            if let annotation = view.annotation{
                if let subtitle = annotation.subtitle{
                    
                    locationModel = region.locations[Int(subtitle!) ?? 0 ]
                    
                }
                
            }
            
            if (self.goSearchAfter == true){
                if let searchDelegate = self.searchDelegate, let _locationModel = locationModel{
                    
                    searchDelegate.setLocationID(locationModel: _locationModel)
                    self.dismiss(animated: true)
                }
            }else{
                
                if let locationNavController = storyboard.instantiateViewController(withIdentifier: "LocationNavController") as? LocationNavController{
                    
                    self.present(locationNavController, animated: true)
                    
                    if let _locationModel = locationModel{
                        locationNavController.displayLocation(locationModel: _locationModel)
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

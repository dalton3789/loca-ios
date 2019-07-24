//
//  MapViewController.swift
//  loca
//
//  Created by Toan Nguyen on 5/25/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit
import MapKit
import ISHPullUp

class MapViewController: UIViewController, MKMapViewDelegate, ISHPullUpContentDelegate {
    
    @IBOutlet weak var settings_icon: UIImageView!
    
    @IBOutlet weak var map: MKMapView!
    var touchPoint = CGPoint()
    var DynamicView = UIView()
    var selectedTittle = ""
    var listAnnotation = [MakerAnnotation]()
    var defaultLocation = CLLocation()
    let sharedActions = SharedActions()
    let server = Server()
    var project = Project()
    var apartmentList = [Config.apartment]()
    let cIndicator = CustomIndicator()
    var pullVC = ISHPullUpViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        cIndicator.addIndicator(view: self, alpha: 1.0)
        cIndicator.startIndicator(timeout: 10.0)
        getApartmentFromProject()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.pullVC.setBottomHidden(true, animated: true)
    }
    
    func setupUI(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showMoreActions(touch:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        settings_icon.layer.cornerRadius = 20
    }
    
    @IBAction func toSettings(_ sender: UITapGestureRecognizer) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingTableViewController") as! SettingTableViewController
        self.present(viewController, animated: true)
        guard let nav = self.navigationController else {
            print("Blank Nav")
            return
        }
        
        nav.pushViewController(viewController, animated: true)
    }
    
    func getApartmentFromProject(){
        
        /*
        let link = Config.host + "/api/apartments?id=" + String(self.project.id)
        server.sendGETRequest(link: link, completionhandler: {data in
            self.getApartmentInfo(result: data)
        })
 
        let link = Config.host + "/api/apartments?id=" + String(self.project.id)
        LocaApartmentAPI.getApartment(link: link, completionHandler: <#T##(Data) -> ()#>)
         */
        var apartment = Config.apartment()
        apartment.id = 1
        apartment.legalStatus = "Dang ban"
        apartment.longitude =  "106.720378"
        apartment.latitude = "10.730040"
        apartment.addressNumber = "23"
        self.apartmentList.append(apartment)
        
        self.addMarker()
        self.cIndicator.stopIndicator()
        
        
        
        
    }
    
    func addMarker(){
        map.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        for apartment in apartmentList {
            let anotation = MakerAnnotation(coordinate: CLLocationCoordinate2D(latitude: (apartment.latitude as NSString).doubleValue,  longitude: (apartment.longitude as NSString).doubleValue), title: "Căn " + apartment.addressNumber, subTitle: "Dự án " + project.name!)
            map.addAnnotation(anotation)
        }
        
        let defaultCoordinate = CLLocationCoordinate2D(latitude: Double(project.latitude!)!, longitude: Double(project.longitude!)!)
        let annotation = MakerAnnotation(coordinate: defaultCoordinate, title: "", subTitle: "")
        
        map.setRegion(annotation.region, animated: true)
        map.delegate = self
        map.showsUserLocation = true
        
    }

    func getApartmentInfo(result : String){
        let data = result.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
            {
                
                for event in jsonArray {
                    
                    let legalStatus = event["legalStatus"] as! String
                    let longitude = event["longitude"] as! String
                    let id = event["id"] as! Int
                    let latitude = event["latitude"] as! String
                    let addressNumber = event["addressNumber"] as! String
                    /*let area = event["addressarea"] as! String
                    let ward = event["ward"] as! String
                    let district = event["district"] as! String
                    let city = event["city"] as! String
                    let street = event["street"] as! String
                    */
                    var apartment = Config.apartment()
                    apartment.id = id
                    apartment.legalStatus = legalStatus
                    apartment.longitude = longitude
                    apartment.latitude = latitude
                    apartment.addressNumber = addressNumber
                    self.apartmentList.append(apartment)
                    
                }
                
                DispatchQueue.main.async{
                    self.addMarker()
                    self.cIndicator.stopIndicator()
                }
                
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    @objc func showMoreActions(touch: UITapGestureRecognizer) {
        pullVC.setBottomHidden(true, animated: true)
    }
  
    final class MakerAnnotation: NSObject, MKAnnotation {
        var coordinate: CLLocationCoordinate2D
        var title : String?
        var subtitle: String?
        var region : MKCoordinateRegion {
            let span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
            return MKCoordinateRegion(center: coordinate, span: span)
        }
        
        init(coordinate : CLLocationCoordinate2D, title : String, subTitle : String) {
            self.coordinate = coordinate
            self.title = title
            self.subtitle = subTitle
            super.init()
        }
    
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let selectedAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            selectedAnnotation.animatesWhenAdded = true
            selectedAnnotation.titleVisibility = .adaptive
            selectedAnnotation.subtitleVisibility = .adaptive
            
            let rightButton = UIButton(type: .contactAdd)
            rightButton.tag = annotation.hash
            //selectedAnnotation.animatesDrop = true
            //selectedAnnotation.canShowCallout = true
            selectedAnnotation.rightCalloutAccessoryView = rightButton
            
            return selectedAnnotation
        }
        else {return nil}
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.pullVC.setBottomHidden(false, animated: true)
    }
    
    @objc func showMap(){
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            //let vc = segue.destination as! DetailViewController
            //vc.titleMaker =  selectedTittle
        }
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forContentViewController contentVC: UIViewController) {
        contentVC.view.layoutMargins = .zero
        pullVC = pullUpViewController
        self.view.layoutIfNeeded()
    }
    
    func hideBottom(){
        self.pullVC.setBottomHidden(true, animated: true)
    }

}


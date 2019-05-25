//
//  MapViewController.swift
//  loca
//
//  Created by Toan Nguyen on 5/25/19.
//  Copyright © 2019 LocaLoca. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var map: MKMapView!
    var touchPoint = CGPoint()
    var DynamicView = UIView()
    var selectedTittle = ""
    var listAnnotation = [MakerAnnotation]()
    var defaultLocation = CLLocation()
    let sharedActions = SharedActions()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        let defaultCoordinate = CLLocationCoordinate2D(latitude: 10.726244, longitude: 106.712437)
        let annotation = MakerAnnotation(coordinate: defaultCoordinate, title: "Căn 022", subTitle: "Dự án Phú Gia - Khu Phú Mỹ Hưng ")
        listAnnotation.append(annotation)
        listAnnotation.append(MakerAnnotation(coordinate: CLLocationCoordinate2D(latitude: 10.726262,  longitude: 106.712601), title: "Căn 021", subTitle: "Dự án Phú Gia - Khu Phú Mỹ Hưng "))
        listAnnotation.append(MakerAnnotation(coordinate: CLLocationCoordinate2D(latitude: 10.724807,  longitude: 106.715308), title: "Căn 221", subTitle: "Dự án Phú Gia - Khu Phú Mỹ Hưng "))
        
        
        for i in listAnnotation {
            map.addAnnotation(i)
        }
        
        map.setRegion(annotation.region, animated: true)
        map.delegate = self
        map.showsUserLocation = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showMoreActions(touch:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func showMoreActions(touch: UITapGestureRecognizer) {
        DynamicView.removeFromSuperview()
        touchPoint = touch.location(in: self.view)
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
        
        /*
        DynamicView = UIView(frame: CGRect(x: self.view.frame.width/3, y : touchPoint.y - 120, width: self.view.frame.width/2, height: 50.0))
        DynamicView.backgroundColor = UIColor.lightGray
        DynamicView.layer.cornerRadius = 10
        DynamicView.layer.borderWidth = 1
        
        
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 30))
        selectedTittle = ((view.annotation?.title)!)!
        label.text = "View Detail : " + selectedTittle
        
        
        DynamicView.addSubview(label)
        DynamicView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showMap)))
        
        
        self.view.addSubview(DynamicView)
 */
        performSegue(withIdentifier: "map_detail", sender: self)
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
    
    

}


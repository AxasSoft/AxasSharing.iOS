//
//  MapAppartController.swift
//  House
//
//  Created by Сергей Майбродский on 16.07.2022.
//

import UIKit
import MapKit
import PromiseKit

class MapAppartController: UIViewController, MKMapViewDelegate {
    
    var appartList: [Appart?] = []
    
    var selectedAppart: Appart?
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var allAppartsMap: MKMapView!
    
    @IBOutlet weak var appartInfoView: UIView!
    @IBOutlet weak var infoViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    var appartId = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allAppartsMap.isHidden = true
        appartInfoView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        appartInfoView.setSmallRadius()
        
        appartInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goappartInfo)))
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.infoViewBottomConstraint.constant += self.appartInfoView.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getApparts()
        
    }
    
    //MARK: GO appart INFO
    @objc func goappartInfo(){
        performSegue(withIdentifier: "mapToappartInfo", sender: nil)
    }
    
    
    //MARK: GET appartS
    func getApparts() {
        self.spinner.startAnimating()
        appartList = []
        firstly{
            SearchModel.fetchAppartList()
        }.done { [self] data in
            // if ok
            print(data)
            if (data.message?.lowercased() == "ok") {
                self.appartList = data.data
                self.setAppartOnMap()
                self.allAppartsMap.isHidden = false
                self.spinner.stopAnimating()
            } else {
                self.allAppartsMap.isHidden = false
                self.spinner.stopAnimating()
            }
        }.catch{ error in
            print(error.localizedDescription)
            self.allAppartsMap.isHidden = false
            self.spinner.stopAnimating()
        }
    }
    @objc func selectMapPoint(_ sender: MKAnnotationView) {
        
    }
    
    //MARK: SET Appart ON MAP
    func setAppartOnMap() {
        for appart in appartList {
            // set location
            let annotations = MKPointAnnotation()
            annotations.title = appart?.title
            let coordinate = CLLocationCoordinate2D(latitude: appart?.lat ?? 0, longitude: appart?.lon ?? 0)
            annotations.coordinate = coordinate
            allAppartsMap.addAnnotation(annotations)
            allAppartsMap.setCenter(CLLocationCoordinate2D(latitude: 55.4784217606, longitude: 53.6156667066), animated: false)
            allAppartsMap.reloadInputViews()
            
        }
    }
    
    //MARK: SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapToappartInfo"{
            let destinationVC = segue.destination as! OneAppartController
            destinationVC.id = self.appartId
        }
    }
    
    
    //MARK: TAP ON PIN
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        for appart in appartList {
            
            if view.annotation!.coordinate.latitude == appart!.lat &&
                view.annotation!.coordinate.longitude == appart!.lon{
                appartId = (appart?.id)!
                name.text = appart?.title
                address.text = appart?.address
                phone.text = "\(appart?.priceShort ?? 0) ₽ в сутки"
                
                UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.infoViewBottomConstraint.constant -= self.appartInfoView.bounds.height
                    self.view.layoutIfNeeded()
                }, completion: nil)
                
            }
        }
        print("Pin Tapped")
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.infoViewBottomConstraint.constant += self.appartInfoView.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
    }
}

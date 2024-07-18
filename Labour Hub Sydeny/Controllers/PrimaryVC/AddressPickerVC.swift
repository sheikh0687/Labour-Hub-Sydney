//
//  AddressPickerVC.swift
//  Labour Hub Sydeny
//
//  Created by mac on 07/04/23.
//

import UIKit
import Rswift
import MapKit

class AddressPickerVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var txtSearchLocation: UITextView!
    @IBOutlet weak var tableViewOt: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightLocation: NSLayoutConstraint!
    @IBOutlet weak var btnBack: UIButton!
    
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    var address_display = ""
    var address:String = ""
    var lat:Double?
    var lon:Double?
    var location_cordinate:CLLocationCoordinate2D?
    
    var locationPickedBlock: ((CLLocationCoordinate2D, Double, Double, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchCompleter.delegate = self
        self.txtSearchLocation.textColor = .lightGray
        Utility.showCurrentLocation(mapView, self)
        Utility.getLocationByCoordinates(location: kAppDelegate.coordinate2) { (address, display_address) in
            self.txtSearchLocation.text = address
            self.location_cordinate = kAppDelegate.coordinate2.coordinate
            self.lat = kAppDelegate.coordinate2.coordinate.latitude
            self.lon = kAppDelegate.coordinate2.coordinate.longitude
            self.address = address
            self.setSearchLocation()
        }
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationOnLongPress(gesture:)))
        longPressGesture.minimumPressDuration = 1.0
        self.mapView.addGestureRecognizer(longPressGesture)
        
//        if L102Language.currentAppleLanguage() == "en" {
        self.btnBack.setImage(R.image.user_black(), for: .normal)
//        } else {
//            self.btnBack.setImage(R.image.next(), for: .normal)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func updateMapViewAndAnnotation() {
        if CLLocationCoordinate2DIsValid(location_cordinate!) {
            Utility.initMapViewAnnotation(mapView)
            let annotation = MKPointAnnotation()
            annotation.title = self.address
            annotation.coordinate = self.location_cordinate!
            mapView.addAnnotation(annotation)
            
            mapView.mapType = MKMapType.standard
            let span = MKCoordinateSpan.init(latitudeDelta: 0.002, longitudeDelta: 0.002)
            let region = MKCoordinateRegion(center: self.location_cordinate!, span: span)
            self.mapView.setRegion(region, animated: true)
        } else {
            alert(alertmessage: "Not Found Please Try Again!")
        }
    }
    
    func setSearchLocation() {
        if self.address != "" {
            self.txtSearchLocation.text = self.address
            self.txtSearchLocation.textColor = .black
        } else {
            self.txtSearchLocation.text = "Search Location"
            self.tableViewOt.isHidden = true
            searchCompleter.queryFragment = txtSearchLocation.text!
            self.txtSearchLocation.textColor = .lightGray
        }
        let height_location = Utility.autoresizeTextView(self.address, font: UIFont.systemFont(ofSize: 14.0), width: self.txtSearchLocation.frame.width)
//        print(height_location)
        if height_location > 17 {
            self.constraintHeightLocation.constant = height_location + 15
        } else {
            self.constraintHeightLocation.constant = height_location + 18
        }
        self.txtSearchLocation.resignFirstResponder()
    }
    
    @objc func addAnnotationOnLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .ended {
            Utility.initMapViewAnnotation(mapView)
            
            let point = gesture.location(in: self.mapView)
            let coordinatee = self.mapView.convert(point, toCoordinateFrom: self.mapView)
            self.lat = coordinatee.latitude
            self.lon = coordinatee.longitude
            self.location_cordinate = coordinatee
            
            Utility.getLocationByCoordinates(location: CLLocation.init(latitude: self.lat!, longitude: self.lon!)) { (address, display_address) in
                self.address_display = display_address
                self.address = address
                self.setSearchLocation()
            }
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = self.location_cordinate!
            annotation.title = self.address
            self.mapView.addAnnotation(annotation)
        }
    }
    
    @IBAction func btnSubmitAddress(_ sender: UIButton) {
        self.dismiss(animated: true) { [self] in
            self.locationPickedBlock?(self.location_cordinate ?? kAppDelegate.coordinate2.coordinate, self.lat ?? kAppDelegate.coordinate2.coordinate.latitude, self.lon ?? kAppDelegate.coordinate2.coordinate.longitude, self.address)
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddressPickerVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.location_cordinate = mapView.centerCoordinate
        self.lat = mapView.centerCoordinate.latitude
        self.lon = mapView.centerCoordinate.longitude
        let cllocation = CLLocation(latitude: self.lat ?? 0.0, longitude: self.lon ?? 0.0)
        Utility.getLocationByCoordinates(location: cllocation) { (address, display_address) in
            self.txtSearchLocation.text = address
            self.address = address
            self.setSearchLocation()
        }
    }
}

extension AddressPickerVC: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableViewOt.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        
    }
}

extension AddressPickerVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults.count < 1 {
            tableViewOt.isHidden = true
        }
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell:SearchLocationCell = tableView.dequeueReusableCell(withIdentifier: "searchLocationCell", for: indexPath) as! SearchLocationCell
        cell.lblMainLocation.text = searchResult.title
        cell.lblSecondaryLocation.text = searchResult.subtitle
        return cell
    }
}

extension AddressPickerVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableViewOt.isHidden = true
        let completion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            self.location_cordinate = response?.mapItems[0].placemark.coordinate
            self.address = (response?.mapItems[0].placemark.title)!
            self.lat = response?.mapItems[0].placemark.coordinate.latitude
            self.lon = response?.mapItems[0].placemark.coordinate.longitude

            let name = response?.mapItems[0].placemark.name
            let postalCode = response?.mapItems[0].placemark.name
            self.address_display = name! + " " + postalCode!
            self.updateMapViewAndAnnotation()
            self.setSearchLocation()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableHeightConstraint.constant = tableViewOt.contentSize.height
    }
}

extension AddressPickerVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Search Location" && textView.textColor == .lightGray) {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "" && textView.tag == 0) {
            textView.text = "Search Location"
            self.tableViewOt.isHidden = true
            self.searchCompleter.queryFragment = txtSearchLocation.text!
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.tag == 0 {
            if textView.text != "" {
                self.tableViewOt.isHidden = false
                self.constraintHeightLocation.constant = 33.0
                print("dd")
            } else {
                self.tableViewOt.isHidden = true
                print("nothing")
            }
            self.searchCompleter.queryFragment = txtSearchLocation.text!
        }
    }
}


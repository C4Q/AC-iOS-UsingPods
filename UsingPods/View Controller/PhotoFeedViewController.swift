//
//  PhotoFeedViewController.swift
//  UsingPods
//
//  Created by Alex Paul on 1/22/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit
import CoreLocation

class PhotoFeedViewController: UIViewController {
    
    private let photoFeed = PhotoFeed()
    
    private var photos = [Photo]() {
        didSet {
            DispatchQueue.main.async {
                self.photoFeed.collectionView.reloadData()
            }
        }
    }
    
    private var flickrAPIService: FlickrAPI!
    private var appleLocationService: AppleLocationService!
    private var currentPhotoType = ""
    
    init(flickrAPIService: FlickrAPI, appleLocationService: AppleLocationService) {
        super.init(nibName: nil, bundle: nil)
        self.flickrAPIService = flickrAPIService
        self.appleLocationService = appleLocationService
        
        // Step 1: assign self to conform to protocol
        self.flickrAPIService.delegate = self
        self.appleLocationService.delegate = self 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoFeed)
        photoFeed.collectionView.dataSource = self
        photoFeed.photoSearchBar.delegate = self
        photoFeed.addressSearchBar.delegate = self
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.barTintColor = .orange
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.titleView = photoFeed.photoSearchBar
    }
}

extension PhotoFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as! PhotoCollectionCell
        cell.backgroundColor = .white
        let photo = photos[indexPath.row] // gets up a photo
        cell.configureCell(photo: photo)
        return cell
    }
}

extension PhotoFeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: segue to DeatilViewController
    }
}

extension PhotoFeedViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        var address: String? = nil
        if let text = photoFeed.addressSearchBar.text {
            if text.isEmpty {
                address = "Queens, NY"
            } else {
                address = text
            }
        }
        guard let photoSearchText = photoFeed.photoSearchBar.text,
            !photoSearchText.isEmpty else { print("photo search is nil - empty"); return }
        guard let addressSearchText = address else { print("address search can't be nil"); return }
        
        // TODO: use AppleLocationService to geocode the address to a CLLocation
        print("photo serch text: \(photoSearchText)")
        print("address search text: \(addressSearchText)")
        currentPhotoType = photoSearchText
        appleLocationService.geocodeAddress(address: addressSearchText)
    }
}

extension PhotoFeedViewController: AppleLocationServiceDelegate {
    func appleLocationService(_ appleLocationService: AppleLocationService, didReceiveCoordinates coordinate: CLLocationCoordinate2D) {
        flickrAPIService.photoSearch(photoType: currentPhotoType, location: coordinate)
    }
}

extension PhotoFeedViewController: FlickrAPIDelegate {
    func flickrService(_ flickrService: FlickrAPI, didReceivePhotos photos: [Photo]) {
        self.photos = photos
    }
}
















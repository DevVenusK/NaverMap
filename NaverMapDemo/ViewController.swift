//
//  ViewController.swift
//  NaverMapDemo
//
//  Created by 김효성 on 2021/07/09.
//

import UIKit
import NMapsMap

class ViewController: UIViewController {
    let mapView = NMFMapView()
    override func viewDidLoad() {
        setupMapView()
        initCameraPosition()
        drawPolygon()
    }
}

extension ViewController {
    private func setupMapView() {
        super.viewDidLoad()
        view.addSubview(mapView)
        mapView.extent = NMGLatLngBounds(southWestLat: 31.43, southWestLng: 122.37, northEastLat: 44.35, northEastLng: 132)
        mapView.minZoomLevel = 8.0
        mapView.maxZoomLevel = 18.0
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        [mapView.topAnchor.constraint(equalTo: view.topAnchor),
         mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
            .forEach { $0.isActive = true }
    }
}

extension ViewController {
    func initCameraPosition() {
        mapView.moveCamera(NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: 37.536, lng: 127.003), zoom: 14)))
    }
    
    func drawPolygon() {
        let url = Bundle.main.path(forResource: "map", ofType: "json")!
        let jsonData = try! String(contentsOfFile: url).data(using: .utf8)
        let encoder = try! JSONDecoder().decode(MapModel.self, from: jsonData!)
        
        encoder.features
            .forEach {
                let coordinates = $0.geometry.coordinates.first!.compactMap { NMGLatLng(lat: $0[1], lng: $0[0])}
                let polygon = NMGPolygon(ring: NMGLineString(points: coordinates))
                let polygonOverlay = NMFPolygonOverlay(polygon as! NMGPolygon<AnyObject>)
                polygonOverlay?.mapView = mapView
                polygonOverlay?.fillColor = .red.withAlphaComponent(0.25)
                polygonOverlay?.outlineColor = .black
                polygonOverlay?.outlineWidth = 1
            }
    }
}


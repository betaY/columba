//
//  MyAnnotation.swift
//  MapSearching
//
//  Created by Tian Qiu on 9/27/15.
//  Copyright (c) 2015年 Beta. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation: NSObject, MKAnnotation {    // add pin point
    var coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title:String? // 强制解析
    init(coordinate:CLLocationCoordinate2D,title:String){
        self.coordinate = coordinate
        self.title = title
    }
}
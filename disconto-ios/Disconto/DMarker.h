//
//  DMarker.h
//  Disconto
//
//  Created by user on 20.10.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>

@interface DMarker : GMSMarker

@property NSInteger storeID;
+ (void)getAllMarkersFromMapView:(GMSMapView *)mapView withCallBack:(void (^)(NSArray *itemsArray))callBack;
@end

//
//  DMapItemModel.h
//  Disconto
//
//  Created by user on 31.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface DMapItemModel : MKMapItem

@property MKPlacemark *storePlaceMark;
@property CLLocationCoordinate2D locCor;
@property UIImageView *imageView;
@property NSString *addreress;
@property NSString *shopName;
@property NSString *storeID;
@property UIButton *shopButton;

+ (void)getAllItemsFromMapView:(MKMapView *)mapView andController:(UIViewController *)controller withCallBack:(void (^)(NSArray *itemsArray))callBack;
@end

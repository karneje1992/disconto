//
//  DMapViewController.m
//  Disconto
//
//  Created by user on 20.10.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DMapViewController.h"
#import "MVVMDProductsViewController.h"
#import "DProductsVM.h"

@interface DMapViewController ()

@property GMSMapView *mapView;
@property CLLocationCoordinate2D currentPosition;
@property NSArray<DMarker *> *markers;
@property NSMutableArray<id<MKAnnotation>> *locationArray;
@end

@implementation DMapViewController

+ (instancetype)showMapViewControllerWithTarget:(CLLocationCoordinate2D)target{

    return [[DMapViewController alloc] initWithNibName:NSStringFromClass([DMapViewController class]) bundle:nil andTarget:target];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andTarget:(CLLocationCoordinate2D)target
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.markers = @[];
        self.currentPosition = target;
    }
    return self;
}

+ (instancetype)showMapViewWithLocations:(NSArray *)locations{
    
    return [[DMapViewController alloc] initWithNibName:NSStringFromClass([DMapViewController class]) bundle:nil forceCubeLocationsArray:locations];
}

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil forceCubeLocationsArray:(NSArray *)locationsArray
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.locationArray = @[].mutableCopy;
////        [locationsArray enumerateObjectsUsingBlock:^(id<FCBLocation>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////            
////            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(obj.latitude, obj.longitude) addressDictionary:@{@"address":obj.address,@"name":obj.name}];
////            [self.locationArray addObject:placemark];
//        
//        }];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.currentPosition.latitude > 0) {
        
        [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
            
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder geocodeAddressString:resault.userCityName completionHandler:^(NSArray* placemarks, NSError* error){
                for (CLPlacemark* aPlacemark in placemarks)
                {
                    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:aPlacemark.location.coordinate zoom:12];
                    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
                    _mapView.myLocationEnabled = YES;
                    _mapView.delegate = self;
                    self.view = _mapView;
                    _mapView.settings.indoorPicker = YES;
                    _mapView.settings.myLocationButton = YES;
                }
            }];
        }];

    }
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:self.currentPosition zoom:16];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = YES;
    _mapView.delegate = self;
    self.view = _mapView;
    _mapView.settings.indoorPicker = YES;
    _mapView.settings.myLocationButton = YES;
    //self.title = shopsTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

}

#pragma mark privet methods

- (void)setMarkerWithMarker:(DMarker *)marker{

    marker.map = _mapView;
    marker.tappable = YES;
}

#pragma mark map view delegate

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{

}

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{

    [DMarker getAllMarkersFromMapView:mapView withCallBack:^(NSArray *itemsArray) {
        self.markers = itemsArray;
        [mapView clear];
        for (DMarker *marker in itemsArray) {
            [self setMarkerWithMarker:marker];
        }
    }];
    
}

- (void)mapView:(GMSMapView *)mapView didTapOverlay:(GMSOverlay *)overlay{

}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{

    if (self.markers.count) {
        [self.markers enumerateObjectsUsingBlock:^(DMarker * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (marker.position.longitude == obj.position.longitude && marker.position.latitude == obj.position.latitude) {
               // [self.navigationController pushViewController:[DProductsViewController showProductsWithShopID:obj.storeID andTitle:obj.title] animated:YES];
                DShopModel *shop = [DShopModel new];
                shop.shopID = obj.storeID;
                shop.shopName = obj.title;
                        [self.navigationController pushViewController:[MVVMDProductsViewController showProductsWithViewModel:[DProductsVM showProductsOfShop:shop]] animated:NO];
                return ;
            }
        }];
    }
    
}
@end

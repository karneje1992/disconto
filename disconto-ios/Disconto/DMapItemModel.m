//
//  DMapItemModel.m
//  Disconto
//
//  Created by user on 31.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DMapItemModel.h"

@implementation DMapItemModel

+ (void)getAllItemsFromMapView:(MKMapView *)mapView andController:(UIViewController *)controller withCallBack:(void (^)(NSArray *itemsArray))callBack{

    NSMutableArray *array = @[].mutableCopy;
    
//    if (mapView.annotations.count == 0) {
        
        DMapItemModel *parent = [DMapItemModel new];
        NSArray *coords = [parent getBoundingBox:mapView.visibleMapRect];
        [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{ @"nw_lat":coords[0], @"nw_long":coords[1], @"se_lat":coords[2], @"se_long":coords[3]} andAPICall:[NSString stringWithFormat:@"/stores/map"] withCallBack:^(BOOL success, NSDictionary *resault) {
            
            if (success) {
                
                for (NSDictionary *list in resault[kServerData]) {
                    
                    [array addObject:[[DMapItemModel alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([list[@"latitude"] doubleValue], [list[@"latitude"] doubleValue]) addressDictionary:nil] andDictionary:list andMap:mapView andController:controller]];
                }
                
            }
            
            callBack(array);
        }];
//    }else{
//        
//        callBack(array);
//    }
}

- (NSArray *)getBoundingBox:(MKMapRect)mRect{
    
    CLLocationCoordinate2D topLeft = [self getNWCoordinate:mRect];
    CLLocationCoordinate2D bottomRight = [self getSECoordinate:mRect];
    
    return @[[NSNumber numberWithDouble:topLeft.latitude ],
             [NSNumber numberWithDouble:topLeft.longitude],
             [NSNumber numberWithDouble:bottomRight.latitude],
             [NSNumber numberWithDouble:bottomRight.longitude]];
}

-(CLLocationCoordinate2D)getNECoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMaxX(mRect) y:mRect.origin.y];
}
-(CLLocationCoordinate2D)getNWCoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMinX(mRect) y:mRect.origin.y];
}
-(CLLocationCoordinate2D)getSECoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:MKMapRectGetMaxX(mRect) y:MKMapRectGetMaxY(mRect)];
}
-(CLLocationCoordinate2D)getSWCoordinate:(MKMapRect)mRect{
    return [self getCoordinateFromMapRectanglePoint:mRect.origin.x y:MKMapRectGetMaxY(mRect)];
}

-(CLLocationCoordinate2D)getCoordinateFromMapRectanglePoint:(double)x y:(double)y{
    MKMapPoint swMapPoint = MKMapPointMake(x, y);
    return MKCoordinateForMapPoint(swMapPoint);
}

- (instancetype)initWithPlacemark:(MKPlacemark *)placemark andDictionary:(NSDictionary *)dictionary andMap:(MKMapView *)mapView andController:(UIViewController *)controller{
    
    self = [super initWithPlacemark:placemark];
    if (self) {
        
        self.storeID = dictionary[@"store_id"];
        self.locCor = CLLocationCoordinate2DMake([dictionary[@"latitude"] doubleValue], [dictionary[@"longitude"] doubleValue]);
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dictionary[@"img_url"]]] scale:1.5]];
        self.shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addreress = dictionary[@"address"];
        [self.shopButton setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dictionary[@"img_url"]]] scale:1.5] forState:UIControlStateNormal];
        [self.shopButton setFrame:CGRectMake(0, 0, 60, 40)];
        self.shopName = dictionary[@"store_name"];
       //[self.imageView sd_setImageWithURL:[NSURL URLWithString:dictionary[@"img_url"]]];
        
    }
    return self;
}
@end

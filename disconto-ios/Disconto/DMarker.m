//
//  DMarker.m
//  Disconto
//
//  Created by user on 20.10.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DMarker.h"

@implementation DMarker

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
       
        self.icon = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dictionary[@"img_url"]]] scale:2];
        self.title = dictionary[@"store_name"];
        self.position = CLLocationCoordinate2DMake([dictionary[@"latitude"] doubleValue], [dictionary[@"longitude"] doubleValue]);
        self.snippet = dictionary[@"address"];
        self.storeID = [dictionary[@"store_id"] integerValue];
    }
    return self;
}

+ (void)getAllMarkersFromMapView:(GMSMapView *)mapView withCallBack:(void (^)(NSArray *itemsArray))callBack{
    
    NSMutableArray *array = @[].mutableCopy;
    GMSVisibleRegion visibleRegion = mapView.projection.visibleRegion;

    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{ @"nw_lat":@(visibleRegion.farLeft.latitude), @"nw_long":@(visibleRegion.farLeft.longitude), @"se_lat":@(visibleRegion.nearRight.latitude), @"se_long":@(visibleRegion.nearRight.longitude)} andAPICall:[NSString stringWithFormat:@"/stores/map"] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
          //  SHOW_PROGRESS;
            for (NSDictionary *list in resault[kServerData]) {
                
                [array addObject:[[DMarker alloc] initWithDictionary:list]];
            }
            
        }
        
      //  HIDE_PROGRESS;
        callBack(array);
    }];
    //    }else{
    //
    //        callBack(array);
    //    }
}


@end

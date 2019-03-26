//
//  DMapViewController.h
//  Disconto
//
//  Created by user on 20.10.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"

@interface DMapViewController : DSuperViewController <GMSMapViewDelegate>

+ (instancetype)showMapViewControllerWithTarget:(CLLocationCoordinate2D)target;
+ (instancetype)showMapViewWithLocations:(NSArray *)locations;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil forceCubeLocationsArray:(NSArray *)locationsArray;
@end

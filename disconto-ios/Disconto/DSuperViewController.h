//
//  DSuperViewController.h
//  Disconto
//
//  Created by user on 16.06.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreLocation/CLAvailability.h>
//#import <CoreLocation/CLLocation.h>
//#import <CoreLocation/CLRegion.h>
#import "AppDelegate.h"

@interface DSuperViewController : UIViewController



+ (void)logOut;
+ (NSString *)randomStringWithLength:(int)len;
+ (void)openSettings;
+ (NSArray *)getTutorial;
+ (NSArray *)getPhotoTutorial;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)messag;
@end

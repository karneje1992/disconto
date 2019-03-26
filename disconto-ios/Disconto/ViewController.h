//
//  ViewController.h
//  Disconto
//
//  Created by user on 12.08.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"
//#import "ForceCuBeSDK.h"
//#import "ForceCuBeUI.h"

@interface ViewController : DSuperViewController<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *animatedView;

@property (strong, nonatomic) IBOutlet UIView *blureView;
//@property ForceCuBe * forcecube;
//@property CLLocationManager * locationManager;
@end

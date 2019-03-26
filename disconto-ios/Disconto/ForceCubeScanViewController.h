//
//  ForceCubeScanViewController.h
//  ForseCubeDiscontoDemo
//
//  Created by Rostislav on 12/27/16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DForceCubeSubClass.h"

@interface ForceCubeScanViewController : DSuperViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(id<FCBCampaignOffer>)forceCubeModel;
//
//+ (instancetype)showScanSceenWithOffer:(id<FCBCampaignOffer>)forceCubeModel;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data:(NSData *)data;
@end

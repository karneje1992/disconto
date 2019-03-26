//
//  DCircleViewController.h
//  Loter
//
//  Created by Rostislav on 25.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCircleViewModel.h"
#import "DSuperViewController.h"

@interface DCircleViewController : DSuperViewController <DCircleViewModelDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *pinImageView;
@property (strong, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (strong, nonatomic) IBOutlet UIImageView *titleImageView;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property UISwipeGestureRecognizer * swipeleft;
@property NSString *gemeID;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andModel:(id)model;

+ (instancetype)showCircleViewContrlllerWithModel:(id)model;
@end

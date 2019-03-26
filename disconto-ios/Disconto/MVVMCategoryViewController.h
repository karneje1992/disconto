//
//  MVVMCategoryViewController.h
//  Disconto
//
//  Created by Rostislav on 09.12.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"
#import "DVeryFaryMailController.h"


@interface MVVMCategoryViewController : DSuperViewController <UIScrollViewDelegate,UIAlertViewDelegate, MXBannerViewDelegate>
@property (weak, nonatomic) IBOutlet MXBannerView *bannerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerConstraint;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *parallaxHeight;
@property (strong, nonatomic) IBOutlet UIView *parallaxView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIView *banerView;
@property (weak, nonatomic) IBOutlet UIButton *goToPhoto;
@end

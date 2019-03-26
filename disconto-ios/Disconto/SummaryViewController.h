//
//  SummaryViewController.h
//  Disconto
//
//  Created by StudioVision on 22.01.15.
//  Copyright (c) 2015 StudioVision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummaryViewController.h"
#import "ParallaxScrollingFramework.h"

#import "DSuperViewController.h"

@interface SummaryViewController : DSuperViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *panoramaImageView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel * toLogoLabel;
@property(strong,nonatomic) ParallaxScrollingFramework *animator;
@property CGFloat k;

- (IBAction)startButtonTapped:(id)sender;
@end

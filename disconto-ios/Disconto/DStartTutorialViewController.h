//
//  DStartTutorialViewController.h
//  Disconto
//
//  Created by user on 31.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParallaxScrollingFramework.h"

@interface DStartTutorialViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *panoramaImageView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel * toLogoLabel;

// for animator
@property(strong,nonatomic) ParallaxScrollingFramework *animator;
@property CGFloat k;

- (IBAction)startButtonTapped:(id)sender;
@end

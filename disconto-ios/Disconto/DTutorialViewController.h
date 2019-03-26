//
//  DTutorialViewController.h
//  Disconto
//
//  Created by user on 20.07.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSharesModel.h"
#import "DOfferModel.h"

@protocol DTutorialViewControllerDelegate <NSObject>

- (void)exitTutorialViewController:(id)controller;

@end

@interface DTutorialViewController : DSuperViewController<UIGestureRecognizerDelegate>

@property id <DTutorialViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageStep;
@property DOfferModel *offer;
@property DSharesModel *sharesModel;

+ (instancetype)showTutorialWithUrlArray:(NSArray *)urlArray andShowButton:(BOOL)showButton;
+ (instancetype)showLocaleTutorial;
+ (instancetype)showTutorialWithImgArray:(NSArray *)urlArray andShowButton:(BOOL)showButton;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andImageURLArray:(NSArray *)imageURLArray andShowButton:(BOOL)showButton;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(DOfferModel *)offer;
+ (instancetype)showOfferInstruction:(DOfferModel *)offer;
@end

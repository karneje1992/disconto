//
//  DSubPageTutorialController.h
//  Disconto
//
//  Created by user on 20.07.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"

@interface DSubPageTutorialController : DSuperViewController<DShowWebSiteControllerDelegate>

@property DOfferModel *offer;
@property BOOL showButton;
@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@property (strong, nonatomic) IBOutlet UIImageView *tutorialImageView;

+ (instancetype)showPageForIndex:(NSInteger)pageIndex andImageArray:(NSArray *)imageArray;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil divaceTypeString:(NSString *)divaceTypeString imageIndex:(NSInteger)imageIndex andImageArray:(NSArray *)imageArray;

+ (instancetype)showPageForIndex:(NSInteger)pageIndex andImageArray:(NSArray <UIImage *> *)imageArray andShowButton:(BOOL)showButton;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andImgArray:(NSArray <UIImage *> *)imgArray andIndexImage:(NSInteger)indexImage andShowButton:(BOOL)showButton;
@end

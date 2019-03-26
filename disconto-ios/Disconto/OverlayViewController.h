//
//  OverlayViewController.h
//  Disconto
//
//  Created by user on 01.07.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropViewController.h"

@interface OverlayViewController : DSuperViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,PECropViewControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *cropButton;
@property (strong, nonatomic) IBOutlet UIButton *clear;
@property (strong, nonatomic) IBOutlet UILabel *counterLabel;
@property (strong, nonatomic) IBOutlet UIButton *photoButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)takePhoto:(UIButton *)sender;
+ (instancetype)showCameraControllerWithProducts:(NSArray<DProductModel *> *)products andStoreID:(NSInteger)storID;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProducts:(NSArray<DProductModel *> *)products andStoreID:(NSInteger)storeID;
@end

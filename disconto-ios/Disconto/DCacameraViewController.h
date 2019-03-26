//
//  DCacameraViewController.h
//  testCameOverlayr
//
//  Created by user on 31.08.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DImageListTableViewController.h"
#import "DSuperViewController.h"
#import "DPhotoListViewController.h"

@interface DCacameraViewController : UIViewController <UIImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PECropViewControllerDelegate, DImageListTableViewControllerDelegate, UIAlertViewDelegate, DPhotoListViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *splachView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@property (strong, nonatomic) IBOutlet UILabel *counterLabel;
@property (strong, nonatomic) IBOutlet UIImageView *previeImageView;
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;

@property (strong, nonatomic) IBOutlet UIView *cameraView;

@property (strong, nonatomic) IBOutlet UITabBarItem *selectedPhotosButton;
@property (strong, nonatomic) IBOutlet UIButton *galleryButton;
@property (strong, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (strong, nonatomic) IBOutlet UIButton *activePhotos;
@property NSString *storeName;

+ (instancetype)showCamera;
+ (instancetype)showCameraControllerWithProducts:(NSArray<DProductModel *> *)products andStoreID:(NSInteger)storID;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProducts:(NSArray<DProductModel *> *)products andStoreID:(NSInteger)storeID;
@end

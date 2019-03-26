//
//  DPhotoListViewController.h
//  Disconto
//
//  Created by Rostislav on 26.10.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSuperViewController.h"
#import "PECropViewController.h"
@protocol DPhotoListViewControllerDelegate <NSObject>

- (void)imageListController:(id)controller exitWithArray:(NSArray *)imageArray;
- (void)imageListControllerExit:(id)controller;

@end

@interface DPhotoListViewController : DSuperViewController<PECropViewControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *bottonImage;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property id <DPhotoListViewControllerDelegate> delegate;
@property NSMutableArray<DProductModel *> *products;
@property NSInteger storeID;
+ (instancetype)showImageListControllerWithArray:(NSArray<UIImage *> *)imageArray;
@end

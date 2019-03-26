//
//  DImageListTableViewController.h
//  testCameOverlayr
//
//  Created by user on 31.08.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DImageListTableViewControllerDelegate <NSObject>

- (void)imageListController:(id)controller exitWithArray:(NSArray *)imageArray;
- (void)imageListControllerExit:(id)controller;

@end

@interface DImageListTableViewController : UITableViewController

@property id <DImageListTableViewControllerDelegate> delegate;
@property NSMutableArray<DProductModel *> *products;
@property NSInteger storeID;
+ (instancetype)showImageListControllerWithArray:(NSArray<UIImage *> *)imageArray;
@end

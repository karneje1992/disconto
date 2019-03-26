//
//  ForceCubeSingleViewController.h
//  ForseCubeDiscontoDemo
//
//  Created by Rostislav on 12/23/16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForceCubeSingleViewController : DSuperViewController<UITableViewDelegate,UITableViewDataSource>

+ (instancetype)showControllerWithViewModel:(id)viewModel;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel;
@end

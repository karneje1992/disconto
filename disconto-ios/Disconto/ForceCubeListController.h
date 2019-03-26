//
//  ForceCubeListController.h
//  ForseCubeDiscontoDemo
//
//  Created by Rostislav on 12/22/16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForceCubeListViewModel.h"

@interface ForceCubeListController : DSuperViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

+ (instancetype)showForceCubeListControllerWithViewModel:(id)viewModel;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel;
@end

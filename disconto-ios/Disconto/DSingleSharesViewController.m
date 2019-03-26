//
//  DSingleSharesViewController.m
//  Disconto
//
//  Created by user on 19.08.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSingleSharesViewController.h"

@interface DSingleSharesViewController ()

@property DSharesModel *sharesModel;
@property CGFloat oldX;
@end


@implementation DSingleSharesViewController

+ (instancetype)showSingleSharesViewControllerWithSharesModel:(DSharesModel *)sharesModel{
    
    return [[DSingleSharesViewController alloc] initWithNibName:NSStringFromClass([DSingleSharesViewController class]) bundle:nil andSharesModel:sharesModel];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andSharesModel:(DSharesModel *)model
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.sharesModel = model;
            }
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/promo/%@",@(self.sharesModel.sharesID)] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            self.sharesModel = [[DSharesModel alloc] initWithDictioary:resault[kServerData]];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

@end

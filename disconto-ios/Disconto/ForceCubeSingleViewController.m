//
//  ForceCubeSingleViewController.m
//  ForseCubeDiscontoDemo
//
//  Created by Rostislav on 12/23/16.
//  Copyright © 2016 Devium. All rights reserved.
//
#include <math.h>
#import "ForceCubeSingleViewController.h"
#import "ForceSingleViewModel.h"
#import "ForceCubeScanViewController.h"

@interface ForceCubeSingleViewController ()<DShowWebSiteControllerDelegate>
@property ForceSingleViewModel *viewModel;
@end

@implementation ForceCubeSingleViewController

+ (instancetype)showControllerWithViewModel:(id)viewModel{
    
    return [[ForceCubeSingleViewController alloc] initWithNibName:NSStringFromClass([ForceCubeSingleViewController class]) bundle:nil viewModel:viewModel];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel updateCintroller:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.cellsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
            case 0:
            return !isnan(self.viewModel.headerSize)  ? self.viewModel.headerSize : 0;
        default:
            return UITableViewAutomaticDimension;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.viewModel.cellsArray[indexPath.row];
}
- (IBAction)action:(id)sender {
    
        [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/coupon/%@",self.viewModel.object.couponID] withCallBack:^(BOOL success, NSDictionary *resault) {
            
            if (success) {
              //  NSArray *arr = resault[@"data"][@"instructions"];
                DShowWebSiteController *vc = [DShowWebSiteController showWebViewWithData:[[NSData alloc] initWithBase64EncodedString:resault[@"data"][@"value"] options:0]];
                vc.delegate = self;
                
                [self.navigationController pushViewController:vc                 animated:YES];
            }
        }];
}

#pragma mark - DShowWebSiteControllerDelegate

- (void)startLoad{
}

- (void)exitWebView:(id)controller{

    UIViewController *vc = controller;
    [vc.navigationController popViewControllerAnimated:YES];
}
@end

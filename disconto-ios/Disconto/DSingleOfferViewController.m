//
//  DSingleOfferViewController.m
//  Disconto
//
//  Created by Rostislav on 1/10/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DSingleOfferViewController.h"
#import "DCouponHeaderCell.h"
#import "DShowWebSiteController.h"

@interface DSingleOfferViewController () <DShowWebSiteControllerDelegate>

@property DSingleOfferViewModel *viewModel;
@end

@implementation DSingleOfferViewController

+ (instancetype)showSingleOfferWithViewModel:(id)viewModel{
    
    return [[DSingleOfferViewController alloc] initWithNibName:NSStringFromClass([DSingleOfferViewController class]) bundle:nil viewModel:viewModel];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 10.0f;
    [_viewModel updateViewController:self];
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.cellsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case 0:
            return [(DCouponHeaderCell *)self.viewModel.cellsArray[indexPath.row] imgView].image ? _viewModel.headerSize : 0;
            
        default:{
             return UITableViewAutomaticDimension;
        }
           
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.viewModel.cellsArray[indexPath.row];
}

- (IBAction)action:(id)sender {
    
        if (self.viewModel.offer.offerValue) {
            
            DShowWebSiteController *vc = [DShowWebSiteController showWebViewWithData:_viewModel.offer.offerValue];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
//        else if (_viewModel.offer.FCModel){
//        
//            [self.navigationController pushViewController:[ForceCubeScanViewController showScanSceenWithOffer:_viewModel.offer.FCModel] animated:NO];
//        }
        else{
            
            DShowWebSiteController *vc = [DShowWebSiteController showWebViewWithURL:_viewModel.offer.offerURL];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 180)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 90;
}

- (void)startLoad{

}

- (void)exitWebView:(id)controller{

    [[(UIViewController *)controller navigationController] popViewControllerAnimated:YES];
}

@end

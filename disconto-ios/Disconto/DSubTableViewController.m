//
//  DSubTableViewController.m
//  Disconto
//
//  Created by Rostislav on 12/26/16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSubTableViewController.h"
#import "DCategoryViewModel.h"
#import "DBannerTableViewCell.h"
#import "MVVMDProductsViewController.h"
#import "DProductsVM.h"

@interface DSubTableViewController () <DCategoryViewModelDelegate>

@property DCategoryViewModel *viewModel;
@end

@implementation DSubTableViewController

+ (instancetype)showCatecoryListWithViewModel:(id)viewModel{
    
    return [[DSubTableViewController alloc] initWithNibName:NSStringFromClass([DSubTableViewController class]) bundle:nil viewModel:viewModel];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.viewModel = viewModel;
        self.viewModel.delegate = self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //  self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = self.view.bounds.size.height*0.25;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return self.viewModel.cellsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.viewModel.cellsArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   //// [self.navigationController pushViewController:[DProductsViewController showProductsWithCategory:_viewModel.categoryArray[indexPath.row]] animated:NO];
        [self.navigationController pushViewController:[MVVMDProductsViewController showProductsWithViewModel:[DProductsVM showProductsOfCategory:_viewModel.categoryArray[indexPath.row]]] animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 180)];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, (tableView.bounds.size.width/18*9))];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return tableView.bounds.size.width/18*9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return self.view.bounds.size.height*0.35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.viewModel.bannerView;
}

- (void)categoryDidFinihLoading:(id)viewModel{
    
    self.viewModel = viewModel;
    [self.viewModel updateController:self];
    [self.tableView reloadData];
    
}

- (void)bannerDidFinishLoading:(id)viewModel{
    
    self.viewModel = viewModel;
    [self.viewModel updateController:self];
    [self.tableView reloadData];
}

@end

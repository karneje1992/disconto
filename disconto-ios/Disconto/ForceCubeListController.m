//
//  ForceCubeListController.m
//  ForseCubeDiscontoDemo
//
//  Created by Rostislav on 12/22/16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "ForceCubeListController.h"

#import "ForceCubeSingleViewController.h"
#import "ForceSingleViewModel.h"

@interface ForceCubeListController ()<ForceCubeListViewModelDelegate>

@property ForceCubeListViewModel *viewModel;
@end

@implementation ForceCubeListController

+ (instancetype)showForceCubeListControllerWithViewModel:(id)viewModel{
    
    return [[ForceCubeListController alloc] initWithNibName:NSStringFromClass([ForceCubeListController class]) bundle:nil viewModel:viewModel];
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
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.viewModel updateController:self];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.cellsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return tableView.bounds.size.width*0.5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [[[self.viewModel.cellsArray reverseObjectEnumerator] allObjects] mutableCopy][indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //            [[[DForceCubeSubClass activeForceCube] campaignManager] setCampaignOfferAsAccepted:[[[[[self.viewModel.couponsArray reverseObjectEnumerator] allObjects] mutableCopy][indexPath.row] offer] campaignOfferId]];
    
    [self.navigationController pushViewController:[ForceCubeSingleViewController showControllerWithViewModel:[ForceSingleViewModel singleForceCubeForCoub:[[[self.viewModel.couponsArray reverseObjectEnumerator] allObjects] mutableCopy][indexPath.row]]] animated:NO];
}

#pragma mark - ForceCubeListViewModelDelegate

- (void)viewModel:(id)viewModel forForceCubeItemsArray:(NSArray<Coupon *> *)items{
    
    self.viewModel = viewModel;
    
    self.viewModel.couponsArray = [[[self.viewModel.couponsArray reverseObjectEnumerator] allObjects] mutableCopy];
    [self.viewModel updateController:self];
    [self.tableView reloadData];
    
}

- (void)viewModel:(id)viewModel forServertemsArray:(NSArray<Coupon *> *)items{
    
    self.viewModel = viewModel;
    
    self.viewModel.couponsArray = [[[self.viewModel.couponsArray reverseObjectEnumerator] allObjects] mutableCopy];
    [self.viewModel updateController:self];
    
    [self.tableView reloadData];
}

@end

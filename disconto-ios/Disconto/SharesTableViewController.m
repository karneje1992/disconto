//
//  SharesTableViewController.m
//  Disconto
//
//  Created by Rostislav on 12/28/16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "SharesTableViewController.h"
#import "SharesViewModel.h"
#import "ForceCubeSingleViewController.h"
#import "ForceSingleViewModel.h"
#import "Coupon.h"

@interface SharesTableViewController () <SharesViewModelDelegate,DShowWebSiteControllerDelegate,DTutorialViewControllerDelegate>

@property SharesViewModel *viewModel;
@property DSharesModel *model;

@end


@implementation SharesTableViewController

+ (instancetype)showSharesForViewModel:(id)viewModel{

    return [[SharesTableViewController alloc] initWithNibName:NSStringFromClass([SharesTableViewController class]) bundle:nil andModelView:viewModel];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andModelView:(id)modelView
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.viewModel = modelView;
        self.viewModel.delegate = self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    return self.viewModel.cellsArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/promo/%@",_viewModel.objectsArray[indexPath.row].shareID] withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            
            _model = [[DSharesModel alloc] initWithDictioary:resault[kServerData]];
            if (!_model.instructionArray.count && _model.rootURL) {
                
//                   [self.navigationController pushViewController:[ForceCubeSingleViewController showControllerWithViewModel:[ForceSingleViewModel singleForceCubeForCoub:]] animated:NO];
//                DShowWebSiteController *vc = [DShowWebSiteController showWebViewWithURL:_model.rootURL];
//                vc.delegate = self;
//                [self.navigationController pushViewController:vc animated:YES];
            }else{
            
                DTutorialViewController *vc = [DTutorialViewController showTutorialWithUrlArray:_model.instructionArray andShowButton:YES];
                // vc.hidesBottomBarWhenPushed = YES;
                vc.sharesModel = _model;
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
            

        }
    }];
}

#pragma mark - SharesViewModelDelegate

- (void)viewModel:(id)ViewModel arrayFromServer:(NSArray *)array{

    self.viewModel = ViewModel;
    [self.viewModel updateTableView:self.tableView];
}

#pragma mark - web delegate

- (void)exitWebView:(id)controller{

    UIViewController *vc = controller;
    [vc.navigationController popViewControllerAnimated:YES];
}

- (void)startLoad{

    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/promo/%@",@(_model.sharesID)] withCallBack:^(BOOL success, NSDictionary *resault) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (success) {
                
               // [self.navigationController pushViewController:vc animated:YES];
            }
        });
        
    }];
}
- (void)exitTutorialViewController:(id)controller{
    
    DTutorialViewController * vc = controller;
    [vc.navigationController popViewControllerAnimated:YES];
}
@end

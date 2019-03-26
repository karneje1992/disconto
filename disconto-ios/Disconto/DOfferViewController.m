//
//  DOfferViewController.m
//  Disconto
//
//  Created by Rostislav on 1/10/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DOfferViewController.h"
#import "DOfferViewModel.h"
#import "DSingleOfferViewController.h"
#import "DSingleOfferViewModel.h"

@interface DOfferViewController () <DTutorialViewControllerDelegate>

@property DOfferViewModel *viewModel;
@end

@implementation DOfferViewController


+ (instancetype)showOffersWithViewModel:(id)viewModel{
    
    return [[DOfferViewController alloc] initWithNibName:NSStringFromClass([DOfferViewController class]) bundle:nil viewModel:viewModel];
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
    [_viewModel updateViewController:self];
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
    
    return tableView.bounds.size.width*0.5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.viewModel.offersArray[indexPath.row].instuctions ? self.viewModel.cellsArray[indexPath.row] : [[[self.viewModel.cellsArray reverseObjectEnumerator] allObjects] mutableCopy][indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([self.viewModel.offersArray[indexPath.row] FCModel]) {
//    
//                                [self.navigationController pushViewController:[DSingleOfferViewController showSingleOfferWithViewModel:[DSingleOfferViewModel showSingleOffer:self.viewModel.offersArray[indexPath.row]]] animated:YES];
//    }else{
    
        [self.viewModel.offersArray[indexPath.row] getFullOfferWithOffer:self.viewModel.offersArray[indexPath.row] callback:^(DOfferModel *offer) {
            
//            if ([offer FCModel]) {
//                
//            }else{
                
                if ([[offer instuctions] count]) {
                    
                    DTutorialViewController *vc = [DTutorialViewController showOfferInstruction:offer];
                    vc.delegate = self;
                    [self.navigationController pushViewController:vc animated:NO];
                    
                }else{
                    
                    if ([offer gameID]) {
                        
                        [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/games/%@",self.viewModel.offersArray[indexPath.row].gameID] withCallBack:^(BOOL success, NSDictionary *resault) {
                            
                            if (success) {
                                
                                DCircleViewController *vc = [DCircleViewController showCircleViewContrlllerWithModel:[[DCircleViewModel alloc] initWithParammetr:@{@"background":resault[@"data"][@"background"],@"image":resault[@"data"][@"image"],@"angle":resault[@"data"][@"angle"],@"pointer":resault[@"data"][@"pointer"],@"message":resault[@"data"][@"message"],@"label":resault[@"data"][@"label"],@"logo":resault[@"data"][@"logo"],@"id":resault[@"data"][@"id"]}]];
                                vc.gemeID = offer.gameID;
                                vc.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:vc animated:NO];
                            }
                        }];
                    }else{
                        
                        [self.navigationController pushViewController:[DSingleOfferViewController showSingleOfferWithViewModel:[DSingleOfferViewModel showSingleOffer:offer]] animated:YES];
                    }
                    
                }
          //  }
        }];
//    }



//    if ([[[[self.viewModel.offersArray reverseObjectEnumerator] allObjects] mutableCopy][indexPath.row] instuctions]) {
//        if ([self.viewModel.offersArray[indexPath.row] FCModel]) {
//
//            [self.navigationController pushViewController:[DSingleOfferViewController showSingleOfferWithViewModel:[DSingleOfferViewModel showSingleOffer:[[[self.viewModel.offersArray reverseObjectEnumerator] allObjects] mutableCopy][indexPath.row]]] animated:YES];
//        }else{
//
//            [[[[self.viewModel.offersArray reverseObjectEnumerator] allObjects] mutableCopy][indexPath.row] getFullOfferWithOffer:[[[self.viewModel.offersArray reverseObjectEnumerator] allObjects] mutableCopy][indexPath.row] callback:^(DOfferModel *offer) {
//
//                if (![offer.gameID isEqual:[NSNull null]]) {
//
//                    if (offer.instuctions.count) {
//                        DTutorialViewController *vc = [DTutorialViewController showOfferInstruction:offer];
//                        vc.delegate = self;
//                        [self.navigationController pushViewController:vc animated:NO];
//                    }else{
//
//                        if (offer.gameID) {
//
//                            [NetworkManeger sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/games/%@",offer.gameID] withCallBack:^(BOOL success, NSDictionary *resault) {
//
//                                if (success) {
//
//                                    DCircleViewController *vc = [DCircleViewController showCircleViewContrlllerWithModel:[[DCircleViewModel alloc] initWithParammetr:@{@"background":resault[@"data"][@"background"],@"image":resault[@"data"][@"image"],@"angle":resault[@"data"][@"angle"],@"pointer":resault[@"data"][@"pointer"],@"message":resault[@"data"][@"message"],@"label":resault[@"data"][@"label"],@"logo":resault[@"data"][@"logo"],@"id":resault[@"data"][@"id"]}]];
//                                    vc.gemeID = offer.gameID;
//                                    vc.hidesBottomBarWhenPushed = YES;
//                                    [self.navigationController pushViewController:vc animated:NO];
//                                }
//                            }];
//                        }else{
//                            [self.navigationController pushViewController:[DSingleOfferViewController showSingleOfferWithViewModel:[DSingleOfferViewModel showSingleOffer:offer]] animated:YES];
//                        }
//                    }
//
//                }else{
//
//                                                [self.navigationController pushViewController:[DSingleOfferViewController showSingleOfferWithViewModel:[DSingleOfferViewModel showSingleOffer:offer]] animated:YES];
//                }
//            }];
//        }
//    }else{
//
//        if ([[[[self.viewModel.offersArray reverseObjectEnumerator] allObjects] mutableCopy][indexPath.row] FCModel]) {
//
//            [self.navigationController pushViewController:[DSingleOfferViewController showSingleOfferWithViewModel:[DSingleOfferViewModel showSingleOffer:[[[self.viewModel.offersArray reverseObjectEnumerator] allObjects] mutableCopy][indexPath.row]]] animated:YES];
//        }else{
//
//            [[[[self.viewModel.offersArray reverseObjectEnumerator] allObjects] mutableCopy][indexPath.row] getFullOfferWithOffer:[[[self.viewModel.offersArray reverseObjectEnumerator] allObjects] mutableCopy][indexPath.row] callback:^(DOfferModel *offer) {
//
//                if (offer) {
//
//                    if (offer.instuctions.count) {
//                        DTutorialViewController *vc = [DTutorialViewController showOfferInstruction:offer];
//                        vc.delegate = self;
//                        [self.navigationController pushViewController:vc animated:NO];
//                    }else{
//                        [self.navigationController pushViewController:[DSingleOfferViewController showSingleOfferWithViewModel:[DSingleOfferViewModel showSingleOffer:offer]] animated:YES];
//                    }
//
//                }
//            }];
//        }
//    }

}

#pragma mark - DTutorialViewControllerDelegate

- (void)exitTutorialViewController:(id)controller{
    
    DTutorialViewController * vc = controller;
    //    DOfferModel *offer = vc.offer;
    [vc.navigationController popViewControllerAnimated:YES];
    //
    //    if (![offer.gameID isEqual:[NSNull null]]) {
    //
    //        [NetworkManeger sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/games/%@",offer.gameID] withCallBack:^(BOOL success, NSDictionary *resault) {
    //
    //            if (success) {
    //
    //                DCircleViewController *vc = [DCircleViewController showCircleViewContrlllerWithModel:[[DCircleViewModel alloc] initWithParammetr:@{@"background":resault[@"data"][@"background"],@"image":resault[@"data"][@"image"],@"angle":resault[@"data"][@"angle"],@"pointer":resault[@"data"][@"pointer"],@"message":resault[@"data"][@"message"],@"label":resault[@"data"][@"label"],@"logo":resault[@"data"][@"logo"],@"id":resault[@"data"][@"id"]}]];
    //                vc.gemeID = offer.gameID;
    //                vc.hidesBottomBarWhenPushed = YES;
    //                [self.navigationController pushViewController:vc animated:NO];
    //            }
    //        }];
    //    }else{
    //
    //        [self.navigationController pushViewController:[DSingleOfferViewController showSingleOfferWithViewModel:[DSingleOfferViewModel showSingleOffer:offer]] animated:YES];
    //    }
    //
}
@end

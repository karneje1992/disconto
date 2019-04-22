//
//  DMoneyViewController.m
//  Disconto
//
//  Created by user on 30.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DMoneyViewController.h"
#import "DNewChangePhoneRoute.h"
#import "DPaymentRoute.h"
#import "DPaymentPresenter.h"
#import "DPaymentIterator.h"

@interface DMoneyViewController ()

@property DUserModel *user;
@property NSArray<DPayType *> *cellsArray;
@property NSInteger inProgress;
@property float balance;
@property float pending;
@property DNewChangePhoneRoute *changePhoneModule;
@end

@implementation DMoneyViewController

+ (instancetype)showMoneyControllerWithUser:(DUserModel *)user{
    
    return [[DMoneyViewController alloc] initWithNibName:NSStringFromClass([DMoneyViewController class]) bundle:nil andUserModel:user];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andUserModel:(DUserModel *)user
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.cellsArray = @[];
        self.user = user;
        SHOW_PROGRESS;
        [DPayType getPayWithCallBack:^(NSArray<DPayType *> *resault, float pending, float balance) {
            
            self.balance = balance;
            self.pending = pending;
            
            [self.delegate presentMoney:balance pading:pending];
            self.cellsArray = resault;
            self.changePhoneModule = [[DNewChangePhoneRoute alloc] initRootViewController:self];
            [self.tableView reloadData];
        }];
        
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

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return self.cellsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DPayListTableViewCell *cell = [DPayListTableViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DPayListTableViewCell class])];

    [cell updateWithPayType:self.cellsArray[indexPath.section] andIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];

    header.backgroundColor = tableView.backgroundColor;
//    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.cellsArray[indexPath.section].payMin <= self.balance) {
            
            [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{kServerType:self.cellsArray[indexPath.section].moneyType} andAPICall:apiMoneyOut withCallBack:^(BOOL success, NSDictionary *resault) {
                
                if (success) {
                    
                    SHOW_PROGRESS;
                    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
                        
                        if (resault.verifications.count > 0) {
                            
                            for (DVerificationModel *item in resault.verifications) {
                                if ([item.verificationType isEqualToString:kPhoneType]) {
                                    //activeteCode
                                    [self activeteCode];
                                }else{
                                
                                    DVeryFaryMailController *mailVC = [DVeryFaryMailController showVeryFaryEmailWithUser:self.user code:item.verificationID];
                                    mailVC.delegate = self;
                                    mailVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                                    [self.navigationController presentViewController:mailVC animated:NO completion:nil];

                                }
                            }
                        }else if(resault.userPhone.length < 1){
                            
                            [self activeteCode];
                        }else{
                        
//                            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/payment/prepare/%@?UID=%@&device_id=%@&token=%@",SERVER,self.cellsArray[indexPath.section].moneyType,TOKEN,DEVICEUUID,DEVICEUUID]];
//
//                            DShowWebSiteController *vc = [DShowWebSiteController showWebViewWithURL:url];
//                            vc.delegate = self;
//                            vc.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:vc animated:YES];
                            [self paymentActionWithIndexPath:indexPath];

                            
                        }
                        
                        HIDE_PROGRESS;
                    }];

                }
            }];
        }else{
            
            NSString *message = [NSString stringWithFormat:@"У Вас недостаточно средств! Минимальная сумма для вывода %@ руб.",@(self.cellsArray[indexPath.section].payMin)];
          //  SHOW_MESSAGE(nil,message);
            SHOW_MESSAGE(message, nil);
        }
}

- (void)activeteCode{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.changePhoneModule showChangePhoneModuleWithRootController:self];
    });
}


- (void)paymentActionWithIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger intType = 0;
    NSString *payType = [self.cellsArray[indexPath.section] moneyType];
    
    if ([payType isEqualToString:@"cards"]) {
        
        intType = 0;
    } else if ([payType isEqualToString:@"mobile"]){
        
        intType = 1;
    }else{
    
        intType = 2;
    }
    
    DPaymentRoute *route = [DPaymentRoute activeModuleWithType:intType rootViewController:self];
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{} andAPICall:@"/payment/current" withCallBack:^(BOOL success, NSDictionary *resault) {
        
        dispatch_async(dispatch_get_main_queue(), ^{

            if (success) {
                if ([resault[@"data"][@"what"] isEqualToString:self.cellsArray[indexPath.section].moneyType]) {
                    [route showModuleWithMin:self.cellsArray[indexPath.section].payMin max:self.cellsArray[indexPath.section].payMax comision:self.cellsArray[indexPath.section].commission imageView:[[UIImageView alloc] initWithImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.cellsArray[indexPath.section].iconUrl]]]]];
                    
                    [route setParamsDictionary:resault[@"data"]];
                }else{
                
                     [route showModuleWithMin:self.cellsArray[indexPath.section].payMin max:self.cellsArray[indexPath.section].payMax comision:self.cellsArray[indexPath.section].commission imageView:[[UIImageView alloc] initWithImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.cellsArray[indexPath.section].iconUrl]]]]];
                }

            } else {
                
                [route showModuleWithMin:self.cellsArray[indexPath.section].payMin max:self.cellsArray[indexPath.section].payMax comision:self.cellsArray[indexPath.section].commission imageView:[[UIImageView alloc] initWithImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.cellsArray[indexPath.section].iconUrl]]]]];
            }
        });

    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return tableView.bounds.size.height*0.3;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)sended{
    
    [self activeteCode];
}

- (void)exit{

}

- (void)startLoad{

}

- (void)exitWebView:(id)controller{

    UIViewController *vc = controller;
    [vc.navigationController popViewControllerAnimated:YES];
}

- (void)changePhoneFromController:(UIViewController *)controller{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    DChangePhoneViewController *vc = [DChangePhoneViewController changePhone:self.user.userPhone];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.delegate = self;
    [self.navigationController presentViewController:vc animated:NO completion:nil];
    
}

- (void)exitPhoneFromController:(UIViewController *)controller{

    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)activeCode{
    
    SHOW_PROGRESS;
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        self.user = resault;
        for (DVerificationModel *item in resault.verifications) {
            if ([item.verificationType isEqualToString:kPhoneType]) {
                self.user.userPhone = item.phoneNew;
                DCodeViewController *vc = [[DCodeViewController alloc] initWithNibName:@"DCodeViewController" bundle:nil];
                vc.delegate = self;
                vc.phone = self.user.userPhone;
                vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self.navigationController presentViewController:vc animated:NO completion:nil];
                
            }else{
                self.user.userEmail = item.emailNew;
            }
        }
        HIDE_PROGRESS;
    }];
    
}
@end

//
//  MenuViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "MenuViewController.h"
#import "DMenuTableViewCell.h"
#import "MVVMCategoryViewController.h"

@implementation MenuViewController



- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    [self.tableView setBackgroundColor:SYSTEM_COLOR];
    self.cellsArray = @[].mutableCopy;
    self.settingsCells = @[].mutableCopy;
    self.exitCells = @[].mutableCopy;

    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 180)];
    self.label.alpha = 0;
    self.label.numberOfLines = 2;
    self.label.text = [NSString stringWithFormat:@"Версия\n%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = UIColor.whiteColor;
    [self initCells];
    [[self tableView] reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return menuCountSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case menuDefaultSection:
            return self.cellsArray.count;
        case menuSettingsSection:
            return _settingsCells.count;
        default:
            return _exitCells.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case menuDefaultSection:
            return self.cellsArray[indexPath.row];
        case menuSettingsSection:
            return _settingsCells[indexPath.row];
        default:
            return _exitCells[indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return section == menuDefaultSection ? 100 : 20;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        
        return self.label;
    } else {
        
        UIView *empty = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 180)];
        empty.alpha = 0;
        return empty;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        return 180;
    } else {
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] init];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    if (section == menuDefaultSection) {
        
        [headerView setFrame:CGRectMake(0, 0, tableView.bounds.size.width, 100)];
        UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.revealViewController.rearViewRevealWidth*0.25, 0, headerView.bounds.size.width*0.5, headerView.bounds.size.height)];
        headerImageView.image = [UIImage imageNamed:@"logo"];
        [headerImageView setContentMode:UIViewContentModeScaleAspectFit];
        
        
        [headerView addSubview:headerImageView];
    }else{
        
        [headerView setFrame:CGRectMake(0, 0, 0, 20)];
        
        [headerView setBackgroundColor:[UIColor clearColor]];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 1)];
        [lineView setBackgroundColor:[UIColor whiteColor]];
        [headerView addSubview:lineView];
    }
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case menuDefaultSection:
            
            switch (indexPath.row) {
                case 0:
                    [self performSegueWithIdentifier:@"MVVMCategoryViewController" sender:segueDefault];
                    break;
                case 1:
                    [self performSegueWithIdentifier:@"showHistory" sender:segueDefault];
                    break;
//                case 1:
//                    [self performSegueWithIdentifier:@"DSharesController" sender:segueDefault];
//                    break;
//                case 3:
//                    [self performSegueWithIdentifier:@"DCuponViewController" sender:segueDefault];
//                    break;
                default:
                    [self performSegueWithIdentifier:@"DCacheViewController" sender:segueDefault];
                    break;
            }
            break;
            
            case menuSettingsSection:
            switch (indexPath.row) {

                case 0:{
                    
                    [self performSegueWithIdentifier:@"DReadMessageViewController" sender:segueDefault];
                }
                    break;
                    
                case 1:{
                    
                    [self performSegueWithIdentifier:@"DProfileViewController" sender:segueDefault];
//                    [self performSegueWithIdentifier:NSStringFromClass([[(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController visibleViewController].childViewControllers.lastObject.childViewControllers.lastObject class]) sender:@(segueSettings)];
                    
                }
                    break;
                case 2:{
                    [self performSegueWithIdentifier:@"DSendToSupportController" sender:segueDefault];
//                    [self performSegueWithIdentifier:NSStringFromClass([[(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController visibleViewController].childViewControllers.lastObject.childViewControllers.lastObject class]) sender:@(segueSupport)];
                    
                }
                    break;
                case 3:{
                    
                    [self performSegueWithIdentifier:NSStringFromClass([[(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController visibleViewController].childViewControllers.lastObject.childViewControllers.lastObject class]) sender:@(999)];
                    
                }
                    break;

                default:
                    break;
            }
            break;
            
        default:{
            
            switch (indexPath.row) {
                case 0:
                    [DSuperViewController logOut];
                    break;
                    
                default:
                    break;
            }
            break;
        }
    }
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 180)];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//
//    return  0;
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    switch ([sender integerValue]) {
            
        case segueSettings:
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                MVVMSettingsViewController *vc = [MVVMSettingsViewController showSettingsWithModelView:[DSettingsViewModel new]];
                [[(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController visibleViewController].childViewControllers.lastObject.childViewControllers.lastObject.navigationController pushViewController:vc animated:NO];
            });
            break;
        case segueSupport:
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
                [[(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController visibleViewController].childViewControllers.lastObject.childViewControllers.lastObject.navigationController pushViewController:vc animated:NO];
                
            });
            break;
        case 999:{
            self.label.alpha = 1;
            [self performSelector:@selector(hideInfo) withObject:nil afterDelay:5.0];
//            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Версия" message:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] preferredStyle:UIAlertControllerStyleAlert ];
//
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//                [alertVC dismissViewControllerAnimated: YES completion:nil];
//            }];
//
//            [alertVC addAction: cancel];
//
//            UIViewController *presentVC = [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController visibleViewController].childViewControllers.lastObject.childViewControllers.lastObject.navigationController.childViewControllers.firstObject;
//
//            [presentVC presentViewController: alertVC animated:YES  completion:nil];
            
        }break;
        default:

            break;
    }
}

#pragma mark state preservation / restoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
}


- (void)initCells{
    
//    DMenuTableViewCell *categoryCell = [DMenuTableViewCell getCellForTableView:self.tableView andClassCellString:NSStringFromClass([DMenuTableViewCell class])];
//    categoryCell.iconImageView.image = [UIImage imageNamed:@"lock"];
//    categoryCell.titleLabel.text = @"Дисконты";
//    [_cellsArray addObject:categoryCell];
    
//    DMenuTableViewCell *shopCell = [DMenuTableViewCell getCellForTableView:self.tableView andClassCellString:NSStringFromClass([DMenuTableViewCell class])];
//    shopCell.iconImageView.image = [UIImage imageNamed:@"bag"];
//    shopCell.titleLabel.text = @"Магазины";
//    [_cellsArray addObject:shopCell];
    
    DMenuTableViewCell *shareCell = [DMenuTableViewCell getCellForTableView:self.tableView andClassCellString:NSStringFromClass([DMenuTableViewCell class])];
    shareCell.iconImageView.image = [UIImage imageNamed:@"mid"];
    shareCell.titleLabel.text = @"Акции";
    [_cellsArray addObject:shareCell];
    
    DMenuTableViewCell *couponCell = [DMenuTableViewCell getCellForTableView:self.tableView andClassCellString:NSStringFromClass([DMenuTableViewCell class])];
    couponCell.iconImageView.image = [UIImage imageNamed:@"receipt"];
    couponCell.titleLabel.text = @"Чеки";
    [_cellsArray addObject:couponCell];
    
    DMenuTableViewCell *moneyCell = [DMenuTableViewCell getCellForTableView:self.tableView andClassCellString:NSStringFromClass([DMenuTableViewCell class])];
    moneyCell.iconImageView.image = [UIImage imageNamed:@"cash"];
    moneyCell.titleLabel.text = @"Кошелек";
    [_cellsArray addObject:moneyCell];
    
//    DMenuTableViewCell *profileCell = [DMenuTableViewCell getCellForTableView:self.tableView andClassCellString:NSStringFromClass([DMenuTableViewCell class])];
//    profileCell.iconImageView.image = [UIImage imageNamed:@"profile"];
//    profileCell.titleLabel.text = @"Профиль";
    
//    [_settingsCells addObject:profileCell];
    
    DMenuTableViewCell *messageCell = [DMenuTableViewCell getCellForTableView:self.tableView andClassCellString:NSStringFromClass([DMenuTableViewCell class])];
    messageCell.iconImageView.image = [UIImage imageNamed:@"message"];
    messageCell.titleLabel.text = @"Сообщения";
    
    [_settingsCells addObject:messageCell];
    
    DMenuTableViewCell *menuCell = [DMenuTableViewCell getCellForTableView:self.tableView andClassCellString:NSStringFromClass([DMenuTableViewCell class])];
    menuCell.iconImageView.image = [UIImage imageNamed:@"profile"];
    menuCell.titleLabel.text = @"Профиль";
    
    [_settingsCells addObject:menuCell];
    
    DMenuTableViewCell *supCell = [DMenuTableViewCell getCellForTableView:self.tableView andClassCellString:NSStringFromClass([DMenuTableViewCell class])];
    supCell.iconImageView.image = [UIImage imageNamed:@"contactAdmin"];
    supCell.titleLabel.text = titleSupport;
    
    [_settingsCells addObject:supCell];
    
    DMenuTableViewCell *infoCell = [DMenuTableViewCell getCellForTableView:self.tableView andClassCellString:NSStringFromClass([DMenuTableViewCell class])];
    infoCell.iconImageView.image = [UIImage imageNamed:@"info"];
    infoCell.titleLabel.text = @"Информация";
    
    [_settingsCells addObject:infoCell];
    
    DMenuTableViewCell *logoutCell = [DMenuTableViewCell getCellForTableView:self.tableView andClassCellString:NSStringFromClass([DMenuTableViewCell class])];
    logoutCell.iconImageView.image = [UIImage imageNamed:imgExit];
    logoutCell.titleLabel.text = titleExit;
    
    [_exitCells addObject:logoutCell];
}

- (void)hideInfo {
    
    self.label.alpha = 0;
}

@end

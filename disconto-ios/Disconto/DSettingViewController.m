//
//  DSettingViewController.m
//  Disconto
//
//  Created by user on 25.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSettingViewController.h"

@interface DSettingViewController ()<DTutorialViewControllerDelegate>

@property DUserModel *user;
@property NSArray<DInputCell *> *cells;
@property NSArray <DCityModel *> *cityArray;
@property NSMutableArray<UITextField *> *textFieldArray;
@property(strong,nonatomic) UIActionSheet *cityActionSheet;
@property DVeryFaryMailController *mailVC;
//@property DActiveCodeViewController *phoneVC;
//@property DCityController *cityVC;

@end

@implementation DSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cells = @[];
    self.view.backgroundColor = SYSTEM_COLOR;
    self.textFieldArray = @[].mutableCopy;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self loadProfileData];
    
}

- (void)save{
    
    [self.view endEditing:YES];
    [self userUpdated];
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if ([DUserModel compareOldUserModel:resault andCurrentUserModel:self.user]) {
                
                [DUserModel saveNewValuesFromUser:self.user andCallBack:^(DUserModel *server) {
                    
                    
                    [self loadProfileData];
                    
                    self.navigationItem.rightBarButtonItem.enabled = NO;
                }];
            }else{
                
                [self.navigationItem.rightBarButtonItem setEnabled:NO];
            }
            
           // SHOW_MESSAGE(savedUserDataAlert, nil);
            [self showAlertWithTitle:nil message:savedUserDataAlert];
        });
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.title = titleSettings;
    HIDE_PROGRESS;
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (IBAction)changePassword:(id)sender {
    
    DChangePasswordViewController *vc = [[DChangePasswordViewController alloc] initWithNibName:NSStringFromClass([DChangePasswordViewController class]) bundle:nil];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.navigationController presentViewController:vc animated:NO completion:nil];
}

- (IBAction)showTutorial:(id)sender {
    
    DTutorialViewController *vc = [DTutorialViewController showTutorialWithImgArray:[DSuperViewController getTutorial] andShowButton:NO];
    vc.delegate = self;
   
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)showLicens:(id)sender {
    DShowWebSiteController *vc = [DShowWebSiteController showWebViewWithURL:[NSURL URLWithString:@"https://disconto.me/terms/"]];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)logOut:(id)sender {
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{} andAPICall:@"/logout" withCallBack:^(BOOL success, NSDictionary *resault) {
        
        if (success) {
            [DSuperViewController logOut];
        }
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DInputCell *cell = self.cells[indexPath.row];
    cell.settingEditTextField.delegate = self;
    [self.textFieldArray addObject:cell.settingEditTextField];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (void)getCityFromServer{
    
    [DCityModel getCitesArraWithServerWithCallBack:^(NSArray *resault) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            [self.view endEditing:YES];
//            self.cityVC = [DCityController showCityListWithArray:resault];
//            self.cityVC.delegate = self;
//            self.cityVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//            [self.navigationController presentViewController:self.cityVC animated:YES completion:nil];
        });
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if ([self.textFieldArray lastObject] == textField) {
        [self.view endEditing:YES];
        [self getCityFromServer];
        return NO;
    }
    
    if (self.textFieldArray[2] == textField) {
        [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
            self.user = resault;
           
            if ([resault.verifications count]) {
                [self activeCode];
            }else{
                
                DChangeEmailViewController *vc = [DChangeEmailViewController changeEmail:[resault.verifications firstObject].emailNew];
                vc.delegete = self;
                vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self.navigationController presentViewController:vc animated:NO completion:nil];
            }
        }];
        
        return NO;
        
    }
    
    if (self.textFieldArray[3] == textField) {
        
        [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
            self.user = resault;
            if ([resault.verifications count]) {
                [self activeCode];
            }else{
                
                DChangePhoneViewController *vc = [DChangePhoneViewController changePhone:textField.text];
                vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                vc.delegate = self;
                [self.navigationController presentViewController:vc animated:NO completion:nil];
            }
        }];
        return NO;
        
    }
    return NO;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    return YES;
}

- (void)selctedCity:(DCityModel *)cityModel{
    
    [self.user setUserCityID:[cityModel.cityID integerValue]];
    [self.user setUserCityName:cityModel.cityTitle];
    self.cells = [DUserModel getCellsArrayWithUserModel:self.user andTableView:self.tableView andController:self];
    [self.tableView reloadData];
}

- (void)userUpdated{
    
    self.user.userFirsName = self.cells[qfirstName].settingEditTextField.text;
    self.user.userLastName = self.cells[qlastName].settingEditTextField.text;
}

- (void)sended{
    
    SHOW_PROGRESS;
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        self.user = resault;
        
        [self loadProfileData];
        [self activeCode];
        HIDE_PROGRESS;
    }];
    
}

- (void)changePhoneFromController:(UIViewController *)controller{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    DChangePhoneViewController *vc = [DChangePhoneViewController changePhone:self.textFieldArray[3].text];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.delegate = self;
    [self.navigationController presentViewController:vc animated:NO completion:nil];
    
}

#pragma mark - mail veryFary

- (void)changeEmail{
    
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        self.user = resault;
        [self loadProfileData];
        DChangeEmailViewController *vc = [DChangeEmailViewController changeEmail:resault.userEmail];
        vc.delegete = self;
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.navigationController presentViewController:vc animated:NO completion:nil];
    }];
}

- (void)toSupp{
    
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.alternative = YES;
    [self presentViewController:navController animated:NO completion:nil];
}

- (void)resend{
    
    //    [DUserModel resendToUser:self.user withCallBack:^(BOOL succsess) {
    //
    //        SHOW_MESSAGE(@"На вашу почту отправлено сообщение для подтверждения", nil);
    //    }];
}

- (void)loadProfileData{
    
    SHOW_PROGRESS;
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        self.user = resault;
        
        if (resault.verifications.count > 0) {
            
            
            [self activeCode];
            
        }
        self.cells = [DUserModel getCellsArrayWithUserModel:self.user andTableView:self.tableView andController:self];
        [self.tableView reloadData];
        
        HIDE_PROGRESS;
    }];
}

- (void)exit{
    [self loadProfileData];
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
                DVeryFaryMailController *vc = [DVeryFaryMailController showVeryFaryEmailWithUser:resault code:item.verificationID];
                vc.delegate = self;
                vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self.navigationController presentViewController:vc animated:NO completion:nil];
            }
        }
        self.cells = [DUserModel getCellsArrayWithUserModel:self.user andTableView:self.tableView andController:self];
        [self.tableView reloadData];
        HIDE_PROGRESS;
    }];
    
}

#pragma mark - change Email

- (void)controller:(id)controller isChanged:(BOOL)isChanged{
    
    if (isChanged) {
        [controller dismissViewControllerAnimated:YES completion:nil];
        [self activeCode];
    }
}

- (void)exitPhoneFromController:(UIViewController *)controller{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    [self loadProfileData];
}

- (void)exitWebView:(id)controller{

    UIViewController *vc = controller;
    [vc.navigationController popViewControllerAnimated:YES];
}

- (void)startLoad{

}

#pragma mark - DTutorialViewControllerDelegate

- (void)exitTutorialViewController:(id)controller{
    
    DTutorialViewController * vc = controller;
    [vc.navigationController popViewControllerAnimated:YES];
}
@end

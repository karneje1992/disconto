//
//  DSettingsViewModel.m
//  Disconto
//
//  Created by Rostislav on 09.12.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSettingsViewModel.h"
#import "CCTextFieldEffects.h"
#import "DUserDataViewCell.h"
#import "DNewChangePhoneRoute.h"

static NSString *const plaseHolderFirstName = @"Имя";
static NSString *const plaseHolderLastName = @"Фамилия";
static NSString *const plaseHolderCityName = @"Введите город";
static NSString *const plaseHolderEmail = @"Адрес электронной почты";
static NSString *const plaseHolderPhone= @"Телефон";

@interface DSettingsViewModel()<DTutorialViewControllerDelegate>

@property DUserModel *userModel;
@property NSMutableArray<DCityModel *> *cityArray;
@property UIPickerView *picker;
@property NSString *cityID;
@property UITextField *activeTextField;
@property DNewChangePhoneRoute *changePhoneModule;
@end

@implementation DSettingsViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)updateViewWithController:(UIViewController *)controller callBack:(void (^)(id model))callBack{
    SHOW_PROGRESS;
    self.cityArray = @[].mutableCopy;
    self.changePhoneModule = [[DNewChangePhoneRoute alloc] initRootViewController:controller];
    self.picker = [UIPickerView new];
    [self.picker setDataSource:self];
    [self.picker setDelegate:self];
    [self.picker setShowsSelectionIndicator:YES];
    [self.picker setBackgroundColor:[UIColor clearColor]];
    [self.picker setTintColor:[UIColor whiteColor]];
    self.cellsArray = @[];
    self.activeController = controller;
    
    [self.activeController.view setBackgroundColor:SYSTEM_COLOR];
    [self.activeController setTitle:@"Профиль"];
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.activeController.navigationItem.rightBarButtonItem = flipButton;
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Закрыть" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
                               //initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(back)];
    self.activeController.navigationItem.leftBarButtonItem = button;
    [[self getTableViewFromController:self.activeController] reloadData];
    
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        self.userModel = resault;
        
        if (resault.verifications.count > 0) {
            
            
            [self activeteCode];
        }
        [DCityModel getCitesArraWithServerWithCallBack:^(NSArray *resault) {
            
            self.cityArray = resault.mutableCopy;
            [self.picker reloadInputViews];
            
        }];
        
        
        [self initCells];
        [[self getTableViewFromController:self.activeController] reloadData];
        HIDE_PROGRESS;
        callBack(self);
    }];
    
}

- (void)changePhoneFromController:(UIViewController *)controller{

}

- (void)activeteCode{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Внимание!" message:changePhoneAlertText preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Отложить" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *next = [UIAlertAction actionWithTitle:@"Продолжить" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self.changePhoneModule showChangePhoneModuleWithRootController:self.activeController];
    }];
    
    [alertController addAction:next];
    [alertController addAction:cancel];
    [self.activeController presentViewController:alertController animated:YES completion:nil];
}

- (void)back{
    
    [self.activeController.view endEditing:YES];
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        if ([DUserModel compareOldUserModel:resault andCurrentUserModel:self.userModel]) {
            [[[UIAlertView alloc]initWithTitle:@"Сохранить изменения" message:@"" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil] show];
        }else{
            [self.activeController.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    
}

- (void)save{
    
    [self.activeController.view endEditing:YES];
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        if ([DUserModel compareOldUserModel:resault andCurrentUserModel:self.userModel]) {
            [DUserModel saveNewValuesFromUser:self.userModel andCallBack:^(DUserModel *server) {
                self.userModel = server;
              //  SHOW_MESSAGE(savedUserDataAlert, nil);
                [[DSuperViewController new] showAlertWithTitle:nil message:savedUserDataAlert];
            }];
        }else{
            
        }
        
    }];
    
}

- (void)activeCode{
    
    SHOW_PROGRESS;
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        self.userModel = resault;
        for (DVerificationModel *item in resault.verifications) {
            if ([item.verificationType isEqualToString:kPhoneType]) {
                self.userModel.userPhone = item.phoneNew;
                DCodeViewController *vc = [[DCodeViewController alloc] initWithNibName:@"DCodeViewController" bundle:nil];
                vc.delegate = self;
                vc.phone = self.userModel.userPhone;
                vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self.activeController.navigationController presentViewController:vc animated:NO completion:nil];
                
            }else{
                self.userModel.userEmail = item.emailNew;
                DVeryFaryMailController *vc = [DVeryFaryMailController showVeryFaryEmailWithUser:resault code:item.verificationID];
                vc.delegate = self;
                vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                [self.activeController.navigationController presentViewController:vc animated:NO completion:nil];
            }
        }
        HIDE_PROGRESS;
    }];
    
}

- (void)initCells{
    
    UITableView *tableView = [self getTableViewFromController:self.activeController];
    [tableView reloadData];
    DUserDataViewCell *fnCell = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
    DUserDataViewCell *lnCell = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
    DUserDataViewCell *emailCell = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
    DUserDataViewCell *phoneCell = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
    DUserDataViewCell *cityeCell = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
    self.cellsArray = @[fnCell,lnCell,emailCell,phoneCell,cityeCell];
    [self.cellsArray enumerateObjectsUsingBlock:^(DUserDataViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case 0:
            {
                
                [self addTextFieldToCell:fnCell withPlaceholder:plaseHolderFirstName];
            }
                break;
            case 1:
            {
                
                [self addTextFieldToCell:lnCell withPlaceholder:plaseHolderLastName];
            }
                break;
            case 2:
            {
                [self addTextFieldToCell:emailCell withPlaceholder:plaseHolderEmail];
                
            }
                break;
            case 3:
            {
                [self addTextFieldToCell:phoneCell withPlaceholder:plaseHolderPhone];
                
            }
                break;
            case 4:
            {
                
                [self addTextFieldToCell:cityeCell withPlaceholder: plaseHolderCityName];
            }
                break;
            default:
                break;
        }
    }];
}

- (void)addTextFieldToCell:(DUserDataViewCell *)cell withPlaceholder:(NSString *)placeholder{
    
    // Recommended frame height is around 70.
    HoshiTextField *hoshiTextField = [[HoshiTextField alloc] initWithFrame:cell.textFildView.bounds];
    
    hoshiTextField.placeholder = placeholder;
    
    // The size of the placeholder label relative to the font size of the text field, default value is 0.65
    hoshiTextField.placeholderFontScale = 0.5;
    
    // The color of the inactive border, default value is R185 G193 B202
    hoshiTextField.borderInactiveColor = [UIColor whiteColor];
    
    // The color of the active border, default value is R106 B121 B137
    hoshiTextField.borderActiveColor = [UIColor whiteColor];
    
    // The color of the placeholder, default value is R185 G193 B202
    hoshiTextField.placeholderColor = [UIColor whiteColor];
    
    // The color of the cursor, default value is R89 G95 B110
    hoshiTextField.cursorColor = [UIColor blueColor];
    
    // The color of the text, default value is R89 G95 B110
    hoshiTextField.textColor = [UIColor whiteColor];
    hoshiTextField.delegate = self;
    // The block excuted when the animation for obtaining focus has completed.
    // Do not use textFieldDidBeginEditing:
    hoshiTextField.didBeginEditingHandler = ^{
        // ...
    };
    
    // The block excuted when the animation for losing focus has completed.
    // Do not use textFieldDidEndEditing:
    hoshiTextField.didEndEditingHandler = ^{
        // ...
    };
    [hoshiTextField addTarget:hoshiTextField
                       action:@selector(resignFirstResponder)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    
    if ([placeholder isEqualToString:plaseHolderFirstName]) {
        [hoshiTextField setText:self.userModel.userFirsName];
    }
    if ([placeholder isEqualToString:plaseHolderLastName]) {
        [hoshiTextField setText:self.userModel.userLastName];
    }
    if ([placeholder isEqualToString:plaseHolderEmail]) {
        [hoshiTextField setText:self.userModel.userEmail];
    }
    if ([placeholder isEqualToString:plaseHolderPhone]) {
        [hoshiTextField setText:self.userModel.userPhone];
    }
    if ([placeholder isEqualToString:plaseHolderCityName]) {
        [hoshiTextField setText:self.userModel.userCityName];
        hoshiTextField.inputView = _picker;
    }
    
    [cell.textFildView addSubview:hoshiTextField];
}

- (UITableView *)getTableViewFromController:(UIViewController *)controller{
    
    for (UITableView *tableView in controller.view.subviews) {
        if ([tableView isKindOfClass:[UITableView class]]) {
            return tableView;
        }
    };
    return nil;
}

- (void)changeEmail{
    
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        self.userModel = resault;
        DChangeEmailViewController *vc = [DChangeEmailViewController changeEmail:resault.userEmail];
        vc.delegete = self;
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.activeController.navigationController presentViewController:vc animated:NO completion:nil];
    }];
}

- (void)toSupp{
    
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.alternative = YES;
    [self.activeController presentViewController:navController animated:NO completion:nil];
}

- (void)controller:(id)controller isChanged:(BOOL)isChanged{
    
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        self.userModel = resault;
        if (isChanged) {
            [controller dismissViewControllerAnimated:YES completion:nil];
            [self activeteCode];
        }
    }];
    
}

- (void)exitPhoneFromController:(UIViewController *)controller{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)exitWebView:(id)controller{
    
    UIViewController *vc = controller;
    [vc.navigationController popViewControllerAnimated:YES];
}

- (void)startLoad{
    
}

- (void)exit{
    
}

- (void)sended{
    
    [self activeteCode];
    
}

#pragma mark - UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _cityArray.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return _cityArray[row].cityTitle;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.activeTextField.text = self.cityArray[row].cityTitle;
    self.cityID = self.cityArray[row].cityID;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60.0f;
}

#pragma mark - UITextfield Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.activeTextField = textField;
    
    if ([textField.placeholder isEqualToString:plaseHolderEmail]) {
        [self changeEmail];
        return NO;
    }
    if ([textField.placeholder isEqualToString:plaseHolderPhone]) {
        

        [self activeteCode];

        return NO;
    }
    if ([textField.placeholder isEqualToString:plaseHolderCityName]) {
        
        textField.text = self.cityArray[0].cityTitle;
        self.cityID = self.cityArray[0].cityID;
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if ([textField.placeholder isEqualToString:plaseHolderFirstName]) {
        
        [self.userModel setUserFirsName:textField.text];
    }
    if ([textField.placeholder isEqualToString:plaseHolderLastName]) {
        [self.userModel setUserLastName:textField.text];
    }
    
    if ([textField.placeholder isEqualToString:plaseHolderCityName]){
        
        [self.cityArray enumerateObjectsUsingBlock:^(DCityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([textField.text isEqualToString:obj.cityTitle]) {
                
                [self.userModel setUserCityID:[obj.cityID integerValue]];
                [self.userModel setUserCityName:obj.cityTitle];
            }
        }];
    }
    return YES;
}

- (void)tuter{
    
    DTutorialViewController *vc = [DTutorialViewController showTutorialWithImgArray:[DSuperViewController getTutorial] andShowButton:NO];
    vc.delegate = self;
    [self.activeController.navigationController pushViewController:vc animated:NO];
}

- (void)showLicens {
    DShowWebSiteController *vc = [DShowWebSiteController showWebViewWithURL:[NSURL URLWithString:@"https://disconto.me/terms/"]];
    vc.delegate = self;
    [self.activeController.navigationController pushViewController:vc animated:NO];
}

- (void)changePassword {
    
    DChangePasswordViewController *vc = [[DChangePasswordViewController alloc] initWithNibName:NSStringFromClass([DChangePasswordViewController class]) bundle:nil];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.activeController.navigationController presentViewController:vc animated:NO completion:nil];
}

- (void)resend{
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"id":@(self.userModel.verifications.lastObject.verificationID)} andAPICall:@"/users/change/resend" withCallBack:^(BOOL success, NSDictionary *resault) {
        if (success) {
           // SHOW_MESSAGE(@"Подтвердите вашу почту", nil);
            [[DSuperViewController new] showAlertWithTitle:nil message:@"Подтвердите вашу почту"];
        }
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.activeController.view endEditing:YES];
    if (buttonIndex) {
        [self save];
    }
    [self.activeController.navigationController popViewControllerAnimated:YES];
}

- (void)exitTutorialViewController:(id)controller{
    
    DTutorialViewController * vc = controller;
    [vc.navigationController popViewControllerAnimated:YES];
}
@end

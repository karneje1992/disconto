 //
//  DRegistrationViewModel.m
//  DiscontoMVVM
//
//  Created by Rostislav on 30.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "DRegistrationViewModel.h"
#import "DUserDataViewCell.h"
#import "DEntranceViewController.h"
#import "DCityModel.h"
#import "ValidatorValues.h"
#import "NetworkManeger.h"
#import "DLoginViewModel.h"


@interface DRegistrationViewModel()

@property UIViewController *controller;
@property NSMutableArray<DCityModel *> *cityArray;
@property UIPickerView *picker;
@property UITextField *activeTextField;
@property TTTAttributedLabel *label;
//@property (strong, nonatomic) HoshiTextField *hoshiTextField;
@end

@implementation DRegistrationViewModel

- (instancetype)initWhithParametrs:(NSDictionary *)parametrs
{
    self = [super init];
    if (self) {
        self.cityArray = @[].mutableCopy;
        self.picker = [UIPickerView new];
        [self.picker setDataSource:self];
        [self.picker setDelegate:self];
        [self.picker setShowsSelectionIndicator:YES];
        [self.picker setBackgroundColor:[UIColor clearColor]];
        [self.picker setTintColor:[UIColor whiteColor]];
        [self setFirstName:parametrs[@"firstName"]];
        [self setLastName:parametrs[@"lastName"]];
        [self setEmail:parametrs[@"email"]];
        [self setSocID:parametrs[@"socID"]];
        [self setSocType:parametrs[@"socType"]];
        [self setRegistrationStep:enumNames];
        [DCityModel getCitesArraWithServerWithCallBack:^(NSArray *resault) {
            
            self.cityArray = resault.mutableCopy;
            [self.picker reloadInputViews];
        }];
        
    }
    return self;
}

- (void)setupUIWhithController:(UIViewController *)controller{
    
    self.cellArray = @[];
    UITableView *tableView = [self getTableViewFromController:controller];
    self.controller = controller;
    controller.navigationController.navigationBarHidden = NO;
    controller.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Далее" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction)];
    controller.navigationItem.rightBarButtonItem = rightButton;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        controller.navigationItem.leftBarButtonItem = back;
    
    _label = [self getLabelFromController:controller];
    [_label setDelegate:self];

    // [controller.navigationItem.rightBarButtonItem setEnabled:NO];
    switch (self.registrationStep) {
        case enumNames:{
            
            DUserDataViewCell *fnCell = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
            [self addTextFieldToCell:fnCell withPlaceholder:plaseHolderFirstName];
            DUserDataViewCell *lnCell = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
            [self addTextFieldToCell:lnCell withPlaceholder:plaseHolderLastName];
            self.cellArray = @[fnCell,lnCell];
        }
            break;
        case enumCitys:{
            DUserDataViewCell *cityCell = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
            [self addTextFieldToCell:cityCell withPlaceholder:plaseHolderCityName];
            self.cellArray = @[cityCell];
        }
            break;
        case enumEmail:{
            DUserDataViewCell *emailCell = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
            [self addTextFieldToCell:emailCell withPlaceholder:plaseHolderEmail];
            self.cellArray = @[emailCell];
            
            [_label setText:footerEmailText];
        }
            break;
        case enumPassword:{
            UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Готово" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction)];
            controller.navigationItem.rightBarButtonItem = rightButton;
           
            
            DUserDataViewCell *one = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
            [self addTextFieldToCell:one withPlaceholder:plaseHolderPass];
            DUserDataViewCell *two = [DUserDataViewCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
            [self addTextFieldToCell:two withPlaceholder:plaseHolderPassword2];
            self.cellArray = @[one,two];
            
            [_label setText:footerLastText];
            _label.enabledTextCheckingTypes = NSTextCheckingTypeLink;
            NSRange range = [_label.text rangeOfString:@"пользовательским соглашением"];
            [_label addLinkToURL:[NSURL URLWithString:@"https://disconto.me/terms/"] withRange:range];
            NSRange range2 = [_label.text rangeOfString:@"лицензионное соглашение"];
            [_label addLinkToURL:[NSURL URLWithString:@"https://disconto.me/license"] withRange:range2];
            NSRange range3 = [_label.text rangeOfString:@"политику конфиденциальности"];
            [_label addLinkToURL:[NSURL URLWithString:@"https://disconto.me/privacipolicy"] withRange:range3];
        }
            break;
        case enumFullRegistration:{
                    }
            break;
        default:
            break;
    }
}

- (void)back{

    [self.controller.view endEditing:YES];
    switch (self.registrationStep) {
        case enumNames:{
            
               }
            break;
        case enumCitys:{
            self.registrationStep = enumNames;
        }
            break;
        case enumEmail:{
           self.registrationStep = enumCitys;
        }
            break;
        case enumPassword:{
            self.registrationStep = enumEmail;
         
        }
            break;
        case enumFullRegistration:{
            self.registrationStep = enumPassword;
        }
            break;
        default:
            break;
    }
    
    [self.controller.navigationController popViewControllerAnimated:NO];
}

- (UITableView *)getTableViewFromController:(UIViewController *)controller{
    
    for (UITableView *tableView in controller.view.subviews) {
        if ([tableView isKindOfClass:[UITableView class]]) {
            return tableView;
        }
    };
    return nil;
}

- (TTTAttributedLabel *)getLabelFromController:(UIViewController *)controller{
    
    for (TTTAttributedLabel *label in controller.view.subviews) {
        if ([label isKindOfClass:[TTTAttributedLabel class]]) {
            return label;
        }
    };
    return nil;
}

- (void)addTextFieldToCell:(DUserDataViewCell *)cell withPlaceholder:(NSString *)placeholder{
    
    // Recommended frame height is around 70.
    HoshiTextField *hoshiTextField = [[HoshiTextField alloc] initWithFrame:cell.textFildView.bounds];
    
    hoshiTextField.placeholder = placeholder;
    
    // The size of the placeholder label relative to the font size of the text field, default value is 0.65
    hoshiTextField.placeholderFontScale = 1;
    
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
    
    switch (self.registrationStep) {
        case enumNames:{
            if ([hoshiTextField.placeholder isEqualToString:plaseHolderFirstName]) {
                
                hoshiTextField.text = self.firstName;
            }else if ([hoshiTextField.placeholder isEqualToString:plaseHolderLastName]){
                
                hoshiTextField.text = self.lastName;
            }
        }
            break;
        case enumCitys:{
            
            hoshiTextField.text = _cityName;
            hoshiTextField.inputView = _picker;
        }
            break;
        case enumEmail:{
            hoshiTextField.text = self.email;
            [hoshiTextField setKeyboardType:UIKeyboardTypeEmailAddress];
        }
            break;
        case enumPassword:{
            
            hoshiTextField.secureTextEntry = YES;
        }
            break;
        case enumFullRegistration:{
            
        }
            break;
        default:
            break;
    }
    [cell.textFildView addSubview:hoshiTextField];
}

- (void)doneAction{
    [self.controller.view endEditing:YES];
    self.cellArray = @[];
    switch (self.registrationStep) {
       
        case enumNames:{
            if (self.firstName && self.lastName) {
                
                self.registrationStep = enumCitys;
                [self.controller.navigationController pushViewController:[DEntranceViewController showEntranceViewControllerWithViewModel:self andShowSocButtons:NO] animated:NO];
            }else{
                
                [self error];
            }
            
        }
            break;
        case enumCitys:{
            
            if (self.cityID) {
                
                self.registrationStep = enumEmail;
                [self.controller.navigationController pushViewController:[DEntranceViewController showEntranceViewControllerWithViewModel:self andShowSocButtons:NO] animated:NO];
            }else{
                
                [self error];
            }
            
        }
            break;
        case enumEmail:{
            [ValidatorValues mailExist:self.email callBack:^(BOOL result) {
                
                if(result){
                    self.registrationStep = enumPassword;
                    [self.controller.navigationController pushViewController:[DEntranceViewController showEntranceViewControllerWithViewModel:self andShowSocButtons:NO] animated:NO];
                }else{
                
                    SHOW_MESSAGE(socRegMailError, nil);
                }
            }];

            
        }
            break;
        case enumPassword:{
            if ([self validPassword]) {
                self.registrationStep = enumFullRegistration;
                SHOW_PROGRESS;
                [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"email":self.email,@"password":self.password,@"first_name":self.firstName,@"last_name":self.lastName,@"city_id":self.cityID,@"soc_id":self.socID ? self.socID:@"",@"soc_type":self.socType ? self.socType:@""} andAPICall:apiRegistration withCallBack:^(BOOL success, NSDictionary *resault) {
                    
                    if (success) {
                        RESTART;
                        if (self.socType) {
                            
                            [[[DLoginViewModel alloc] initWhithParametrs:@{}] loginInSocialWithDictionary:@{kID:self.socID,kSocType:self.socType} callBack:^(NSDictionary *resault) {
                                
                            }];
                        }else{
                        
                            [[[DLoginViewModel alloc] initWhithParametrs:@{@"login":self.email,@"password":self.password}] sendLogin];
                        }
                       
                    }
                }];

            }
            
        }
            break;
        case enumFullRegistration:{
            
        }
            break;
        default:
            break;
    }
    
    
}

#pragma mark - UITextfield Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    self.activeTextField = textField;
    if (self.registrationStep == enumCitys) {
        textField.text = self.cityArray[0].cityTitle;
        self.cityID = self.cityArray[0].cityID;
        
    }
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    switch (self.registrationStep) {
        case enumNames:{
            if ([textField.placeholder isEqualToString:plaseHolderFirstName]) {
                self.firstName = textField.text ;
            }else  if ([textField.placeholder isEqualToString:plaseHolderLastName]){
                self.lastName = textField.text;
            }
        }
            break;
        case enumCitys:{
            
        }
            break;
        case enumEmail:{
            self.email = textField.text;
            //textField.text = self.email;
        }
            break;
        case enumPassword:{
            if ([textField.placeholder isEqualToString:plaseHolderPass]) {
                self.password = textField.text ;
            }else  if ([textField.placeholder isEqualToString:plaseHolderPassword2]){
                self.confermPassword = textField.text;
            }
            //textField.selected = YES;
        }
            break;
        case enumFullRegistration:{
            
        }
            break;
        default:
            break;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ( [string isEqualToString:@" "] && range.length==0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
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
    
    [self setCityName:self.cityArray[row].cityTitle];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60.0f;
}

- (BOOL)validPassword{
    
    if (![self.password isEqualToString:self.confermPassword]) {
        
        [[[UIAlertView alloc] initWithTitle:@"Пароли не совпадают" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return NO;
    }else if (self.password.length < 3 || self.confermPassword.length < 3){
        
        [[[UIAlertView alloc] initWithTitle:@"Пароли должны быть длиннее трех сиволов" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return NO;
    }else{
        
        return YES;
    }
}

- (void)error{
    
    [[[UIAlertView alloc] initWithTitle:@"Заполните все поля" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    
    DShowWebSiteController *vc = [DShowWebSiteController showWebViewWithURL:url];
    vc.delegate = self;
    [self.controller.navigationController pushViewController:vc animated:YES];
}

- (void)exitWebView:(id)controller{

    [self.controller.navigationController popViewControllerAnimated:YES];
}

- (void)startLoad{

}

- (void)getModelWithController:(UIViewController *)controller callBack:(void (^)(DRegistrationViewModel *model))callBack{
    
    [self setupUIWhithController:controller];
    callBack(self);
}
@end

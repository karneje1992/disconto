//
//  DNewChangePhonePresenter.m
//  Disconto
//
//  Created by Rostislav on 6/15/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DNewChangePhonePresenter.h"
#import "CCTextFieldEffects.h"
#import "DUserDataViewCell.h"

@interface DNewChangePhonePresenter ()

@property NSMutableArray<DUserDataViewCell *> *cells;
@property NSInteger status;
@property NSString *phoneNumber;
@property NSString *code;
@property UIBarButtonItem *helpButton;
@end

static NSString *const phonePlaceholder = @"Введите телефон:";
static NSString *const codePlaceholder = @"Введите код:";

@implementation DNewChangePhonePresenter


- (instancetype)initWithRoute:(id <DNewChangePhoneRouteProtocol>)route iterator:(DNewChangePhoneIterator *)iterator view:(DNewChangePhoneViewController *)view
{
    self = [super init];
    if (self) {
        
        self.view = view;
      //  self.route = route;
        self.iterator = iterator;
        self.view.presenter = self;
        self.cells = @[].mutableCopy;
    }
    return self;
}

#pragma mark - DNewChangePhonePresenterPotocol

- (void)updateUI{

    [self.iterator chackPhoneStatusCallBack:^(NSInteger status) {
        
        self.status = status;
        if (self.status == 0) {
            [self active];
        }else{
        
            [self changeButtonForStatus:status];
            [self initCellWithStatus:status];
        }

        self.view.tableView.delegate = self;
        self.view.tableView.dataSource = self;
        self.view.tableView.sectionFooterHeight = self.view.view.bounds.size.height*0.2;
        [self.view.tableView reloadData];
    }];
    
    if (self.view.navigationItem != nil) {
        
        [self.view.navigationItem setBackBarButtonItem:nil];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelChange)];
        [self.view.navigationItem setLeftBarButtonItem:backButton];
        
        [self.view.navigationItem setBackBarButtonItem:nil];
        self.helpButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(healpAction)];
        [self.view.navigationItem setRightBarButtonItem:self.helpButton];
        [self changeActionButton:NO];
        UIImage *img = [UIImage imageNamed:@"ico"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [imgView setImage:img];
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        self.view.navigationItem.titleView = imgView;
        
    }

    self.phoneNumber = @"";
    self.code = @"";
    [self addTapHandler];
    [self addKeyboardObservers];
    [self.helpButton setTitle:@"Помощь"];

}

- (void)healpAction{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Дисконто" message:@"Если возникли проблемы с изменением номера телефона выберите один из пунктов:" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelChange = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"%@", @"cancel");
    }];
    
    if (self.status <= 1) {
        
        UIAlertAction *resendChange = [UIAlertAction actionWithTitle:@"Отправить код еще раз" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.iterator resendCodeForStatus:self.status CallBack:^(NSInteger status) {
                
                [self initCellWithStatus:status];
                [self changeButtonForStatus: status];
            }];
            
        }];
        [alert addAction:resendChange];
    }
    
    UIAlertAction *supportChange = [UIAlertAction actionWithTitle:@"Обратиться в техподдержку" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
        [self.view.navigationController pushViewController:vc animated:YES];
    }];
    
    
    [alert addAction:supportChange];
    [alert addAction:cancelChange];
    [self.view presentViewController:alert animated:YES completion:nil];
}

- (void)cancelChange{

    [self.view.view endEditing:YES];
    if (self.status > 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Дисконто" message:@"Вы хотите отложить подтверждение номера телефона или отменить ?" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelChange = [UIAlertAction actionWithTitle:@"Отменить изменение" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [self.iterator discardeChangePhonecallBack:^(NSInteger status) {
                
                if (status >= 0) {
                    self.status = status;
                     [self.view.navigationController popViewControllerAnimated:YES];
                    
                }
            }];
            
        }];
        
        UIAlertAction *laterChange = [UIAlertAction actionWithTitle:@"Отложить изменение" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self.view.navigationController popViewControllerAnimated:YES];
        }];
        
        [alert addAction:cancelChange];
        [alert addAction:laterChange];
        [self.view presentViewController:alert animated:YES completion:nil];
    } else {
        
        [self.view.navigationController popViewControllerAnimated:YES];
    }

}

- (void)active{
    
    [self.view.view endEditing:YES];
        switch (self.status) {
                
            case 0:
            case -1:{
                
                [self.iterator sendOldPhone:self.phoneNumber apiKey:@"/users/phone/change/old" callBack:^(NSInteger type) {
                    
                    self.status = type;
                    if (self.status == 2) {
                        
                        [self changeButtonForStatus:self.status];
                        [self initCellWithStatus:self.status];
                    }
                    else if (self.status < 0){
                    
                        [self.view.navigationController popViewControllerAnimated:YES];
                    }
                    else{
                    
                        [self changeButtonForStatus:self.status];
                        [self initCellWithStatus:self.status];
                    }

                }];
            }
                break;
                
            case 2:{
                
                [self.iterator sendNewPhone:self.phoneNumber ? self.phoneNumber : self.iterator.phone apiKey:@"/users/phone/change/new" callBack:^(NSInteger type) {
                    
                    self.status = type;
                    [self changeButtonForStatus:self.status];
                    [self initCellWithStatus:self.status];
                }];
                
            }
                break;
            case 1:{
                                
                [self.iterator sendNewCode:self.code apiKey:@"/users/phone/verify/old" callBack:^(NSInteger status) {
                    self.status = status;
                    //[self initCellWithStatus:status];
                    [self changeButtonForStatus:self.status];
                    [self initCellWithStatus:self.status];
                    
                }];
            }
                break;
                
                
            default:{
                
                [self.iterator sendNewCode:self.code apiKey:@"/users/phone/verify/new" callBack:^(NSInteger status) {
                    
                    [[[UIAlertView new] initWithTitle:@"Дисконто" message:@"Ваш телефон успешно сохранен" delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles: nil] show];
                    
                    [self.view.navigationController popToRootViewControllerAnimated:YES];
                }];
                
            }
                break;
        }

}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return self.cells[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.cells.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.sectionFooterHeight)];
    footerView.backgroundColor = [UIColor clearColor];
    
    CGRect initialFrame = footerView.bounds;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(8, 16, 0, 16);
    CGRect paddedFrame = UIEdgeInsetsInsetRect(initialFrame, contentInsets);
    UILabel *textLabel = [[UILabel alloc] initWithFrame:paddedFrame];
    textLabel.textColor = [UIColor whiteColor];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setNumberOfLines:6];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        switch (self.status) {
                
            case 2:
            {
                [textLabel setText:changePhoneFooter2];
            }
                break;
            case 0:
            {
               // [textLabel setText:@"укажите ваш новый номер телефона, на этот номер придет код подтверждения"];
            }
                break;
                
            case 1:
            {
                [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
                    
                    [resault.verifications enumerateObjectsUsingBlock:^(DVerificationModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                       
                        if (obj.phoneOld != nil) {
                            [textLabel setText:[NSString stringWithFormat:@"Мы отправили код на номер %@", obj.phoneOld]];
                        }
                    }];
                    
                }];
                
            }
                break;
            case -2:
                [self.view.navigationController popViewControllerAnimated:YES];
                break;
            default:{
                
                [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
                    
                    [resault.verifications enumerateObjectsUsingBlock:^(DVerificationModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if (obj.phoneNew != nil) {
                            [textLabel setText:[NSString stringWithFormat:@"На ваш номер был отправлен код подтверждения %@", obj.phoneNew]];
                        }
                    }];
                    
                }];
            }
                break;
        }
    });

    [footerView addSubview:textLabel];
    return footerView;
}

#pragma mark - UITextField

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ((range.location-range.length) > 100) {
        [self changeActionButton:NO];
        return YES;
    }
    switch (self.status) {
        case 0:
        case 2:
        {
            if (range.length) {
                
                self.phoneNumber = [NSString stringWithFormat:@"%@%@",[textField.text stringByReplacingCharactersInRange:range withString:string],string];
            } else {
                self.phoneNumber = [NSString stringWithFormat:@"%@%@",textField.text,string];
            }
            
            if (range.location-range.length == 1 && range.length == 0) {
                textField.text = @"9";
                
            } else if (range.location-range.length == 3 && range.length == 0){
                
                textField.text = [NSString stringWithFormat:@"(9%@)",[textField.text substringWithRange:NSMakeRange(1, range.location-range.length-1)]];
            }else if ((range.location-range.length == 8 || range.location-range.length == 11) && range.length == 0){
                
                textField.text = [NSString stringWithFormat:@"%@-",textField.text];
            }else if (range.location-range.length >= 14){
                
                
                
                return NO;
            }
            [self changeActionButton:range.location-range.length == 13];
            return YES;
        }
            break;
            
        default:{
            
            if (range.length) {
                
                self.code = [NSString stringWithFormat:@"%@%@",[textField.text stringByReplacingCharactersInRange:range withString:string],string];
            } else {
                self.code = [NSString stringWithFormat:@"%@%@",textField.text,string];
            }
            
            [self changeActionButton:range.location-range.length >= 3];
            //[self.view.actionButton setEnabled:range.location-range.length == 3];
        }
            break;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (self.status) {
        case 0:
        case 2:{
            self.phoneNumber = textField.text;
          //  [self.helpButton setEnabled:self.phoneNumber.length];
            self.code = @"";
        }
            
            break;
        case -2:
            [self.view.navigationController popViewControllerAnimated:YES];
            break;
        default:{
            self.code = textField.text;
           // [self.helpButton setEnabled:self.code.length];
            self.phoneNumber = @"";
        }
            
            break;
    }
}

#pragma mark - private func

- (void)initCellWithStatus:(NSInteger)status{

    self.cells = @[].mutableCopy;
    
    switch (self.status) {
        case 0:
        case 2:{
        [self changeActionButton:self.phoneNumber.length];
        self.code = @"";
        }
            
            break;
        case -2:
            [self.view.navigationController popViewControllerAnimated:YES];
            break;
        default:{
        
            [self changeActionButton:self.code.length];
            self.phoneNumber = @"";
        }
            
            break;
    }

    DUserDataViewCell *phoneCell = [DUserDataViewCell getCellForTableView:self.view.tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
    [self addTextFieldToCell:phoneCell withPlaceholder: phonePlaceholder];
    switch (status) {
        case 0:
        case 2:{

            [phoneCell.maskLabel setAlpha:1];
            
            [self.cells addObject:phoneCell];
        }
            break;
            case -2:
                [self.view.navigationController popViewControllerAnimated:YES];
            break;
        default:{

            DUserDataViewCell *codeCell = [DUserDataViewCell getCellForTableView:self.view.tableView andClassCellString:NSStringFromClass([DUserDataViewCell class])];
            [self addTextFieldToCell:codeCell withPlaceholder: codePlaceholder];
            
            [self.cells addObject:codeCell];
        }
            break;
    }
    [self.view.tableView reloadData];
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
    
    if ([placeholder isEqualToString:phonePlaceholder]) {
        
        hoshiTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    
    if ([placeholder isEqualToString:codePlaceholder]) {
        
        hoshiTextField.keyboardType = UIKeyboardTypeNumberPad;
        
    }
    
    hoshiTextField.returnKeyType = UIReturnKeyDone;
   // [hoshiTextField setClearButtonMode:UITextFieldViewModeAlways];
    

    [cell.textFildView addSubview:hoshiTextField];
}


- (void)changeButtonForStatus:(NSInteger)status{

   // [self.view.actionButton setTitle:@"Помощь" forState:UIControlStateNormal];
    [self.view setTitle:@"Помощь"];
    switch (status) {
        case 0:
            
             case 2:
            [self.view.actionButton setTitle:@"Отправить номер" forState:UIControlStateNormal];
            //[self.view.actionButton setTitle:@"Отправить номер" forState:UIControlStateNormal];
            break;
            
        default:
           // [self.helpButton setTitle:@"Отправить код"];
           [self.view.actionButton setTitle:@"Отправить код" forState:UIControlStateNormal];
            break;
    }
}

#pragma mark - Tap Handler

- (void)addTapHandler {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    [self.view.view endEditing:YES];
}

- (void)addKeyboardObservers{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.botLayout.constant = keyboardFrameBeginRect.size.height+8;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    
    [UIView animateWithDuration:0.3 animations:^{
      self.view.botLayout.constant = 8;
    }];
}

- (void)changeActionButton:(BOOL)status{

    [self.view.actionButton setTitleColor:status ?  [UIColor whiteColor] : [UIColor lightGrayColor] forState:UIControlStateNormal ];
    [self.view.actionButton setEnabled:status];
}



@end



//
//  DPaymentPresenter.m
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPaymentPresenter.h"

@implementation DPaymentPresenter

- (instancetype)initWithView:(DPaymentViewController *)view route:(id<DPaymentRouteDisableProtocol>)route iterator:(id<DPaymentIteratorProtocol>)iterator
{
    self = [super init];
    if (self) {
        
        self.view = view;
        self.route = route;
        self.iterator = iterator;
        if (route) {
            self.view.presenter = self;
        }
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.tableView.bounds.size.width*0.8, 104)];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return self;
}

#pragma mark -DPaymentIteratorProtocolOut

- (void)updateWithNewParams{

    [self showCodeWithMessage:smsMessage];
    [self.view.tableView reloadData];
}

#pragma mark - DPaymentPresenterProtocol

- (void)updateUI{
    
   // [self addTapHandler];
    self.cells = [self generateCells];
    self.view.tableView.delegate = self;
    self.view.tableView.dataSource = self;
    self.view.tableView.sectionHeaderHeight = 150;
    self.view.tableView.sectionFooterHeight = 100;
    [self.view.tableView reloadData];
    [self nitificationEnabled];
    
    if (self.view.navigationItem != nil) {
        
        UIImage *img = [UIImage imageNamed:@"ico"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [imgView setImage:img];
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        self.view.navigationItem.titleView = imgView;
        
    }
    
}

- (void)disableModule{
    
    if (self.route) {
        [self.route disableModule];
    }
}

- (void)nitificationEnabled{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (UIView *)footer{

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.tableView.bounds.size.width, 120)];
    [footerView setBackgroundColor:[UIColor clearColor]];
    
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake((self.view.tableView.bounds.size.width*0.1), 0, (self.view.tableView.bounds.size.width*0.8), 120)];
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [self colorForHex:@"#6F7179"];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 3;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setDelegate:self];
    [label setText:@"Нажимая \"Продолжить\" вы соглашаетесь с публичной офертой сервиса Яндекс"];

    NSRange range = [label.text rangeOfString:@"Яндекс"];
    [label addLinkToURL:[NSURL URLWithString:@"https://money.yandex.ru/doc.xml?id=527067"] withRange:range];
    [footerView addSubview:label];
    
    return footerView;
}

- (UIColor *)colorForHex:(NSString *)hexString{

    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return UIColorFromRGB(rgbValue);
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    
     [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view.botLayout setConstant:keyboardSize.height+15];
        [self.view.view layoutIfNeeded];
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view.botLayout setConstant:0];
        [self.view.view layoutIfNeeded];
    }];
}

- (void)addRightButton{
    
    UIBarButtonItem *senderButton = [[UIBarButtonItem alloc] initWithTitle:@"Продолжить" style:UIBarButtonItemStyleDone target:self action:@selector(sender)];
    [self.view.navigationItem setRightBarButtonItem:senderButton];
}

#pragma mark - private func

- (void)addTapHandler {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    [self.view.view endEditing:YES];
}

- (void)sender{
    
    [self.view.view endEditing:YES];
    
    switch (self.iterator.modelType) {
        case 0:
        {
            NSArray *arrayValue = @[[self.moneyCellModule getMoneyValue],
                                    [self.cardCellModule getCardNumder],
                                    [self.phoneCellModule getPhoneNumber],
                                    [self.namesModule getFirstName],
                                    [self.namesModule getLastName],
                                    [self.namesModule getMidleName],
                                    [self.dateModule getDay],
                                    [self.dateModule getMonth],
                                    [self.dateModule getYear],
                                    [self.passportDepartmant getTextValue],
                                    [self.pasportDateModule getDay],
                                    [self.pasportDateModule getMonth],
                                    [self.pasportDateModule getYear],
                                    [self.birthdayAdressModule getTextValue],
                                    [self.cityAdressModule getTextValue],
                                    [self.adressModule getTextValue],
                                    [self.postModule getPostCode],
                                    [self.pasportSerialModule getPasportSerial]];
            
            for (NSString *obj in arrayValue) {
                if ([obj isEqualToString:@""]) {
                    
                    [[[UIAlertView alloc] initWithTitle:@"Дисконто" message:@"Все поля должны быть заполнены!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                    return ;
                    return;
                }
            }
            
            
            if ([self.iterator setCard:arrayValue]) {
                
                [self.iterator sendCardDataWithCallBack:^(BOOL result) {
                    
                    if (result) {
                        
                        [self showCodeWithMessage:smsMessage];
                    }
                }];
            } else {
                
            }
        }
            break;
        case 1:
        {
            
            if ([self.moneyCellModule getMoneyValue].length && [self.phoneCellModule getPhoneNumber].length) {
                
                if ([self.iterator setMobileNumber:[self.phoneCellModule getPhoneNumber] money:[self.moneyCellModule getMoneyValue]]) {
                    
                    [self.iterator sendMobileDataWithCallBack:^(BOOL result) {
                        
                        if (result) {
                            
                            [self showCodeWithMessage:smsMessage];
                        } else {
                            
                        }
                    }];
                } else {
                    NSLog(@"Nill point");
                }
            } else {
                
                [[[UIAlertView alloc] initWithTitle:@"Дисконто" message:@"Все поля должны быть заполнены!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                return;
            }
            
        }
            break;
        default:{
            
            if ([self.moneyCellModule getMoneyValue].length && [self.yandexModule getYandexCard].length) {
                
                if ([self.iterator setYandexCard:[self.yandexModule getYandexCard] money:[self.moneyCellModule getMoneyValue]]) {
                    
                    [self.iterator sendYandexDataWithCallBack:^(BOOL result) {
                        
                        if (result) {
                            [self showCodeWithMessage:smsMessage];
                        }
                    }];
                    
                } else {
                    
                    NSLog(@"Nill point");
                    
                }
            } else {
                [[[UIAlertView alloc] initWithTitle:@"Дисконто" message:@"Все поля должны быть заполнены!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            }
        }
            break;
    }
}

- (void)showCodeWithMessage:(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Дисконто" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Код";
       // textField.secureTextEntry = YES;
        [textField setDelegate:self];
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        [textField setPlaceholder:@"XXXXXX"];
        [textField setTextAlignment:NSTextAlignmentCenter];
    }];
    
    
    UIAlertAction *discardAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{} andAPICall:@"/payment/cancel" withCallBack:^(BOOL success, NSDictionary *resault) {
            
            if (success) {
                if (self.view.navigationController) {
                    
                    [self.view.tableView reloadData];
                    //[self.view.navigationController popViewControllerAnimated:YES];
                }
            }
        }];
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Отправить код" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UITextField *password = alertController.textFields.firstObject;
        
        [password endEditing:YES];
        if (![password.text isEqualToString:@""] && password.text.length == 6) {
            
            
            [self.iterator setCode:password.text];
            [self.iterator sendCodeWithCallBack:^(BOOL result) {
                
                if (result) {
                    
                    UIAlertController *compliteAlert = [UIAlertController alertControllerWithTitle:@"Дисконто" message:@"Деньги переведены. Спасибо, что воспользовались Дисконто!" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [self.view.navigationController popToRootViewControllerAnimated:YES];
                    }];
                    
                    [compliteAlert addAction:cancel];
                    
                    [self.view presentViewController:compliteAlert animated:NO completion:nil];
                } else {
                    
                }
            }];
        } else{
            
            [self showCodeWithMessage:smsMessage];
        }
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:discardAction];
    [self.view presentViewController:alertController animated:NO completion:nil];
}

- (NSArray *)generateCells{
    
    NSMutableArray *cells = @[].mutableCopy;
    
    self.moneyCellModule = [DMoneyCellRoute new];
    switch (self.iterator.modelType) {
        case 0:{
            
            
            //card fild
            self.cardCellModule = [DCardTableViewCellRoute new];
            [cells addObject:[self.cardCellModule showCardTableViewCellModuleWithTableView:self.view.tableView]];
            [cells addObject:[self.moneyCellModule showModuleWithTableView:self.view.tableView comision:self.comision minValue:self.min maxValue:self.max]];
            [self.cardCellModule setTextToTextField:[self.iterator getEntity].cardNumber];
            // names field
            
            self.namesModule = [DNamesTableViewCellRoute new];
            [cells addObject:[self.namesModule showNamesCellModuleWithTableView:self.view.tableView]];
            [self.namesModule setFirst:[_iterator getEntity].firstName second:[_iterator getEntity].secondName lastNames:[_iterator getEntity].lastName];
            
            // pas serial
            self.pasportSerialModule = [DSerialTableViewCellRoute new];
            [cells addObject:[self.pasportSerialModule showPasportSerialModule:self.view.tableView]];
            [self.pasportSerialModule setTextToTextField:[_iterator getEntity].pasportNumber];
            // pas date
            
            self.dateModule = [DDateTableViewCellRoute new];
            
            [cells addObject:[self.dateModule showDateCellModuleWithTableView:self.view.tableView rootViewController:[self.route getRootViewController]]];
            [self.dateModule setTitle:@"Дата выдачи паспорта:"];
            [self.dateModule setDay:[_iterator getEntity].pasDay month:[_iterator getEntity].pasMonth year:[_iterator getEntity].pasYear];
            //pas department
            DTextTableViewCellRoute *passportDepartmant = [[DTextTableViewCellRoute alloc] init];
            self.passportDepartmant = passportDepartmant;
            [cells addObject:[self.passportDepartmant showTextModule:self.view.tableView]];
            [self.passportDepartmant setPlaceholder:@"Кем выдан паспорт:"];
            [self.passportDepartmant setTextToTextField:[_iterator getEntity].pasDepartment];
            
            //pas phone
            self.phoneCellModule = [DPhoneCellRoute new];
            [cells addObject:[self.phoneCellModule showPhoneCellModuleWithTableView:self.view.tableView]];
            [self.phoneCellModule setTextToTextField:[_iterator getEntity].phoneNumber];
            //date

            
            DDateTableViewCellRoute *pasportDateModule = [[DDateTableViewCellRoute alloc] init];
            self.pasportDateModule = pasportDateModule;
            
            [cells addObject:[self.pasportDateModule showDateCellModuleWithTableView:self.view.tableView rootViewController:[self.route getRootViewController]]];
            [self.pasportDateModule setTitle:@"Дата рождения"];
            [self.pasportDateModule setDay:[_iterator getEntity].day month:[_iterator getEntity].month year:[_iterator getEntity].year];
            
            DTextTableViewCellRoute *birthdayAdressModule = [[DTextTableViewCellRoute alloc] init];
            
            self.birthdayAdressModule = birthdayAdressModule;
            
            [cells addObject:[self.birthdayAdressModule showTextModule:self.view.tableView]];
            [self.birthdayAdressModule setPlaceholder:@"Место рождения:"];
            [self.birthdayAdressModule setTextToTextField:[_iterator getEntity].birthplace];
            
            DTextTableViewCellRoute *cityAdressModule = [[DTextTableViewCellRoute alloc] init];
            
            self.cityAdressModule = cityAdressModule;
            
            [cells addObject:[self.cityAdressModule showTextModule:self.view.tableView]];
            [self.cityAdressModule setPlaceholder:@"Город регистрации:"];
            [self.cityAdressModule setTextToTextField:[_iterator getEntity].city];
            
            DTextTableViewCellRoute *adressModule = [[DTextTableViewCellRoute alloc] init];
            
            self.adressModule = adressModule;
            
            [cells addObject:[self.adressModule showTextModule:self.view.tableView]];
            [self.adressModule setPlaceholder:@"Адрес владельца карты:"];
            [self.adressModule setTextToTextField:[_iterator getEntity].adress];
            
            self.postModule = [DPostCodeTableViewCellRoute new];
            [cells addObject:[self.postModule showIndex:self.view.tableView]];
            [self.postModule setTextToTextField:[_iterator getEntity].postIndex];
            
        }
            break;
        case 1:{
            
            self.phoneCellModule = [DPhoneCellRoute new];
            [cells addObject:[self.phoneCellModule showPhoneCellModuleWithTableView:self.view.tableView]];
            [self.phoneCellModule setTextToTextField:[_iterator getEntity].phoneNumber];
            [cells addObject:[self.moneyCellModule showModuleWithTableView:self.view.tableView comision:self.comision minValue:self.min maxValue:self.max]];
            [self.moneyCellModule setTextToTextField:[_iterator getEntity].money];
        }
            break;
            
        default:{
            
            self.yandexModule = [DYandexCardTableViewCellRoute new];
            [cells addObject:[self.yandexModule showYandexCardModuleWithTableView:self.view.tableView]];
            
            [self.yandexModule setTextToTextField:[_iterator getEntity].yandexNumber];
            [cells addObject:[self.moneyCellModule showModuleWithTableView:self.view.tableView comision:self.comision minValue:self.min maxValue:self.max]];
            [self.moneyCellModule setTextToTextField:[_iterator getEntity].money];
        }
            break;
    }
    
    return cells;
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.cells[indexPath.row];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    

    return [self footer];
}

- (UIView *)headerView{

    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.tableView.bounds.size.width, 120)];
    [header setBackgroundColor:[UIColor clearColor]];
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake((self.view.tableView.bounds.size.width*0.02), 8, self.view.tableView.bounds.size.width*0.95, 120*0.8)];
    [subView setBackgroundColor:[UIColor whiteColor]];
    
    [header addSubview:subView];
    [self.imageView setFrame:CGRectMake((subView.bounds.size.width*0.05), subView.bounds.size.height*0.1, subView.bounds.size.width*0.9, subView.bounds.size.height*0.8)];
    
   // [self.imageView setBackgroundColor:[UIColor whiteColor]];
    [subView addSubview:self.imageView];
    [subView.layer setCornerRadius:8];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [self headerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
            case 1:
            return 120;
        case 2:
            return 120;
            break;
        case 4:
        case 7:
            return 85;
        default:
            return 44;
            break;
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 120;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField endEditing:YES];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (range.length) {
        
        textField.text = @"";
        return YES;
    } else {
        return textField.text.length <= 5;
    }
    
}

#pragma mark - DPassportDepartmantTableViewCellPresenterOut

- (void)showKeybord{
    
    
}

- (void)hideKeybord{
    
    
}

@end

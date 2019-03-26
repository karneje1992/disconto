//
//  DSentToSupportController.m
//  Disconto
//
//  Created by user on 15.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import "DSendToSupportController.h"
//#import "AVCheckBox.h"

@interface DSendToSupportController ()

@property NSString *message;
@property UIBarButtonItem *nextButton;
@property NSString *email;
@end

@implementation DSendToSupportController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (TOKEN) {
        [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
            _email = resault.userEmail;
            [self.tableView reloadData];
        }];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    if(self.alternative){
        self.navigationController.navigationBar.barTintColor = SYSTEM_NAV;
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:titleCancel style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        self.navigationItem.leftBarButtonItem = back;
    }
    self.nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Отправить" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage:)];
    self.navigationItem.rightBarButtonItem = self.nextButton;
    self.nextButton.enabled = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    [self setTitle:@"Сообщение"];
    
    [super viewWillAppear:animated];
    
    
}

- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];;
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DTopCell *cell = [DTopCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DTopCell class])];
        [cell.userEmail setDelegate:self];
        cell.themLabel.text = newRquestToSupportDisconto;
        if (_email) {
            [cell.userEmail setText:_email];
            [cell.userEmail setEnabled:NO];
            
        }
        return cell;
    }else{
        DMessageCell *cell = [DMessageCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DMessageCell class])];
        cell.textField.delegate = self;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 120;
    }else{
        
        return 200;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [textView resignFirstResponder];
    return NO;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"Ваше сообщение"]) {
        
        [textView setText:@""];
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    
    textView.text.length > 0 ? [self.nextButton setEnabled:YES] : [self.nextButton setEnabled:NO];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    self.message = textView.text;
    if (![self.message isEqualToString:@""]) {
        self.nextButton.enabled = YES;
    }
    
    
}

- (IBAction)sendMessage:(id)sender {
    
    [self.view endEditing:YES];

    if (!_email.length) {
        SHOW_MESSAGE(@"Укажите реальный адрес электронной почты. На этот адрес будет отправлено письмо", nil);
        return;
    }
    if (self.message.length > 0) {
        SHOW_PROGRESS;
        
        if (!TOKEN) {
            [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{titleMessage:self.message,@"user_email":_email ? _email : @""} andAPICall:@"/help" withCallBack:^(BOOL success, NSDictionary *resault) {
                if (success) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                           SHOW_MESSAGE(@"Сообщение отправлено!", textMessegeSend);
                       // [self showAlertWithTitle:@"Сообщение отправлено!" message:textMessegeSend];
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    });
                }
                HIDE_PROGRESS;
            }];
        }else{
            
            [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{titleMessage:self.message} andAPICall:apiSendToSupport withCallBack:^(BOOL success, NSDictionary *resault) {
                if (success) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        SHOW_MESSAGE(@"Сообщение отправлено!", textMessegeSend);
                       // [self showAlertWithTitle:@"Сообщение отправлено!" message:textMessegeSend];
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }
                HIDE_PROGRESS;
            }];
        }
    }else{
        
        SHOW_MESSAGE(@"Предупреждение", textEmptyMessage);
       // [self showAlertWithTitle:@"Предупреждение" message:textEmptyMessage];
    }
    
}

- (void)paste:(id)sender{
    
    [super paste:sender];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITextfield

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    _email = textField.text;
    
}
@end


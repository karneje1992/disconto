//
//  DCodeViewController.m
//  Disconto
//
//  Created by Ross on 29.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DCodeViewController.h"

@interface DCodeViewController ()
@property NSInteger veryPhone;
@end

@implementation DCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    [self addKeyboardObservers];
    [self addTapHandler];
    self.phoneLabel.text = self.phone;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
        for (DVerificationModel *item in resault.verifications) {
            if ([item.verificationType isEqualToString:@"changePhone"]) {
                _veryPhone = item.verificationID;
                [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"id":@(item.verificationID)} andAPICall:apiChangeCancel withCallBack:^(BOOL success, NSDictionary *resault) {
                    
                    if (success) {
                        [self.delegate exitPhoneFromController:self];
                    }
                    
                }];
            }
        }

        
    }];
}

- (IBAction)send:(id)sender {
    
    if (self.codeTextField.text.length > 3) {
        [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
            for (DVerificationModel * obj in resault.verifications) {
                if (obj.phoneNew) {
                    
                        [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"code":self.codeTextField.text, @"id": @(obj.verificationID)} andAPICall:apiConferm withCallBack:^(BOOL success, NSDictionary *resault) {
                            
                            if (success) {
                                
                                [self.delegate exitPhoneFromController:self];
                            }else{
                                SHOW_MESSAGE(errorCode, nil);
                            }
                        }];

                }
            }
        }];

    }else{
        
        SHOW_MESSAGE(errorCode, nil);
    }

}

- (void)prepareUI {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

#pragma mark - Keyboard Observers

- (void)addKeyboardObservers{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    CGFloat heightFromBottomToViewWithTextFields = CGRectGetMaxY(self.popUpView.bounds) - CGRectGetMaxY(self.popUpView.frame);
    CGFloat keyboardHeight = CGRectGetHeight(keyboardFrameBeginRect);
    
    CGRect frame = self.view.frame;
    CGFloat toAddValue = (heightFromBottomToViewWithTextFields > keyboardHeight) ? 0 : heightFromBottomToViewWithTextFields*0.7;
    
    frame.origin.y = +toAddValue;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = frame;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = frame;
    }];
}

- (void)setPlaceholder:(NSString *)placeholder toTextField:(UITextField *)textField{
    
    textField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:placeholder
                                    attributes:@{
                                                 NSForegroundColorAttributeName: [UIColor whiteColor],
                                                 NSFontAttributeName : [UIFont fontWithName:textField.font.fontName size:16]
                                                 }
     ];
    
}

#pragma mark - Tap Handler

- (void)addTapHandler {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changePhone:(id)sender {
    
    [[self delegate] changePhoneFromController:self];
}

- (IBAction)resend:(id)sender {
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"id":@([resault.verifications lastObject].verificationID)} andAPICall:@"/users/change/resend" withCallBack:^(BOOL success, NSDictionary *resault) {
            
            if (success) {
                
                SHOW_MESSAGE(sendCode, nil);
            }
        }];
    }];
    
}
@end

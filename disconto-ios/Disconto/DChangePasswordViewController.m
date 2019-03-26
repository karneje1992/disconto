//
//  DChangePasswordViewController.m
//  Disconto
//
//  Created by user on 26.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DChangePasswordViewController.h"

@interface DChangePasswordViewController ()

@end

@implementation DChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPlaceholder:changePassOldPassPlaceholder toTextField:self.oldPassTextField];
    [self setPlaceholder:changePassNewPassPlaceholder toTextField:self.changedPassTextField];
    [self setPlaceholder:changePassNewPassPlaceholder2 toTextField:self.confermTextField];
    [self prepareUI];
    [self addKeyboardObservers];
    [self addTapHandler];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

- (IBAction)cancel:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)send:(id)sender {
    
    if ([ValidatorValues validatePassword:self.changedPassTextField.text] || [ValidatorValues validatePassword:self.oldPassTextField.text] || [ValidatorValues validatePassword:self.confermTextField.text]) {
        
        if ([self.changedPassTextField.text isEqualToString:self.confermTextField.text]) {
            
            [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{kServerOldPassword:self.oldPassTextField.text,kServerNewPassword:self.changedPassTextField.text} andAPICall:[NSString stringWithFormat:apiChangePassword] withCallBack:^(BOOL success, NSDictionary *resault) {
                
                if (success) {
                    
                    SHOW_MESSAGE(passwordChangeSucssesText, nil);
                    [self cancel:nil];
                }else{
                    
                }
            }];
        }else{
             SHOW_MESSAGE(passwordIsDifferentText, nil);
        }
    }else{
         SHOW_MESSAGE(passworsdIsEmptyText, nil);
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
    CGFloat toAddValue = (heightFromBottomToViewWithTextFields > keyboardHeight) ? 0 : heightFromBottomToViewWithTextFields*0.6;
    
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

@end

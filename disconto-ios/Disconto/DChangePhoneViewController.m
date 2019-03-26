//
//  DChangePhoneViewController.m
//  Disconto
//
//  Created by user on 27.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DChangePhoneViewController.h"

@interface DChangePhoneViewController ()

@property NSString *param;
@property BOOL isMaskEnabled;
@end

@implementation DChangePhoneViewController

+ (instancetype)changePhone:(NSString *)phone{
    
    return [[DChangePhoneViewController alloc] initWithNibName:NSStringFromClass([DChangePhoneViewController class]) bundle:nil andPhone:phone];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPhone:(NSString *)phone
{
    self = [super initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil];
    if (self) {
        
        self.param = phone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.phoneLabel setAlpha:self.param.length];
    [self.phoneLabel setText:self.param];
    [self setPlaceholder:changePhonePlaceholder toTextField:self.phoneTextField];
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

- (void)prepareUI {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
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

- (IBAction)cancel:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendEmail:(id)sender {
    
    if ([ValidatorValues validatePhoneNumber:self.phoneTextField.text]) {
        
        [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{kPhone:self.phoneTextField.text} andAPICall:apiPhoneExist withCallBack:^(BOOL success, NSDictionary *resault) {
            
            if (success) {
                if ([resault[kServerData][kServerCount] boolValue]) {
                    
                    SHOW_MESSAGE(nil, phoneError);
                }else{
                    
                    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{kPhone:self.phoneTextField.text} andAPICall:apiChageProfile withCallBack:^(BOOL success, NSDictionary *resault) {
                        
                        if (success) {
                            [self.view endEditing:YES];
                            [self.delegate sended];
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }
                    }];
                }
            }
        }];
        
    }else {
        SHOW_MESSAGE(phoneNotFormmat, nil);
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (([string isEqualToString:@"7"] || [string isEqualToString:@"8"]) && range.location == 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ){
        
        textField.text = @"+7";
        _isMaskEnabled = YES;
        return NO;
    }
    if (!_isMaskEnabled) {
        
        textField.text = [NSString stringWithFormat:@"+7%@",textField.text];
        _isMaskEnabled = !_isMaskEnabled;
    }else if (textField.text.length < 1){
        _isMaskEnabled = YES;
        textField.text = [NSString stringWithFormat:@"+7%@",textField.text];
    }else{
        
        _isMaskEnabled =YES;
    }
    
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    return newLength <= 12;
    
}


@end

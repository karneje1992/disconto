//
//  DChangeEmailViewController.m
//  Disconto
//
//  Created by user on 27.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DChangeEmailViewController.h"

@interface DChangeEmailViewController ()

@property NSString *param;
@end

@implementation DChangeEmailViewController

+ (instancetype)changeEmail:(NSString *)email{
    
    return [[DChangeEmailViewController alloc] initWithNibName:NSStringFromClass([DChangeEmailViewController class]) bundle:nil andEmail:email];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andEmail:(NSString *)email
{
    self = [super initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil];
    if (self) {
        
        self.param = email;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.emailLabel setAlpha:self.param.length];
    [self.emailLabel setText:self.param];
    [self setPlaceholder:@"Новая эл. почта" toTextField:self.emailTextField];
    
    [self prepareUI];
    [self addKeyboardObservers];
    [self addTapHandler];
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
    
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
       
        for (DVerificationModel *obj in resault.verifications) {
            if (obj.emailNew) {
                [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"id":@(obj.verificationID)} andAPICall:apiChangeCancel withCallBack:^(BOOL success, NSDictionary *resault) {
                    if (success) {
                        [self.view endEditing:YES];
                        [self.delegete controller:self isChanged:YES];
                    }
                }];
            }
        }
    }];

    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendEmail:(id)sender {
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{kEmail:self.emailTextField.text} andAPICall:apiChageProfile withCallBack:^(BOOL success, NSDictionary *resault) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (success) {
                [self.view endEditing:YES];
                [self.delegete controller:self isChanged:YES];
            }
        });
        
    }];
}

@end

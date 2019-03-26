//
//  DVeryFaryMailController.m
//  Disconto
//
//  Created by user on 05.04.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import "DVeryFaryMailController.h"

@interface DVeryFaryMailController ()
@property NSInteger veryID;
@property DUserModel *user;
@property NSInteger code;
@end

@implementation DVeryFaryMailController

+ (instancetype)showVeryFaryEmailWithUser:(DUserModel *)user code:(NSInteger)code{

    return [[DVeryFaryMailController alloc] initWithNibName:NSStringFromClass([DVeryFaryMailController class]) bundle:nil andUserModel:user code:code];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andUserModel:(DUserModel *)user code:(NSInteger)code
{
    self = [super initWithNibName:nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        
        self.code = code;
        self.user = user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    [self addKeyboardObservers];
    [self addTapHandler];
    
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        if (resault.verifications.count > 0) {
            [resault.verifications enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                DVerificationModel *item = obj;
                if ([item.verificationType isEqualToString:@"changeEmail"]) {
                    self.emailLabel.text = item.emailNew;
                    self.veryID = item.verificationID;
                }
            }];
        }else{
        
            self.emailLabel.text = resault.userEmail;
        }
        
    }];
    
    self.emailLabel.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [UIView animateWithDuration:2.0 animations:^(void) {
        self.popUpAlertView.alpha = 0;
        self.popUpAlertView.alpha = 1;
    }];
    [super viewWillAppear:animated];
}

#pragma mark - Button Actions

- (IBAction)support:(id)sender {
    
    [self.delegate toSupp];
    [self dismissViewControllerAnimated:NO completion:^{
        [self.delegate exit];
    }];
}

- (IBAction)changeEmail:(id)sender {
    
    [self.delegate changeEmail];
    [self dismissViewControllerAnimated:NO completion:^{
        [self.delegate exit];
    }];
}

- (IBAction)resend:(id)sender {
    
    [self.delegate resend];
    [self dismissViewControllerAnimated:NO completion:nil];
    [DUserModel updateProfileWithCallBack:^(DUserModel *model) {
        
        [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"id":@([model.verifications firstObject].verificationID)} andAPICall:@"/users/change/resend" withCallBack:^(BOOL success, NSDictionary *resault) {
            
            if (success) {
                [self.view endEditing:YES];
                [self dismissViewControllerAnimated:NO completion:^{
                    [self.delegate exit];
                }];
            }
        }];
    }];

    
}

#pragma mark - private methods

- (void)borderedButton:(UIButton *)button{
    
    button.layer.borderWidth = 1;
    [button.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    button.layer.cornerRadius = 4;
}

#pragma mark - Tap Handler

- (void)addTapHandler {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {

    [self dismissViewControllerAnimated:NO completion:^{
        [self.delegate exit];
    }];
}

#pragma mark - private methods

- (void)prepareUI {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.popUpAlertView.layer.cornerRadius = 5;
    self.popUpAlertView.layer.shadowOpacity = 0.8;
    self.popUpAlertView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    [self borderedButton:self.resendButton];
    [self borderedButton:self.changeEmailButton];
    [self borderedButton:self.sendToSupportButton];
    [self.alertLabel setText:[NSString stringWithFormat:notConfermEmail]];
    
}

- (void)currentSecond:(NSInteger)currentSecond{
    
    if (currentSecond < 1) {
        
        [UIView animateWithDuration:3.0 animations:^(void) {
            self.popUpAlertView.alpha = 1;
            self.popUpAlertView.alpha = 0;
        }];
    }
}

- (IBAction)cancel:(id)sender {
    
    [[[UIAlertView alloc] initWithTitle:cancelNewMail message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:@"Отменить изменение", nil] show];

}

- (IBAction)next:(id)sender {
    
    [DUserModel updateProfileWithCallBack:^(DUserModel *resault) {
        
            resault.verifications.count == 0 ? [[[UIAlertView alloc] initWithTitle:okEmail message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show] : [[[UIAlertView alloc] initWithTitle:notEmail message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [self dismissViewControllerAnimated:NO completion:^{
            [self.delegate exit];
        }];
       
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        
        [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{kID: @(self.veryID)} andAPICall:[NSString stringWithFormat:@"%@",apiChangeCancel] withCallBack:^(BOOL success, NSDictionary *resault) {
            if (success) {
                [self dismissViewControllerAnimated:NO completion:^{
                    [self.delegate exit];
                }];
            }

        }];
    }else{
        [self dismissViewControllerAnimated:NO completion:^{
           // [self.delegate exit];
        }];

    }
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
@end

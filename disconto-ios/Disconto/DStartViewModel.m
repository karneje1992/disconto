//
//  DStartViewModel.m
//  DiscontoMVVM
//
//  Created by Rostislav on 30.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "DStartViewModel.h"

@interface DStartViewModel()

@property NSMutableArray<UILabel *> *labels;
@property NSMutableArray<UIButton *> *buttons;
@end

@implementation DStartViewModel

- (instancetype)initWithParametrs:(NSDictionary *)parameters
{
    self = [super init];
    if (self) {
        self.iconImage = [UIImage imageNamed:parameters[@"imageName"]];
        self.registrationLabelText = parameters[kRegistrationLabelText];
        self.loginLabelText = parameters[kLoginLabelText];
        self.registrationButtonText = parameters[kRegistrationButtonText];
        self.loginButtonText = parameters[kLoginButtonText];
        self.supportButtonText = parameters[kSupportButtonText];
        self.labels = @[].mutableCopy;
        self.buttons = @[].mutableCopy;
    }
    return self;
}

- (void)setupUIWithCotroller:(UIViewController *)controller{

   // controller.navigationController.navigationBarHidden = YES;
    for (UIView *view in controller.view.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]) {
           
            [self.labels addObject:(id)view];
        }else if ([view isKindOfClass:[UIButton class]]){
            [self.buttons addObject:(id)view];
            view.tintColor = controller.view.backgroundColor;
        }else if([view isKindOfClass:[UIImageView class]]){
        
            [(UIImageView *)view setImage:self.iconImage];
        }
    }
    [self updateUILabels];
    
}

- (void)updateUILabels{

    [self.labels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case enumRegistrationLabel:
                [obj setText:self.loginLabelText];
                break;
            case enumLoginLabel:
                [obj setText:self.registrationLabelText];
                break;
            default:
                break;
        }
    }];
    
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (idx) {
            case enumRegistrationButton:
                [obj setTitle:self.registrationButtonText forState:UIControlStateNormal];
                break;
            case enumLoginButton:
                [obj setTitle:self.loginButtonText forState:UIControlStateNormal];
                break;
            default:
                [obj setTitle:self.supportButtonText forState:UIControlStateNormal];
                break;
        }
        obj.layer.cornerRadius = 3;
    }];
}
@end

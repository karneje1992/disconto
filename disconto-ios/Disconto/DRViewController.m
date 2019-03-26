//
//  DRViewController.m
//  Disconto
//
//  Created by Rostislav on 02.12.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DRViewController.h"
#import "DEntranceViewController.h"
#import "DLoginViewModel.h"
#import "DRegistrationViewModel.h"

@interface DRViewController ()

@property DLoginViewModel *loginViewModel;
@end

@implementation DRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginViewModel = [[DLoginViewModel alloc] initWhithParametrs:@{}];
    self.loginViewModel.controller = self;
    [self.otherLabel setText:@"или \n зарегистрироваться через"];
    self.navigationController.navigationBarHidden = NO;
    [self.view.subviews enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.layer.cornerRadius = 3;
    }];
     [DSocialViewController allSocialLogOut];
  ///  [self blure:self.blureView];
//    [self animation];
    
    [_fbButton.layer setCornerRadius:4];
    [_okButton.layer setCornerRadius:4];
    [_vkbutton.layer setCornerRadius:4];
    [_fbButton.layer setMasksToBounds:YES];
    [_okButton.layer setMasksToBounds:YES];
    [_vkbutton.layer setMasksToBounds:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (IBAction)vk:(id)sender {
    [self.loginViewModel vkLogin];
}
- (IBAction)fb:(id)sender {
    
    [self.loginViewModel fbLogin];
}
- (IBAction)ok:(id)sender {
    
    [self.loginViewModel okLogin];
}
- (IBAction)reg:(id)sender {
    
    [self.navigationController pushViewController:[DEntranceViewController showEntranceViewControllerWithViewModel:[[DRegistrationViewModel alloc] initWhithParametrs:@{}] andShowSocButtons:NO] animated:YES];
}

- (IBAction)supp:(id)sender {
    
    DSendToSupportController *vc = [[DSendToSupportController alloc] initWithNibName:NSStringFromClass([DSendToSupportController class]) bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//- (void)blure:(UIView *)blureView{
//    
//    
//    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
//        blureView.backgroundColor = SYSTEM_COLOR;
//        
//        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        blurEffectView.frame = self.view.bounds;
//        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        
//        [blureView addSubview:blurEffectView];
//    } else {
//        blureView.backgroundColor = SYSTEM_COLOR;
//    }
//    
//    CAGradientLayer *gradientMask = [CAGradientLayer layer];
//    gradientMask.frame = self.view.bounds;
//    gradientMask.colors = @[(id)SYSTEM_COLOR.CGColor,
//                            (id)[UIColor clearColor].CGColor];
//    blureView.layer.mask = gradientMask;
//    
//    
//}
//
//- (void)animation{
//    
//    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer]; // 1
//    emitterLayer.emitterPosition = CGPointMake(self.animatedView.bounds.origin.x, self.view.bounds.origin.y); // 2
//    emitterLayer.emitterZPosition = 10; // 3
//    emitterLayer.emitterSize = CGSizeMake(self.animatedView.bounds.size.width, 0); // 4
//    emitterLayer.emitterShape = kCAEmitterLayerSphere; // 5
//    
//    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell]; // 6
//    emitterCell.scale = 0.1; // 7
//    emitterCell.scaleRange = 0.2; // 8
//    emitterCell.emissionRange = (CGFloat)M_PI_2; // 9
//    emitterCell.lifetime = 50; // 10
//    emitterCell.birthRate = 100; // 11
//    emitterCell.velocity = 200; // 12
//    emitterCell.velocityRange = 1; // 13
//    emitterCell.yAcceleration = 1; // 14
//    emitterCell.contents = (id)[[UIImage imageNamed:@"WaterDrop"] CGImage]; // 15
//    emitterLayer.emitterCells = [NSArray arrayWithObject:emitterCell]; // 16
//    
//    [self.animatedView.layer addSublayer:emitterLayer]; // 17
//}
@end

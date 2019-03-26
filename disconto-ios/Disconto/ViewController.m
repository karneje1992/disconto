//
//  ViewController.m
//  Disconto
//
//  Created by user on 12.08.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "ViewController.h"
#import "DStartViewController.h"
#import "DStartViewModel.h"
#import "SWRevealViewController.h"
#import "DCapchaRouteProtocol.h"
#import "DCapchaRoute.h"

@interface ViewController ()//<FCBDelegate, FCBCampaignManagerDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) NSMutableOrderedSet *recentsDataSource;
@property (nonatomic, strong) NSMutableOrderedSet *favoritesDataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SYSTEM_COLOR;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
//    id<DCapchaRouteProtocol> capchaTest = [DCapchaRoute new];
//    [capchaTest showCapchaModuleWithRootVC:self];

        if (USER_IS_LOGINED) {
            [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:@"/settings/version" withCallBack:^(BOOL success, NSDictionary *resault) {
                if (success) {
                    if ([resault[@"data"][@"version"] integerValue] > version) {
                        
                        [[[UIAlertView alloc] initWithTitle:@"Доступна новая версия" message:@"" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Загрузить", nil] show];
                    }else{
                        
                        [self loadMain];
                    }
                }else{
                
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userID"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UID"];
                    NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:@"numOfLCalls"];
                    [[NSUserDefaults standardUserDefaults] setInteger:i+1 forKey:@"numOfLCalls"];
                    [self loadMain];
                }
            }];
        }else{
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userID"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UID"];
            NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:@"numOfLCalls"];
            [[NSUserDefaults standardUserDefaults] setInteger:i+1 forKey:@"numOfLCalls"];
            [self loadMain];
        }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        
        
    }else{
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/ru/app/diskonto/id1003256356?mt=8"]];
    }
}
- (void)loadMain{
    [DSocialViewController allSocialLogOut];
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"numOfLCalls"] > 0) {
        
        if (USER_IS_LOGINED) {
            if (PUSH_TOKEN) {
                [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{@"push_token":PUSH_TOKEN} andAPICall:apiRegisterToken withCallBack:^(BOOL success, NSDictionary *resault) {
                    if (success) {
                        // SHOW_TABBAR_CONTROLLER;
                        
                        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SWRevealViewController" bundle:nil];
                        SWRevealViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                        [self presentViewController:vc animated:YES completion:NULL];
                        
                        NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:@"numOfLCalls"];
                        [[NSUserDefaults standardUserDefaults] setInteger:i+1 forKey:@"numOfLCalls"];
                    }
                    
                }];
            }else{
            
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SWRevealViewController" bundle:nil];
                SWRevealViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self presentViewController:vc animated:YES completion:NULL];
                
                NSInteger i = [[NSUserDefaults standardUserDefaults] integerForKey:@"numOfLCalls"];
                [[NSUserDefaults standardUserDefaults] setInteger:i+1 forKey:@"numOfLCalls"];
            }
            
            return;
        }else{
                [self.navigationController pushViewController:[DStartViewController showStartScreenWithViewModel:[[DStartViewModel alloc] initWithParametrs:@{kRegistrationLabelText:@"Новый пользователь?",kLoginLabelText:@"Уже есть аккаунт?",kRegistrationButtonText:@"Зарегистрироваться",kLoginButtonText:@"Войти",kSupportButtonText:@"Написать в поддержку",@"imageName":@"icon"}]] animated:YES];
            return;
        }
    }else{
        
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"numOfLCalls"];
        SHOW_START_TUTORIAL;
    }
}

//- (void)blure{
//    
//    
//    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
//        self.blureView.backgroundColor = SYSTEM_COLOR;
//        
//        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        blurEffectView.frame = self.view.bounds;
//        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        
//        [self.blureView addSubview:blurEffectView];
//    } else {
//        self.blureView.backgroundColor = SYSTEM_COLOR;
//    }
//    
//    CAGradientLayer *gradientMask = [CAGradientLayer layer];
//    gradientMask.frame = self.view.bounds;
//    gradientMask.colors = @[(id)SYSTEM_COLOR.CGColor,
//                            (id)[UIColor clearColor].CGColor];
//    self.blureView.layer.mask = gradientMask;
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

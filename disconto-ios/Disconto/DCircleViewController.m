//
//  DCircleViewController.m
//  Loter
//
//  Created by Rostislav on 25.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "DCircleViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DCircleViewController ()
@property DCircleViewModel *viewModel;

@end

@implementation DCircleViewController

+ (instancetype)showCircleViewContrlllerWithModel:(id)model{
    
    return [[DCircleViewController alloc] initWithNibName:NSStringFromClass([DCircleViewController class]) bundle:nil andModel:model];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andModel:(id)model
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.viewModel = model;
        self.viewModel.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initImageViewWithViewModel:self.viewModel];
    [self.navigationItem setTitle:@"Колесо фортуны"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)initImageViewWithViewModel:(DCircleViewModel *)viewModel{
    
    self.imageView.layer.cornerRadius = (self.view.bounds.size.width*0.8)*0.5;
    [self.imageView setImage:[UIImage imageWithData:self.viewModel.circleImageData]];
    [self.pinImageView setImage:[UIImage imageWithData:self.viewModel.pinImageData]];
    [self.backGroundImageView setImage:[UIImage imageWithData:self.viewModel.backgroundImageData]];
        [self.logoImageView setImage:[UIImage imageWithData:self.viewModel.logoImageData]];
    [self.titleImageView setImage:[UIImage imageWithData:self.viewModel.titleImageData]];
    _swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    _swipeleft.direction=UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:_swipeleft];
    
}

- (void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    [self.viewModel runSpinAnimationOnView:self.imageView duration:6];
    [_swipeleft setEnabled:NO];
}

#pragma mark - DCircleDelegate

- (void)animatetdStopedWithController:(id)model{
    
    DCircleViewModel * obj = model;
    
    [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/games/session/%@",obj.sessionID] withCallBack:^(BOOL success, NSDictionary *resault) {
       
        if (success) {
            
            [[[UIAlertView alloc] initWithTitle:obj.message message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            return ;
        }
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    RESTART;
}
- (void)alertViewCancel:(UIAlertView *)alertView{
    
}
@end

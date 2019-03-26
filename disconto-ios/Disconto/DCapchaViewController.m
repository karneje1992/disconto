//
//  DCapchaViewController.m
//  Disconto
//
//  Created by Rostislav on 7/28/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DCapchaViewController.h"

@interface DCapchaViewController ()

@end

@implementation DCapchaViewController

+ (DCapchaViewController *)showCapchaViewController{

    return [[DCapchaViewController alloc] initWithNibName:@"DCapchaViewController" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self.presenter updateUI];
}

- (IBAction)reloadAction:(UIButton *)sender {
    [self.presenter reloadAction];
}

- (IBAction)sendAction:(UIButton *)sender {
    [self.presenter sendCapcha];
}

@end

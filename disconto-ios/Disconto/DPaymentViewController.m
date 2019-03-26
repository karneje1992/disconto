//
//  DPaymentViewController.m
//  Disconto
//
//  Created by Rostislav on 6/26/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPaymentViewController.h"

@interface DPaymentViewController ()

@end

@implementation DPaymentViewController

+ (DPaymentViewController *)showPaymentViewController{

    return [[DPaymentViewController alloc] initWithNibName:@"DPaymentViewController" bundle:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];

   // self.view.backgroundColor = SYSTEM_COLOR;
    if (self.presenter) {
        [self.presenter updateUI];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    if (self.presenter) {
        [self.presenter addRightButton];
    }
}

@end

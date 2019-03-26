//
//  DLocalOfferViewController.m
//  Disconto
//
//  Created by Rostislav on 10.08.17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DLocalOfferViewController.h"

@interface DLocalOfferViewController ()

@end

@implementation DLocalOfferViewController

+ (DLocalOfferViewController *)showDLocalOfferViewController{

    return [[DLocalOfferViewController alloc] initWithNibName:@"DLocalOfferViewController" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    if (self.presenter) {
        
        [self.presenter updateUI];
    }
}
- (IBAction)sendAction:(UIButton *)sender {
    
    [self.presenter sendAction];
}

@end

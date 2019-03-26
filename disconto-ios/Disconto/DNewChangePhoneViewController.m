//
//  DNewChangePhoneViewController.m
//  Disconto
//
//  Created by Rostislav on 6/15/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DNewChangePhoneViewController.h"

@interface DNewChangePhoneViewController ()

@end

@implementation DNewChangePhoneViewController

+ (void)showChangePhoneControllerCallBack:(void (^)(DNewChangePhoneViewController *resault))callback{

    callback([[DNewChangePhoneViewController alloc] initWithNibName:@"DNewChangePhoneViewController" bundle:nil]) ;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SYSTEM_COLOR;
    if (self.presenter != nil) {
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
    
    
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
}

- (IBAction)active:(UIButton *)sender {
    
    [self.presenter active];
}
@end

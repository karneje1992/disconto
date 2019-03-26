//
//  DProductsController.m
//  Disconto
//
//  Created by Rostislav on 12.12.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DProductsController.h"

@interface DProductsController ()

@property DProductsViewModel *viewModel;
@end



@implementation DProductsController

+ (instancetype)showProductsWichViewModel:(id)viewModel delegateController:(UIViewController *)delegateController{

    return [[DProductsController alloc] initWithNibName:NSStringFromClass([DProductsController class]) bundle:nil viewModel:viewModel delegateController:delegateController];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel delegateController:(UIViewController *)delegateController
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.viewModel = viewModel;
    }
    return self;
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
}

@end

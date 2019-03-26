//
//  DEntranceViewController.m
//  DiscontoMVVM
//
//  Created by Rostislav on 30.11.16.
//  Copyright © 2016 Devium. All rights reserved.
//

#import "DEntranceViewController.h"
#import "DRegistrationViewModel.h"
#import "DLoginViewModel.h"

@interface DEntranceViewController ()

@property DRegistrationViewModel *registrationViewModel;
@property DLoginViewModel *loginViewModel;
@property CGFloat alpha;
@end

@implementation DEntranceViewController

+ (instancetype)showEntranceViewControllerWithViewModel:(id)viewModel andShowSocButtons:(BOOL)showSocButtons{

    return [[DEntranceViewController alloc] initWithNibName:NSStringFromClass([DEntranceViewController class]) bundle:nil viewModel:viewModel andShowSocButtons:showSocButtons];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(id)viewModel andShowSocButtons:(BOOL)showSocButtons
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.alpha = (float)showSocButtons;
        if ([viewModel isKindOfClass:[DRegistrationViewModel class]]) {
            _registrationViewModel = viewModel;
            //return model.cellArray[indexPath.row];
        }else{
            _loginViewModel = viewModel;
           // return model.cellsArray[indexPath.row];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
self.view.backgroundColor = SYSTEM_COLOR;
    [_fbButton.layer setCornerRadius:4];
    [_okButton.layer setCornerRadius:4];
    [_vkButton.layer setCornerRadius:4];
    [_fbButton.layer setMasksToBounds:YES];
    [_okButton.layer setMasksToBounds:YES];
    [_vkButton.layer setMasksToBounds:YES];
    
    self.screenLabel.delegate = self;
    [self.screenButton setAlpha:_alpha];
    [self.socView setAlpha:_alpha];
    UIImage *img = [UIImage imageNamed:@"ico"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imgView setImage:img];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    if (_registrationViewModel) {
        
        [_registrationViewModel getModelWithController:self callBack:^(DRegistrationViewModel *model) {
            _registrationViewModel = model;
            
         //  [self.tableView reloadData];
        }];
        
    }else{
        // _loginViewModel = viewModel;
       
        [_loginViewModel setupUIWhithController:self];
    }

    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (_registrationViewModel) {
        //_registrationViewModel = viewModel;
        return _registrationViewModel.cellArray.count;
    }else{
        // _loginViewModel = viewModel;
        return _loginViewModel.cellArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_registrationViewModel) {
        //_registrationViewModel = viewModel;
        return _registrationViewModel.cellArray[indexPath.row];
    }else{
       // _loginViewModel = viewModel;
         return _loginViewModel.cellArray[indexPath.row];
    }
}


#pragma mark - Tap Handler

- (void)addTapHandler {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)action:(id)sender {
    [self.view endEditing:YES];
    [_loginViewModel setLoginStep:enumForg];
    [self.navigationController pushViewController:[DEntranceViewController showEntranceViewControllerWithViewModel:_loginViewModel andShowSocButtons:NO] animated:YES];
}
- (IBAction)okAction:(id)sender {
    
    [self.loginViewModel okLogin];
}

- (IBAction)vkAction:(id)sender {
    
    [self.loginViewModel vkLogin];
}

- (IBAction)fbAction:(id)sender {
    
    [self.loginViewModel fbLogin];
}


@end

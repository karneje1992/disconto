//
//  MVVMSettingsViewController.m
//  Disconto
//
//  Created by Rostislav on 09.12.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "MVVMSettingsViewController.h"
#import "DSettingsViewModel.h"

@interface MVVMSettingsViewController ()

@property DSettingsViewModel *modelView;
@end

@implementation MVVMSettingsViewController

+ (instancetype)showSettingsWithModelView:(id)modelView{

    return [[MVVMSettingsViewController alloc] initWithNibName:NSStringFromClass([MVVMSettingsViewController class]) bundle:nil andModelView:modelView];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andModelView:(id)modelView
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modelView = modelView;
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

    if (!self.modelView.cellsArray.count) {
        [self.modelView updateViewWithController:self callBack:^(__autoreleasing id model) {
            
            self.modelView = model;
            [self.tableView reloadData];
        }];
    }
    

    
}

#pragma mark - tableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.modelView.cellsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.modelView.cellsArray[indexPath.row];
}
- (IBAction)pass:(id)sender {
    
    [self.modelView changePassword];
}

- (IBAction)tutorial:(id)sender {
    
    [self.modelView tuter];
}

- (IBAction)doc:(id)sender {
    
    [self.modelView showLicens];
}
@end

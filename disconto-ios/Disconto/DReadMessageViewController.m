//
//  DReadMessageViewController.m
//  Disconto
//
//  Created by user on 24.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DReadMessageViewController.h"

@interface DReadMessageViewController ()<DTutorialViewControllerDelegate, SWRevealViewControllerDelegate,DMoneyViewControllerDelegate>

@property NSArray<DMessageModel *> *messeges;
@property NSArray *cells;
@property DMessageModel *activeMessage;
@property SWRevealViewController *revealVC;
@property UITapGestureRecognizer *singleFingerTap;
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@end

@implementation DReadMessageViewController

+ (instancetype)getMessagesWithArray:(NSArray *)array{
    
    return [[DReadMessageViewController alloc] initWithNibName:NSStringFromClass([DReadMessageViewController class]) bundle:nil andMessages:array];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andMessages:(NSArray<DMessageModel *> *)messages
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.messeges = messages;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cells = @[];
    
    
    [self customSetup];
    self.title = @"Сообщения";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    SHOW_PROGRESS;
    [DMessageModel getMessagesFromServerWithCallBack:^(NSArray *resault, NSInteger unreaded) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            self.messeges = resault;
            
            self.cells = [DMessageCells cellsArrayWithMessageArray:self.messeges andTableView:self.tableView];
            
            [self.tableView reloadData];
            HIDE_PROGRESS;
        });
        
    }];
    
}

- (void)customSetup {
    _revealVC = self.revealViewController;
    _revealVC.delegate = self;
    _revealVC.rearViewRevealWidth = self.view.bounds.size.width*0.9;
    if ( _revealVC )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
    
}

- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 88;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cells.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.cells[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.activeMessage = self.messeges[indexPath.row];
    self.activeMessage.readit = YES;
    [[[UIAlertView alloc] initWithTitle:self.activeMessage.message message:nil delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil] show];
    [tableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (self.activeMessage.isTutorial) {
        
        DTutorialViewController *vc = [DTutorialViewController showTutorialWithImgArray:[DSuperViewController getTutorial] andShowButton:NO];
        vc.delegate = self;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
        [DMessageModel readedMessage:self.activeMessage withCallBack:^(BOOL succses) {
            
            if (succses) {
                
                self.activeMessage.readit = YES;
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [DMessageModel getMessagesFromServerWithCallBack:^(NSArray *resault, NSInteger unreaded) {
                        
                        self.cells = [DMessageCells cellsArrayWithMessageArray:self.messeges andTableView:self.tableView];
                        [self.tableView reloadData];
                    }];
                    
                });
                
            }
        }];
   
}

- (void)exitTutorialViewController:(id)controller{
    
    DTutorialViewController * vc = controller;
    [vc.navigationController popViewControllerAnimated:YES];
}

- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position{
    
    if (!_singleFingerTap) {
        _singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        _singleFingerTap.numberOfTapsRequired = 1;
        [self.view addGestureRecognizer:_singleFingerTap];
    }else{
        
        [self.view removeGestureRecognizer:_singleFingerTap];
        _singleFingerTap = nil;
    }
    
}
@end

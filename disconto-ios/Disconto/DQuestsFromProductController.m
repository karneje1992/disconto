//
//  DQuestsFromProductController.m
//  Disconto
//
//  Created by Ross on 22.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DQuestsFromProductController.h"

@interface DQuestsFromProductController ()

@property (strong, nonatomic)MPMoviePlayerViewController * moviePlayerViewController;
@property DQuestModel *firstQuest;
@property BOOL landscape;
@property NSMutableArray *questArray;

@end

@implementation DQuestsFromProductController

+ (instancetype)openQuests:(DProductModel *)product{
    
    return [[DQuestsFromProductController alloc] initWithNibName:NSStringFromClass([DQuestsFromProductController class]) bundle:nil andProduct:product];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andProduct:(DProductModel *)product
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.questArray = @[].mutableCopy;
        [DProductModel updateProduct:product withCollBack:^(DProductModel *obj) {
            
            self.product = obj;
            self.questArray = obj.quests.mutableCopy;
            self.firstQuest = [self.questArray firstObject];
            [self showQuest:self.firstQuest];
            
        }];
    }
    return self;
}

- (void)startLoad{

}

- (void)exitWebView:(id)controller{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Задание";
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain
                                             target:self action:@selector(back)];
    [self.action setAlpha:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.action setAlpha:0];
}

- (void)showQuest:(DQuestModel *)quest{
    [self.action setAlpha:1];
    SHOW_PROGRESS;
    self.timer = [DTimer new];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = self.firstQuest.title;
    self.timer.timerDelegate = self;
    [self.timer setTimeDown:self.firstQuest.timeOutQuest];
    
    switch (self.firstQuest.questType) {
        case video: {
            
            [self showVideoPlayer];
        }
            break;
        case visit: {
            
            DShowWebSiteController *vc = [DShowWebSiteController showWebViewWithURL:quest.questSiteURL];
            [self addChildViewController:vc];
            [vc.view setFrame:self.contentView.frame];
            [self.contentView addSubview:vc.view];
            
            [self.timer starTimer];
        }
            break;
        case share: {
            
            DSocialViewController *vc = [DSocialViewController showSharedWithQuest:self.firstQuest andProduct:self.product];
            vc.delegate = self;
            [self addChildViewController:vc];
            [vc.view setFrame:self.contentView.frame];
            [self.contentView addSubview:vc.view];
            [self.action setAlpha:0];
        }
            break;
        default:{
            
            if (self.firstQuest.questType == fact) {
                
                sleep(2);
                [self.timer starTimer];
            }
            DTableViewQuestController *vc = [DTableViewQuestController showQuest:self.firstQuest];
            vc.delegate = self;
            [self addChildViewController:vc];
            [vc.view setFrame:self.contentView.frame];
            [self.contentView addSubview:vc.view];
            
        }
            break;
    }
    if (self.firstQuest.questType != share) {
    
    if (self.questArray.count <= 1) {
        
            [self buttonWithQuest:nil andTitleButton:titleDone];
        }
        
        
        if (question == self.firstQuest.questType) {
            [self buttonWithQuest:self.firstQuest andTitleButton:@"Выберите ответ"];
       
    }else{
        
        [self buttonWithQuest:self.firstQuest andTitleButton:titleNext];
    }
        }
    HIDE_PROGRESS;
}

- (void)showVideoPlayer {
    
    SHOW_PROGRESS;
    [self.action setAlpha:0];
    if (self.firstQuest.questVideoURL) {
        self.moviePlayerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:self.firstQuest.questVideoURL.absoluteString]];
        
        [self.moviePlayerViewController.moviePlayer setControlStyle:MPMovieControlStyleNone];
        [self.moviePlayerViewController.moviePlayer setShouldAutoplay:YES];
        [self.moviePlayerViewController.moviePlayer setFullscreen:YES animated:YES];
        [self.moviePlayerViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self.moviePlayerViewController.moviePlayer setScalingMode:MPMovieScalingModeNone];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self.moviePlayerViewController
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:self.moviePlayerViewController.moviePlayer];
        
        // Register this class as an observer instead
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:self.moviePlayerViewController.moviePlayer];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(MPMoviePlayerLoadStateDidChange:)
                                                     name:MPMoviePlayerLoadStateDidChangeNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleMPMoviePlayerPlaybackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        
        [self addChildViewController:self.moviePlayerViewController];
        [self.moviePlayerViewController.view setFrame:self.contentView.frame];
        [self.contentView addSubview:self.moviePlayerViewController.view];
        self.moviePlayerViewController.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
        NSLog(@"%f",self.moviePlayerViewController.moviePlayer.currentPlaybackTime);
    
    }else{
    
        [self action:self];
    }
    HIDE_PROGRESS;
   
}

- (void)handleMPMoviePlayerPlaybackDidFinish:(NSNotification *)notification
{
    NSDictionary *notificationUserInfo = [notification userInfo];
    NSNumber *resultValue = [notificationUserInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    MPMovieFinishReason reason = [resultValue intValue];
    if (reason == MPMovieFinishReasonPlaybackError)
    {
        NSError *mediaPlayerError = [notificationUserInfo objectForKey:@"error"];
        if (mediaPlayerError)
        {
            NSLog(@"playback failed with error description: %@", [mediaPlayerError localizedDescription]);
        }
        else
        {
            NSLog(@"playback failed without any given reason");
        }
    }
}

- (void)MPMoviePlayerLoadStateDidChange:(NSNotification *)notification
{
    if ((self.moviePlayerViewController.moviePlayer.loadState & MPMovieLoadStatePlaythroughOK) == MPMovieLoadStatePlaythroughOK)
    {
        [self.timer setTimeDown:self.moviePlayerViewController.moviePlayer.duration];
        [self.timer starTimer];
    }
}

- (void)movieFinishedCallback:(NSNotification*)aNotification {
    
    MPMoviePlayerController *moviePlayer = aNotification.object;
    MPMoviePlaybackState playbackState = moviePlayer.playbackState;
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
        {
            NSLog(@"MPMoviePlaybackStateStopped");
            break;
        }
            
        case MPMoviePlaybackStatePlaying:
        {
            NSLog(@"MPMoviePlaybackStatePlaying");
            break;
        }
            
        case MPMoviePlaybackStatePaused:
        {
            [self action:self];
            break;
        }
            
        case MPMoviePlaybackStateInterrupted:
        {
            NSLog(@"MPMoviePlaybackStateInterrupted");
            break;
        }
            
        case MPMoviePlaybackStateSeekingForward:
        {
            NSLog(@"MPMoviePlaybackStateSeekingForward");
            break;
        }
            
        case MPMoviePlaybackStateSeekingBackward:
        {
            NSLog(@"MPMoviePlaybackStateSeekingBackward");
            break;
        }
            
    }
}

- (IBAction)action:(id)sender {
    
    SHOW_PROGRESS;

    self.moviePlayerViewController = nil;
    [self.questArray removeObject:[self.questArray firstObject]];
    if (self.firstQuest) {
        [self.firstQuest compliteWithProduct:self.product CollBack:^(DQuestModel *obj) {
            
            if (obj) {
                if (self.questArray.count > 0) {
                    self.firstQuest = [self.questArray firstObject];
                    [self showQuest:self.firstQuest];
                }else{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
            
                [DProductModel updateProduct:_product withCollBack:^(DProductModel *obj) {
                    
                    self.product = obj;
                    self.questArray = obj.quests.mutableCopy;
                    self.firstQuest = [self.questArray firstObject];
                    [self showQuest:self.firstQuest];
                    
                }];
            }

            HIDE_PROGRESS;
        }];
    }
    
    [self.action setEnabled:NO];
}

#pragma mark - DTimerDelgate

- (void)currentSecond:(NSInteger)currentSecond{
    
    [self.action setAlpha:1];
    if (currentSecond > 1) {
        [self buttonWithQuest:self.firstQuest andTitleButton:self.timer.secondString];
        return;
    }
    else if (currentSecond <= 1 && self.questArray.count <= 1){
        
        if (self.firstQuest.questType != share)
        [self buttonWithQuest:nil andTitleButton:titleDone];
        return;
    }
    else{
        
        [self buttonWithQuest:nil andTitleButton:titleNext];
        return;
    }
    
}

- (void)buttonWithQuest:(DQuestModel *)quest andTitleButton:(NSString *)titleButton{
    
    if (quest) {
        [self.action setBackgroundColor: self.firstQuest.questType == video ? [UIColor clearColor]:[UIColor lightGrayColor]];
        [self.action setEnabled:NO];
        self.action.layer.cornerRadius = 4;
        switch (quest.questType) {
            case fact:
            case video:
            case visit: {
                
            }
                break;
                
            case question:
            case share:{
                
                [self.action setAlpha:0];
            }
                break;
            default:
                break;
        }
    }else{
        
        [self.action setBackgroundColor:SYSTEM_COLOR];
        [self.action setEnabled:YES];
    }
    
    [self.action setTitle:titleButton forState:UIControlStateNormal];
    // [self.action setAlpha:1];
}

#pragma mark - SharedDelegate

- (void)sharedComplit{
    
    [self action:self];
}

#pragma mark - AnswerDelegate

- (void)answerComplit{
    
    self.action.alpha = 1;
    if (self.questArray.count <= 1) {
        [self buttonWithQuest:nil andTitleButton:titleDone];
        
    }else{
        
        [self buttonWithQuest:nil andTitleButton:titleNext];
    }
}

#pragma mark - back button action

- (void)back{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:extQuestTitle message:extQuestMessege preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Да" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (self.moviePlayerViewController) {
            [self.moviePlayerViewController.moviePlayer stop];
            // [self.navigationController popViewControllerAnimated:YES];
        }
        [alert dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Нет" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
  //  [[[UIAlertView alloc] initWithTitle:extQuestTitle message: delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil] show];
//
//    if (self.firstQuest.questType != video) {
//          [[[UIAlertView alloc] initWithTitle:extQuestTitle message:extQuestMessege delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil] show];
//    }else{
//    
//        if (self.moviePlayerViewController) {
//            [self.moviePlayerViewController.moviePlayer stop];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }
  
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex > 0) {
        if (self.moviePlayerViewController) {
            [self.moviePlayerViewController.moviePlayer stop];
           // [self.navigationController popViewControllerAnimated:YES];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

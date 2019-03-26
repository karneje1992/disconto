//
////
////  ForceCubeScanViewController.m
////  ForseCubeDiscontoDemo
////
////  Created by Rostislav on 12/27/16.
////  Copyright © 2016 Devium. All rights reserved.
////
//
//#import "ForceCubeScanViewController.h"
//
//@interface ForceCubeScanViewController ()<FCBDataWriter>
//
//@property id<FCBCampaignOffer> forceCubeModel;
//@property NSData *imageData;
//@end
//
//
//@implementation ForceCubeScanViewController
//
//+ (instancetype)showScanSceenWithOffer:(id<FCBCampaignOffer>)forceCubeModel{
//
//    return [[ForceCubeScanViewController alloc] initWithNibName:NSStringFromClass([ForceCubeScanViewController class]) bundle:nil offer:forceCubeModel];
//}
//
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(id<FCBCampaignOffer>)forceCubeModel
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        
//        self.forceCubeModel = forceCubeModel;
//    }
//    return self;
//}
//
//+ (instancetype)showScanWithData:(NSData *)data{
//
//    return [[ForceCubeScanViewController alloc] initWithNibName:NSStringFromClass([ForceCubeScanViewController class]) bundle:nil data:data];
//}
//
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data:(NSData *)data
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        
//        self.imageData = data;
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//
//    [super viewWillAppear:animated];
//    if (self.forceCubeModel) {
//        [[[DForceCubeSubClass activeForceCube] dataWriter] setCampaignOfferId:*(NSUInteger *)[self.forceCubeModel campaignOfferId]];
//        [[[DForceCubeSubClass activeForceCube] dataWriter] setDelegate:self];
//    }
//
//  //  [[DForceCubeSubClass activeForceCube].dataWriter ]
//}
////
//- (void) dataWriterDidStartDataWriting: (id<FCBDataWriter>) dataWriter {
//    
//    // Show activity indicator to the user
//}
////
//- (void) dataWriter: (id<FCBDataWriter>) dataWriter didFailToStartWritingWithError: (NSError *) error {
//    // Something bad happend, show error123321
//    
//        [[[DForceCubeSubClass activeForceCube] campaignManager] setCampaignOfferAsAccepted:[self.forceCubeModel campaignOfferId]];
//    // Clear data writing context
//    dataWriter.campaignOfferId = kFCBDataWriterCampaignOfferIdNotSet;
//    [self.navigationController popViewControllerAnimated:YES];
//    dataWriter.delegate = nil;
//}
////
//- (void) dataWriter: (id<FCBDataWriter>) dataWriter didFinishWritingWithError: (NSError *) error
//{
//    if (error) {
//        
//        // Something bad happend, show error
//    }
//    else {
//
//        [self alarm];
//        RESTART;
//    }
//    
//    
//    // Clear data writing context
//    dataWriter.campaignOfferId = kFCBDataWriterCampaignOfferIdNotSet;
//    dataWriter.delegate = nil;
//}
////
//- (void)alarm{
//
//    UILocalNotification *notific = [[UILocalNotification alloc] init];
//    [notific setHasAction:YES];
//    [notific setFireDate:[[NSDate date] dateByAddingTimeInterval:couponTimeOut]];
//    [notific setAlertBody:[NSString stringWithFormat:@"Купон %@ использован",[self.forceCubeModel fullscreenTitle]]];
//    [notific setAlertTitle:@"Дисконто"];
//    [notific setSoundName:@"push.caf"];
//    [notific setHasAction:YES];
//    SHOW_MESSAGE(notific.alertTitle, notific.alertBody);
////    [notific.userInfo setValuesForKeysWithDictionary:@{@"offerID":[NSString stringWithFormat:@"%@",@([self.forceCubeModel campaignOfferId])]}];
//    [[UIApplication sharedApplication] scheduleLocalNotification:notific];
//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    // this is imporant - we set our input date format to match our input string
//    // if format doesn't match you'll get nil from your string, so be careful
//    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:s"];
//    NSString *dateText = [dateFormatter stringFromDate:[NSDate date]];
//
//    [[NSUserDefaults standardUserDefaults] setObject:dateText forKey:@"alarmDate"];
//    [[NSUserDefaults standardUserDefaults] setObject:@([self.forceCubeModel campaignOfferId]) forKey:@"alarmID"];
//}
//
//@end

//
//  DSubPageTutorialController.m
//  Disconto
//
//  Created by user on 20.07.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DSubPageTutorialController.h"
#import "DCircleViewController.h"
#import "DSingleOfferViewController.h"
#import "DSingleOfferViewModel.h"

//static const NSInteger sceenTuturialCount = 8;

@interface DSubPageTutorialController ()

@property NSMutableArray *imagesNameArray;
@property NSInteger imageIndex;
@property NSArray *imgArray;
@end

@implementation DSubPageTutorialController

+ (instancetype)showPageForIndex:(NSInteger)pageIndex andImageArray:(NSArray *)imageArray andShowButton:(BOOL)showButton{
    
    return [[DSubPageTutorialController alloc] initWithNibName:NSStringFromClass([DSubPageTutorialController class]) bundle:nil andImgArray:imageArray andIndexImage:pageIndex andShowButton:showButton];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andImgArray:(NSArray *)imgArray andIndexImage:(NSInteger)indexImage andShowButton:(BOOL)showButton
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        if (imgArray.count >= 1) {
            self.imagesNameArray = @[].mutableCopy;
            self.imageIndex = indexImage;
            self.imagesNameArray = imgArray.mutableCopy;
            self.actionButton.alpha = showButton;
        }else{
            
            SHOW_MESSAGE(@"", @"Инструкция отсутствует !");
            RESTART;
        }
        
    }
    return self;
}

+ (instancetype)showPageForIndex:(NSInteger)pageIndex andImageArray:(NSArray *)imageArray{
    
    return [[DSubPageTutorialController alloc] initWithNibName:NSStringFromClass([DSubPageTutorialController class]) bundle:nil divaceTypeString:[NSString stringWithFormat:@"%@",[[UIDevice currentDevice] model]] imageIndex:pageIndex andImageArray:imageArray];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil divaceTypeString:(NSString *)divaceTypeString imageIndex:(NSInteger)imageIndex andImageArray:(NSArray *)imageArray
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.imagesNameArray = @[].mutableCopy;
        self.imageIndex = imageIndex;
        self.imagesNameArray = imageArray.mutableCopy;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [StyleChangerClass changeBorderToButton:self.actionButton];
    
    if (self.offer) {
        if (self.imagesNameArray.count < 1 && self.showButton) {
            
            [self.navigationController popToRootViewControllerAnimated:NO];
        }else{
            
            [self.tutorialImageView sd_setImageWithURL:[NSURL URLWithString:_imagesNameArray[_imageIndex]]];
            
            
            if (self.offer.unloced) {
                
                
                [self.actionButton setTitle:!self.offer.unloced?@"Участвовать" : @"Продолжить" forState:UIControlStateNormal];
            }else{
                
                if (_imageIndex != self.imagesNameArray.count-1) {
                    
                    [_actionButton setAlpha:0];
                }else{
                    
                    [_actionButton setAlpha:1];
                }
            }
        }
        
    }else{
        
        [self.tutorialImageView setImage:[UIImage imageNamed:_imagesNameArray[_imageIndex]]];
        self.actionButton.alpha = !(!self.offer);
    }
    
    // [self.tutorialImageView setBackgroundColor:SYSTEM_COLOR];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (IBAction)showWebView:(id)sender {
    
    if (self.offer.unloced) {
        
        if (_offer.gameID) {
            
            [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/games/%@",self.offer.gameID] withCallBack:^(BOOL success, NSDictionary *resault) {
                
                if (success) {
                    
                    DCircleViewController *vc = [DCircleViewController showCircleViewContrlllerWithModel:[[DCircleViewModel alloc] initWithParammetr:@{@"background":resault[@"data"][@"background"],@"image":resault[@"data"][@"image"],@"angle":resault[@"data"][@"angle"],@"pointer":resault[@"data"][@"pointer"],@"message":resault[@"data"][@"message"],@"label":resault[@"data"][@"label"],@"logo":resault[@"data"][@"logo"],@"id":resault[@"data"][@"id"]}]];
                    vc.gemeID = self.offer.gameID;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:NO];
                }
            }];
        }else{
            [self.navigationController pushViewController:[DSingleOfferViewController showSingleOfferWithViewModel:[DSingleOfferViewModel showSingleOffer:_offer]] animated:YES];
        }
    }else{
        
        [[NetworkManeger sharedManager] sendPostRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/promo/%@",self.offer.offerID] withCallBack:^(BOOL success, NSDictionary *resault) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                if (success) {
                    
                    if (_offer.gameID) {
                        
                        [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:[NSString stringWithFormat:@"/games/%@",self.offer.gameID] withCallBack:^(BOOL success, NSDictionary *resault) {
                            
                            if (success) {
                                
                                DCircleViewController *vc = [DCircleViewController showCircleViewContrlllerWithModel:[[DCircleViewModel alloc] initWithParammetr:@{@"background":resault[@"data"][@"background"],@"image":resault[@"data"][@"image"],@"angle":resault[@"data"][@"angle"],@"pointer":resault[@"data"][@"pointer"],@"message":resault[@"data"][@"message"],@"label":resault[@"data"][@"label"],@"logo":resault[@"data"][@"logo"],@"id":resault[@"data"][@"id"]}]];
                                vc.gemeID = self.offer.gameID;
                                vc.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:vc animated:NO];
                            }
                        }];
                    }else{
                        
                        [self.navigationController pushViewController:[DSingleOfferViewController showSingleOfferWithViewModel:[DSingleOfferViewModel showSingleOffer:_offer]] animated:YES];
                    }
                    
                }else{
                    
                    SHOW_MESSAGE(resault[@"message"], nil);
                }
            });
            
        }];
    }
    
    
    
    
}

- (void)startLoad{
    
}

- (void)exitWebView:(id)controller{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end

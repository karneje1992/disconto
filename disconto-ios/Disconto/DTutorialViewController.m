//
//  DTutorialViewController.m
//  Disconto
//
//  Created by user on 20.07.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DTutorialViewController.h"
#import "DSubPageTutorialController.h"

@interface DTutorialViewController ()

@property NSMutableArray <UIImage *> *imgArray;
@property BOOL showButton;

@end

@implementation DTutorialViewController

+ (instancetype)showTutorialWithImgArray:(NSArray *)urlArray andShowButton:(BOOL)showButton{
    
    return [[DTutorialViewController alloc] initWithNibName:NSStringFromClass([DTutorialViewController class]) bundle:nil andImageArray:urlArray  andShowButton:(BOOL)showButton];
}

+ (instancetype)showTutorialWithUrlArray:(NSArray *)urlArray andShowButton:(BOOL)showButton{

    return [[DTutorialViewController alloc] initWithNibName:NSStringFromClass([DTutorialViewController class]) bundle:nil andImageURLArray:urlArray  andShowButton:(BOOL)showButton];
}

+ (instancetype)showLocaleTutorial{

    return [[DTutorialViewController alloc] initWithNibName:NSStringFromClass([DTutorialViewController class]) bundle:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andImageURLArray:(NSArray *)imageURLArray andShowButton:(BOOL)showButton{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _imgArray = @[].mutableCopy;
        _imgArray = imageURLArray.mutableCopy;
        self.showButton = showButton;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _imgArray = @[].mutableCopy;
        
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andImageArray:(NSArray *)imageURLArray andShowButton:(BOOL)showButton
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _imgArray = @[].mutableCopy;
        _imgArray = imageURLArray.mutableCopy;
        self.showButton = showButton;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(DOfferModel *)offer
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _imgArray = @[].mutableCopy;
        _imgArray = offer.instuctions.mutableCopy;
        self.offer = offer;
    }
    return self;
}

+ (instancetype)showOfferInstruction:(DOfferModel *)offer{

    return [[DTutorialViewController alloc] initWithNibName:NSStringFromClass([DTutorialViewController class]) bundle:nil offer:offer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view setBackgroundColor:SYSTEM_COLOR];
    [self.contentView setBackgroundColor:SYSTEM_COLOR];
    
    [self.pageStep setNumberOfPages:self.imgArray.count];
    [self showPageForIndex:self.pageStep.currentPage];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(didSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(didSwipe:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    

    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self.pageStep.currentPage+1 < self.pageStep.numberOfPages) {
            
            [self showPageForIndex:self.pageStep.currentPage+1];
        }else{

            [self.delegate exitTutorialViewController:self];
        }
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [self showPageForIndex:self.pageStep.currentPage-1];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"Swipe Up");
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"Swipe Down");
    }
}

- (void)showPageForIndex:(NSInteger)index{

    if (index >= 0) {
        
        for (UIView *view in self.contentView.subviews) {
            
            [view removeFromSuperview];
        }
        self.pageStep.currentPage = index;

         DSubPageTutorialController *vc = !self.offer ? [DSubPageTutorialController showPageForIndex:index andImageArray:_imgArray] : [DSubPageTutorialController showPageForIndex:index andImageArray:self.imgArray andShowButton:self.showButton];
        vc.offer = self.offer;
        [self addChildViewController:vc];
        [vc.view setFrame:self.contentView.bounds];
        [self.contentView addSubview:vc.view];
    }
}

@end

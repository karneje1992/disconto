//
//  DStartTutorialViewController.m
//  Disconto
//
//  Created by user on 31.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DStartTutorialViewController.h"
#define amountOfTutorials 5
#define deltaY 1.5

@interface DStartTutorialViewController ()

@end

@implementation DStartTutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pageControl setAlpha:0];
    if([[UIScreen mainScreen] bounds].size.height == 480) // iphone 4
    {
        _k = 1;
    }
    else // iphone 5,6
    {
        _k = 0.8;
    }
    
    [self getInformationForScroller];
    
    _animator = [[ParallaxScrollingFramework alloc] initWithScrollView:_myScrollView];
    
    _pageControl.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-100, [[UIScreen mainScreen] bounds].size.width, 66);
    //    _logoImageView.frame = CGRectMake(_logoImageView.frame.origin.x, 240, _logoImageView.frame.size.width, _logoImageView.frame.size.height); // show logo in center at start
    
    if (self.view.frame.size.height == 480) {
        
        self.logoImageView.frame = CGRectMake(55,190,210,133);
    }

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Cool Tutorial View
// this method allows user to change images or buttons without scrolling, just by clicking at the UIPageControl
-(IBAction)clickPageControl:(id)sender
{
    int page = (int)_pageControl.currentPage;
    CGRect frame = _myScrollView.frame;
    frame.origin.x = frame.size.width*page;
    frame.origin.y = 0;
    [_myScrollView scrollRectToVisible:frame animated:YES]; // scrolls the content view so that the area defined by rect is just visible
}
-(void)getInformationForScroller{
    NSString *imageName;
    UIImage *image;
    UIImageView *imageView;
    for(int i=0 ; i<amountOfTutorials ; i++) // this cycle downloads some photos or buttons to the scrollView
    {
        imageName = [NSString stringWithFormat:@"%ds.png",i]; // getting name of image file
        image = [UIImage imageNamed:imageName]; // creating image
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake((i)*[[UIScreen mainScreen] bounds].size.width+50, [[UIScreen mainScreen] bounds].size.height*0.3, [[UIScreen mainScreen] bounds].size.width-100, [[UIScreen mainScreen] bounds].size.height*0.5);
        //imageView.alpha = 0.6;
        [_myScrollView addSubview:imageView]; // ad this button to scrollerView
    }
    _myScrollView.delegate=self; // standart
    _myScrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width*amountOfTutorials, [[UIScreen mainScreen] bounds].size.height); // the size(square) of scrollVIew,
    _myScrollView.pagingEnabled=YES; // enables to scroll images or buttons like pages (very useful)
    _pageControl.numberOfPages=amountOfTutorials; // how many points at the bottom we will have (UIPageControl)
    //pageControl.currentPageIndicatorTintColor=[UIColor grayColor];
}


// This function changes point at the ViewPageController when we scrolling images or anything else
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int page = scrollView.contentOffset.x / scrollView.frame.size.width; // some mathematical operations that give us the number of current page
    _pageControl.currentPage=page;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // NSLog(@"scroll offset is %f",scrollView.contentOffset.x);
    _panoramaImageView.frame = CGRectMake(-_myScrollView.contentOffset.x-300, _panoramaImageView.frame.origin.y, _panoramaImageView.frame.size.width, _panoramaImageView.frame.size.height);
    
    float x = scrollView.contentOffset.x;
    
    if (x < 0) // when user swipe right on the first screen - we make size of element bigger
    {

    }
    else if (x <=[[UIScreen mainScreen] bounds].size.width) //  first-second screens
    {
        // element moves on top with animation
        [self.animator setKeyFrameWithOffset:x
                                   translate:CGPointMake(0, -x/deltaY)
                                       scale:CGSizeMake(1, 1)
                                      rotate:0
                                       alpha:1
                                     forView:_logoImageView];
    }
    
    else if (x >[[UIScreen mainScreen] bounds].size.width && x <=[[UIScreen mainScreen] bounds].size.width*3)  //  second-fourth screens
    {
        // nothing here
        NSLog(@"1");
    }
    
    else if (x >[[UIScreen mainScreen] bounds].size.width*3+150 && x <= [[UIScreen mainScreen] bounds].size.width*4) // last screen 5
    {
        if (self.view.frame.size.height == 480) {
            
            [self.animator setKeyFrameWithOffset:x
                                       translate:CGPointMake(0, -x/1 + (([[UIScreen mainScreen] bounds].size.width*3)+160)/1)
                                           scale:CGSizeMake(1, 1)
                                          rotate:0
                                           alpha:1
                                         forView:_startButton];
            NSLog(@":DDD");
            
            
        } else {
            
            [self.animator setKeyFrameWithOffset:x
                                       translate:CGPointMake(0, -x/1 + (([[UIScreen mainScreen] bounds].size.width*3)+150)/1)
                                           scale:CGSizeMake(1, 1)
                                          rotate:0
                                           alpha:1
                                         forView:_startButton];
            
        }
        
        
        [self.animator setKeyFrameWithOffset:x
                                   translate:CGPointMake(0, -[[UIScreen mainScreen] bounds].size.width/deltaY+((x-[[UIScreen mainScreen] bounds].size.width*3)-150)/_k)
                                       scale:CGSizeMake(1, 1)
                                      rotate:0
                                       alpha:1
                                     forView:_logoImageView];
        
        NSLog(@"2");
    }
    
    if(x >[[UIScreen mainScreen] bounds].size.width*3 && x <= [[UIScreen mainScreen] bounds].size.width*4) // special condition for page control on last screen
    {
        [_logoImageView setAlpha:0];
        [self.animator setKeyFrameWithOffset:x
                                   translate:CGPointZero
                                       scale:CGSizeMake(1, 1)
                                      rotate:0
                                       alpha:1 - (x-960)/320
                                     forView:_logoImageView];
        
        NSLog(@"3");
    }
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}



- (IBAction)startButtonTapped:(id)sender
{
    // authentication
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [sb instantiateInitialViewController];// Or any VC with Id
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = vc; // PLEASE READ NOTE ABOUT THIS LINE
    [UIView transitionWithView:appDelegate.window
                      duration:1.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ appDelegate.window.rootViewController = vc; }
                    completion:nil];
}


@end

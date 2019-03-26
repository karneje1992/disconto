//
//  DTabBarController.m
//  Disconto
//
//  Created by user on 11.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DTabBarController.h"

@interface DTabBarController ()

@end

@implementation DTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.barTintColor =  SYSTEM_NAV;
    self.navigationController.navigationBar.barTintColor = SYSTEM_NAV;
    self.delegate = self;
    UITabBar *tabBar = self.tabBar;
    self.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.tabBar.tintColor = [UIColor whiteColor];
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:2];
    _couponItem = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    [tabBarItem1 setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                               forState:UIControlStateNormal];
    [tabBarItem2 setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                               forState:UIControlStateNormal];
    [tabBarItem3 setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                               forState:UIControlStateNormal];
    [_couponItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                               forState:UIControlStateNormal];
    [tabBarItem5 setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                               forState:UIControlStateNormal];
    
    tabBarItem1.image = [tabBarItem1.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem2.image = [tabBarItem2.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem3.image = [tabBarItem3.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _couponItem.image = [_couponItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem5.image = [tabBarItem5.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    if ([item.title isEqualToString:@"Category"]) {
        
    }
    
    if ([item.title isEqualToString:@"Shops"]) {
        
    }
    if ([item.title isEqualToString:imgProfile]) {
        
    }
    if ([item.title isEqualToString:@"Cache"]) {
        
    }
    
}

#pragma Tab bar delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == 0) {
        
        UINavigationController *navigationContrller = (UINavigationController *)tabBarController.selectedViewController;
        [navigationContrller popToRootViewControllerAnimated:NO];
        //   [AVHelper showRootViewController:@"tabbar"];
    }
    if (tabBarController.selectedIndex == 1 || tabBarController.selectedIndex == 2)
    {
        UINavigationController *navigationContrller = (UINavigationController *)tabBarController.selectedViewController;
        [navigationContrller popToRootViewControllerAnimated:NO];
        
    }
    
}
@end

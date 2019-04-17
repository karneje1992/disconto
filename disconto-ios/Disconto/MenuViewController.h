//
//  MenuViewController.h
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, menuSectionEnum) {
    menuDefaultSection = 0,
    menuSettingsSection,
    menuExitSection,
    menuCountSection
};

typedef NS_ENUM(NSInteger, menuSegueEnum) {
    segueDefault = 0,
    segueSettings,
    segueSupport
};

@interface MenuViewController : UITableViewController

@property NSMutableArray *cellsArray;
@property NSMutableArray *settingsCells;
@property NSMutableArray *exitCells;
@property NSArray *messages;
@property UILabel *label;
@end

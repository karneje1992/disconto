//
//  DInputCell.h
//  Disconto
//
//  Created by user on 01.04.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TextViewType) {
    qfirstName = 0,
    qlastName,
    qemail,
    qphone,
    qcity,
    qcountTextViewType
};

@interface DInputCell : DMainTableViewCell

@property (weak, nonatomic) IBOutlet UITextField *settingEditTextField;

- (void)changeTextField:(UITextField *)textField andControllerDeleget:(id)controller withTextFildType:(NSInteger)textFieldType;
+ (void)addSubviewToTextField:(UITextField *)textField;
+ (void)clearSubViewWithTextField:(UITextField *)textField;
+ (void)setPlaceholder:(NSString *)placeholder toTextField:(UITextField *)textField;

@end

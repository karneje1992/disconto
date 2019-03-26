//
//  DInputCell.m
//  Disconto
//
//  Created by user on 01.04.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import "DInputCell.h"

@implementation DInputCell

#pragma mark - PublicMethods

- (void)changeTextField:(UITextField *)textField andControllerDeleget:(id)controller withTextFildType:(NSInteger)textFieldType{
    
    [self.settingEditTextField setDelegate:controller];
    
    textField.delegate = controller;
    switch (textFieldType) {
        case qfirstName:{
            [DInputCell setPlaceholder:@"Имя" toTextField:textField];
            [textField setKeyboardType:UIKeyboardTypeDefault];
            break;
        }
        case qlastName:{
            [DInputCell setPlaceholder:@"Фамилия" toTextField:textField];
            [textField setKeyboardType:UIKeyboardTypeDefault];
            break;
        }
        case qemail:{
            [DInputCell setPlaceholder:@"Почта" toTextField:textField];
            [textField setKeyboardType:UIKeyboardTypeEmailAddress];
            break;
        }
        case qphone:{
            [DInputCell setPlaceholder:@"Телефон" toTextField:textField];
            [textField setKeyboardType:UIKeyboardTypeNamePhonePad];
            break;
        }
        case qcity:{
            [DInputCell setPlaceholder:@"Город" toTextField:textField];
            [textField setKeyboardType:UIKeyboardTypeDefault];
            break;
        }
        default:
            break;
    }
}

#pragma mark - ClassMethods

+ (void)addSubviewToTextField:(UITextField *)textField{

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input_line.png"]];
    imageView.frame = CGRectMake(0, textField.frame.size.height-3, textField.frame.size.width, 3);
    [textField addSubview:imageView];
}

+ (void)clearSubViewWithTextField:(UITextField *)textField{
    
    for (UIImageView *subView in [textField subviews]) {
        
        if ([subView isKindOfClass:[UIImageView class]]) {
            
            subView.image = nil;
        }
    }
}

+ (void)setPlaceholder:(NSString *)placeholder toTextField:(UITextField *)textField{

    textField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:placeholder
                                    attributes:@{
                                                 NSForegroundColorAttributeName: [UIColor whiteColor],
                                                 NSFontAttributeName : [UIFont fontWithName:textField.font.fontName size:16]
                                                 }
     ];

}

@end

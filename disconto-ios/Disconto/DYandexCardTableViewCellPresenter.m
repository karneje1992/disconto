//
//  DYandexCardTableViewCellPresenter.m
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DYandexCardTableViewCellPresenter.h"

@implementation DYandexCardTableViewCellPresenter

- (instancetype)initWithView:(DYandexCardTableViewCell *)view iterator:(id<DYandexCardTableViewCellIteratorProtocol>)iterator route:(id<DYandexCardTableViewCellRouteProtocol>)route
{
    self = [super init];
    if (self) {
        
        self.view = view;
        self.iterator = iterator;
        self.route = route;
        self.view.presenter = self;
        [self.view.yandexTextFieald setDelegate:self];
    }
    return self;
}

- (void)updateUI{

    [self.view.yandexTextFieald setDelegate:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@""]) {
        return YES;
    }

    [self.iterator setYandexNumberValue:[NSString stringWithFormat:@"%@%@",textField.text,string]];
    
    if (textField.text.length == 2 && ![textField.text isEqualToString:@"41"] && ![string isEqualToString:@""]) {
        return NO;
    }
    
    
    if (textField.text.length == 4 || textField.text.length == 9 || textField.text.length == 14) {
        textField.text = [NSString stringWithFormat:@"%@-",textField.text];
    }
    

    
    return textField.text.length < 19  ;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [self.iterator setYandexNumberValue:textField.text];
}
@end

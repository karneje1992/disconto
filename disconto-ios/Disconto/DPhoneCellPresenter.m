//
//  DPhoneCellPresenter.m
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPhoneCellPresenter.h"

@implementation DPhoneCellPresenter


- (instancetype)initWithView:(DPhoneTableViewCell *)cell route:(id<DPhoneCellRouteProtocolOutput>)route iterator:(id<DPhoneCellIteratorProtocol>)iterator
{
    self = [super init];
    if (self) {
        
        self.view = cell;
        self.route = route;
        self.view.presenter = self;
        self.view.phoneTextField.delegate = self;
        self.iterator = iterator;
    }
    return self;
}

#pragma mark - DPhoneCellPresenterProtocol

- (void)updateUI{
    
    self.view.phoneTextField.delegate = self;
}

- (void)nitificationEnabled{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = [self.route getTableView].frame;
        f.origin.y = -keyboardSize.height*0;
        [self.route getTableView].frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = [self.route getTableView].frame;
        f.origin.y = 0.0f;
        [self.route getTableView].frame = f;
    }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (!textField.text.length) {
        
        [textField setText:@"+7"];
    }
   // [self nitificationEnabled];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ((range.location-range.length) > 100) {
        //[self changeActionButton:NO];
        return YES;
    }
    
    if (textField.text.length == 1 && ![string isEqualToString:@""]) {
        
        [textField setText:[NSString stringWithFormat:@"+7%@",textField.text]];
    }
    
    if ([string isEqualToString:@""] && !textField.text.length) {
        textField.text = @"+7";
    }
    
    if (textField.text.length <= 11 || [string isEqualToString:@""]) {
        [self.iterator setPhoneValue:[NSString stringWithFormat:@"%@%@",textField.text,string]];
    }
    
    //[self changeActionButton:range.location-range.length == 13];
    return textField.text.length <= 11 || [string isEqualToString:@""];
    
}
@end

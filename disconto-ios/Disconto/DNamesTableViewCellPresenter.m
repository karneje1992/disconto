//
//  DNamesTableViewCellPresenter.m
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DNamesTableViewCellPresenter.h"

@implementation DNamesTableViewCellPresenter

- (instancetype)initWithRoute:(id<DNamesTableViewCellRouteProtocol>)route iterator:(id<DNamesTableViewCellIteratorProtocol>)iterator view:(DNamesTableViewCell *)view
{
    self = [super init];
    if (self) {
        
        self.route = route;
        self.iterator = iterator;
        self.view = view;
        [self updateUI];
    }
    return self;
}

- (void)updateUI{

    [self.view.firstNameTextField setDelegate:self];
    [self.view.secondNameTextField setDelegate:self];
    [self.view.lastNameTextField setDelegate:self];

}

- (void)notifications{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField endEditing:YES];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

    //[self notifications];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    if (textField == self.view.firstNameTextField) {
        
        [self.iterator setFirstNameValue:textField.text];
    } else if (textField == self.view.secondNameTextField){
        
        [self.iterator setSecondNameValue:textField.text];
    }else{
        
        [self.iterator setLastNameValue:textField.text];
    }
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = [self.route getTableView].frame;
        f.origin.y = -keyboardSize.height*0.25;
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
@end

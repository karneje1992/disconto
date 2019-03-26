//
//  DSerialTableViewCellPresenter.m
//  Disconto
//
//  Created by Rostislav on 6/30/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DSerialTableViewCellPresenter.h"

@implementation DSerialTableViewCellPresenter

- (instancetype)initWithRoute:(id<DSerialTableViewCellRouteProtocol>)route iterator:(id<DSerialTableViewCellIteratorProtocol>)iterator view:(DSerialTableViewCell *)view
{
    self = [super init];
    if (self) {
        
        self.view = view;
        self.iterator = iterator;
        self.route = route;
        [self updateUI];
    }
    return self;
}

- (void)updateUI{

    [self.view.serialTextField setDelegate:self];

}

- (void)notifications{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = [self.route getTableView].frame;
        f.origin.y = -keyboardSize.height*0.35;
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

   // [self notifications];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [self.iterator setPasportSirialValue:textField.text];
}
@end

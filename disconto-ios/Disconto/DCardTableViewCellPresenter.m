//
//  DCardTableViewCellPresenter.m
//  Disconto
//
//  Created by Rostislav on 6/27/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DCardTableViewCellPresenter.h"

@implementation DCardTableViewCellPresenter

- (instancetype)initWithView:(DCardTableViewCell *)view route:(id<DCardTableViewCellRouteProtocol>)route iterator:(id<DCardTableViewCellIteratorProtocol>)iterator
{
    self = [super init];
    if (self) {
        
        self.view = view;
        self.iterator = iterator;
        self.route = route;
        self.view.presenter = self;
        [self.view.cardTextField setDelegate:self];
        
    }
    return self;
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



#pragma mark - DCardTableViewCellPresenterProtocol

- (void)updateUI{

    [self.view.cardTextField setDelegate:self];
    
}
#pragma maark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if ((range.location-range.length) > 100) {
        return YES;
    }
    
    if (range.length) {
        
        [self.iterator setCardNumberValue:[NSString stringWithFormat:@"%@%@",[textField.text stringByReplacingCharactersInRange:range withString:string],string]];
    } else {
        
        [self.iterator setCardNumberValue:[NSString stringWithFormat:@"%@%@",textField.text,string]];
    }
    
    if (((range.location-range.length == 4 || range.location-range.length == 9 || range.location-range.length == 14) && range.length == 0)) {
        
        [textField setText:[NSString stringWithFormat:@"%@-",textField.text]];
    } else if ((range.location-range.length == 19 && range.length == 0)){
        
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [self.iterator setCardNumberValue:textField.text];
}
@end

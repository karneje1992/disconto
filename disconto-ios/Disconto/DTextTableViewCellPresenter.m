//
//  DTextTableViewCellPresenter.m
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DTextTableViewCellPresenter.h"

@implementation DTextTableViewCellPresenter

- (instancetype)initWithRoute:(id<DTextTableViewCellRouteProtocol>)route iterator:(id<DTextTableViewCellIteratorProtocol>)iterator view:(DTextTableViewCell *)view
{
    self = [super init];
    if (self) {
        
        self.view = view;
        self.view.presenter = self;
        self.route = route;
        self.iterator = iterator;
        [self updateUI];
    }
    return self;
}

- (void)updateUI{

    [self.view.textTextField setDelegate:self];
}

- (void)setPlaceholder:(NSString *)string{

    [self.view.textTextField setPlaceholder:string];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [self.iterator insertTextValue:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField endEditing:textField.text.length];
    return NO;
}
@end

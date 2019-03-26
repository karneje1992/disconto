//
//  DPostCodeTableViewCellPresenter.m
//  Disconto
//
//  Created by Rostislav on 7/6/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DPostCodeTableViewCellPresenter.h"

@implementation DPostCodeTableViewCellPresenter

- (instancetype)initWithRoute:(id<DPostCodeTableViewCellRouteProtocol>)route iterator:(id<DPostCodeTableViewCellIteratorProtocol>)iterator view:(DPostCodeTableViewCell *)view
{
    self = [super init];
    if (self) {
        
        self.view = view;
        self.iterator = iterator;
        self.route = route;
        self.view.prersenter = self;
        [self updateUI];
    }
    return self;
}

- (void)updateUI{

    [self.view.indexTextField setDelegate:self];
}

- (void)setPlaceholder:(NSString *)placeholder{

    [self.view.indexTextField setPlaceholder:placeholder];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [self.iterator setCodeIndexValue:textField.text];
}
@end

//
//  DLocalOfferPresenter.m
//  Disconto
//
//  Created by Rostislav on 10.08.17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DLocalOfferPresenter.h"


@interface DLocalOfferPresenter ()


@end

@implementation DLocalOfferPresenter

- (instancetype)initWith:(DLocalOfferRoute *)route iterator:(DLocalOffeIterator *)iterator view:(DLocalOfferViewController *)view
{
    self = [super init];
    if (self) {
        
        self.iterator = iterator;
        self.route = route;
        self.view = view;
        self.view.presenter = self;
    }
    return self;
}

#pragma mark - DLocalOfferPresenterProtocol

- (void)updateUI{

    [[self.view.sendButton layer] setCornerRadius:8];
    [self.view.sendButton setBackgroundColor:SYSTEM_COLOR];
    [self.view.inputTextField setDelegate:self];
    [self.view.inputTextField setReturnKeyType:UIReturnKeyDone];
}

- (void)sendAction{

}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    return ![textField resignFirstResponder];
}
@end

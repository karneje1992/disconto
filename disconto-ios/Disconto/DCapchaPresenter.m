//
//  DCapchaPresenter.m
//  Disconto
//
//  Created by Rostislav on 7/28/17.
//  Copyright © 2017 Disconto. All rights reserved.
//

#import "DCapchaPresenter.h"


@interface DCapchaPresenter ()



@end

@implementation DCapchaPresenter

- (instancetype)initWithRoute:(id<DCapchaRouteProtocol>)route iterator:(id<DCapchaIteratorProtocol>)iterator view:(DCapchaViewController *)view
{
    self = [super init];
    if (self) {
        
        self.route = route;
        self.iterator = iterator;
        self.view = view;
        [self setDataSourse:self.iterator];
        [self.view setPresenter:self];
    }
    return self;
}

#pragma mark - DCapchaPresenterProtocol

- (void)updateUI{

    [self.view.inputField setDelegate:self];
    self.view.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.view.contentView.layer.cornerRadius = 5;
    self.view.contentView.layer.shadowOpacity = 0.8;
    self.view.contentView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    [self addKeyboardObservers];
}

- (void)reloadAction{

    [self.dataSourse loadCapchaImageWithCallBack:^(NSDictionary *resault) {
        
    }];
}

- (void)sendCapcha{

    [self.dataSourse sendCapcha:self.view.inputField.text];
}

#pragma mark - Keyboard Observers

- (void)addKeyboardObservers{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    CGFloat heightFromBottomToViewWithTextFields = CGRectGetMaxY(self.view.contentView.bounds) - CGRectGetMaxY(self.view.contentView.frame);
    CGFloat keyboardHeight = CGRectGetHeight(keyboardFrameBeginRect);
    
    CGRect frame = self.view.view.frame;
    CGFloat toAddValue = (heightFromBottomToViewWithTextFields > keyboardHeight) ? 0 : heightFromBottomToViewWithTextFields*0.6;
    
    frame.origin.y = +toAddValue;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.view.frame = frame;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    CGRect frame = self.view.view.frame;
    frame.origin.y = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.view.frame = frame;
    }];
}
@end

//
//  QRSenderFooterView.m
//  Disconto
//
//  Created by Rostislav on 8/20/18.
//  Copyright © 2018 Disconto. All rights reserved.
//

#import "QRSenderFooterView.h"



@implementation QRSenderFooterView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder: aDecoder];
    
    if (self){
        
        [self customInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame: frame];
    
    if (self) {
        
        [self customInit];
    }
    
    return self;
}
- (IBAction)senderAction:(id)sender {
    
    [self.delegate senderAction];
}

- (void)customInit{
    
    
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([QRSenderFooterView class]) owner:self options:nil];
    [self addSubview: self.contentView];
    self.contentView.frame = self.bounds;
    self.senderButton.layer.cornerRadius = 8;
    self.senderButton.clipsToBounds = YES;
}

@end

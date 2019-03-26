//
//  QRSenderFooterView.h
//  Disconto
//
//  Created by Rostislav on 8/20/18.
//  Copyright © 2018 Disconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QRSenderFooterViewDelegate <NSObject>

- (void)senderAction;
@end

@interface QRSenderFooterView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *senderButton;
@property id<QRSenderFooterViewDelegate> delegate;
@end

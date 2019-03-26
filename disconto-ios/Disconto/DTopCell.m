//
//  DTopCell.m
//  Disconto
//
//  Created by user on 15.03.16.
//  Copyright © 2016 StudioVision. All rights reserved.
//

#import "DTopCell.h"

@implementation DTopCell

- (void)awakeFromNib {
    
    [[NetworkManeger sharedManager] sendGetRequestToServerWithDictionary:@{} andAPICall:kGetSupportTitle withCallBack:^(BOOL success, NSDictionary *resault) {
       
        self.themLabel.text = resault[@"subject"];
    }];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end

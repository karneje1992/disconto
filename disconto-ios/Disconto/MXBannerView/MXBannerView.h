//
//  MXBannerView.h
//  MXBannerView
//
//  Created by Meniny on 16/9/7.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MXImage.h"

typedef enum : NSUInteger {
    MXBannerPageControlAlimentCenterBottom = 0,
    MXBannerPageControlAlimentLeftBottom,
    MXBannerPageControlAlimentRightBottom,
} MXBannerPageControlAliment;

@class MXBannerView;

@protocol MXBannerViewDelegate <NSObject>
@optional
- (void)bannerView:(MXBannerView * _Nonnull)bannerView didSelectItemAtIndex:(NSUInteger)index;
@end

@interface MXBannerView : UIView
@property (nonatomic, assign) UIViewContentMode imageContentMode;
@property (nonatomic, assign) BOOL showPageControl;
@property (nonatomic, assign, getter=isAutoScrollEnabled) BOOL autoScrollEnabled;
@property (nonatomic, assign) NSTimeInterval autoScrollTimeInterval;
@property (nonatomic, assign, getter=isInfiniteScrollEnabled) BOOL infiniteScrollEnabled;
@property (nonatomic, assign) MXBannerPageControlAliment pageControlAliment;

@property (nonatomic, strong) UIColor * _Nonnull selectedDotColor;
@property (nonatomic, strong) UIColor * _Nonnull dotColor;
@property (nonatomic, strong) UIImage * _Nullable placeholderImage;

@property (nonatomic, strong) UIFont * _Nonnull detailLableFont;
@property (nonatomic, strong) UIColor * _Nonnull detailLableTextColor;
@property (nonatomic, strong) UIColor * _Nonnull detailLableBackgroundColor;

@property (nonatomic, strong) NSMutableArray <NSString *>* _Nonnull localImageArray;
@property (nonatomic, strong) NSMutableArray <NSString *>* _Nonnull imageURLArray;
@property (nonatomic, strong) NSMutableArray <NSString *>* _Nonnull imageDetailArray;

@property (nonatomic, weak) id <MXBannerViewDelegate> _Nullable delegate;

#pragma mark -

- (instancetype _Nullable)initWithFrame:(CGRect)frame
                                   type:(MXImageType)type
                                 images:(NSArray <NSString *>* _Nullable)images;

@end

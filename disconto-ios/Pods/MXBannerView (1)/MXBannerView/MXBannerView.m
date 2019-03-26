//
//  MXBannerView.swift
//  MXBannerView
//
//  Created by Meniny on 15/11/7.
//  Copyright © 2015年 Meniny. All rights reserved.
//

// http://www.meniny.cn

#import "MXBannerView.h"
#import "MXImageBox.h"
#import "MXBannerCollectionCell.h"
#import <SDWebImage/UIImage+GIF.h>
#import <SDWebImage/UIImageView+WebCache.h>

NSTimeInterval const kMXMinTimeInterval = 1.0f;
NSUInteger const kMXImageTimes = 150;
NSString * const kMXCellID = @"MXBannerCollectionCell";

@interface MXBannerView () <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate> {
    __strong NSMutableArray <NSString *>* _Nullable _localImageArray;
    __strong NSMutableArray <NSString *>* _Nullable _imageURLArray;
    __strong NSMutableArray <NSString *>* _Nullable _imageDetailArray;
    __strong UIColor * _Nonnull _selectedDotColor;
    __strong UIColor * _Nonnull _dotColor;
    NSTimeInterval _autoScrollTimeInterval;
}
@property (nonatomic, strong) NSTimer * _Nullable timer;
@property (nonatomic, strong) MXImageBox * _Nullable imageBox;
@property (nonatomic, assign) NSUInteger actualItemCount;
@property (nonatomic, strong) UIPageControl * _Nullable pageControl;
@property (nonatomic, strong) UICollectionView * _Nullable collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout * _Nullable flowLayout;

@end

@implementation MXBannerView

#pragma mark - 属性接口
#pragma mark -
#pragma mark 数据源
#pragma mark -

/**
 * 存放本地图片名称的数组
 */
- (void)setLocalImageArray:(NSMutableArray<NSString *> *)localImageArray {
    if (localImageArray) {
        _localImageArray = [localImageArray copy];
    } else {
        _localImageArray = nil;
    }
    
    [self setImageBox:[[MXImageBox alloc] initWithImageType:MXImageTypeLocal source:_localImageArray]];
    [self reloadData];
}

/**
 * 存放本地图片名称的数组
 */
- (NSMutableArray<NSString *> *)localImageArray {
    if (_localImageArray == nil) {
        _localImageArray = [NSMutableArray array];
    }
    return _localImageArray;
}

/**
 * 存放网络图片路径的数组
 */
- (NSMutableArray<NSString *> *)imageURLArray {
    if (_imageURLArray == nil) {
        _imageURLArray = [NSMutableArray array];
    }
    return _imageURLArray;
}

/**
 * 存放本地图片名称的数组
 */
- (void)setImageURLArray:(NSMutableArray<NSString *> *)imageURLArray {
    if (imageURLArray) {
        _imageURLArray = [imageURLArray copy];
    } else {
        _imageURLArray = nil;
    }
    [self setImageBox:[[MXImageBox alloc] initWithImageType:MXImageTypeNetwork source:_imageURLArray]];
    [self reloadData];
}

/**
 * 图片的描述文字
 */
- (NSMutableArray<NSString *> *)imageDetailArray {
    if (_imageDetailArray == nil) {
        _imageDetailArray = [NSMutableArray array];
    }
    return _imageDetailArray;
}
    
#pragma mark -
#pragma mark  自定义样式接口
#pragma mark -
- (void)setShowPageControl:(BOOL)showPageControl {
    _showPageControl = showPageControl;
    if ([self pageControl]) {
        [[self pageControl] setHidden:!_showPageControl];
    }
}

- (void)setSelectedDotColor:(UIColor *)selectedDotColor {
    _selectedDotColor = selectedDotColor;
    if ([self pageControl]) {
        [[self pageControl] setCurrentPageIndicatorTintColor:[self selectedDotColor]];
    }
}

- (UIColor *)selectedDotColor {
    if (_selectedDotColor == nil) {
        _selectedDotColor = [UIColor colorWithRed:0.13 green:0.52 blue:0.95 alpha:1.00];
    }
    return _selectedDotColor;
}

- (void)setDotColor:(UIColor *)dotColor {
    _dotColor = dotColor;
    if ([self pageControl]) {
        [[self pageControl] setPageIndicatorTintColor:[self dotColor]];
    }
}

- (UIColor *)dotColor {
    if (_dotColor == nil) {
        _dotColor = [UIColor whiteColor];
    }
    return _dotColor;
}

- (UIFont *)detailLableFont {
    if (_detailLableFont == nil) {
        _detailLableFont = [UIFont systemFontOfSize:14];
    }
    return _detailLableFont;
}

- (UIColor *)detailLableTextColor {
    if (_detailLableTextColor == nil) {
        _detailLableTextColor = [UIColor whiteColor];
    }
    return _detailLableTextColor;
}

- (UIColor *)detailLableBackgroundColor {
    if (_detailLableBackgroundColor == nil) {
        _detailLableBackgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _detailLableBackgroundColor;
}
    
#pragma mark -
#pragma mark 滚动控制接口
#pragma mark -

- (void)setAutoScrollEnabled:(BOOL)autoScrollEnabled {
    _autoScrollEnabled = autoScrollEnabled;
    [self invalidateTimer];
    if (_autoScrollEnabled) {
        [self setupTimer:nil];
    }
}

- (NSTimeInterval)autoScrollTimeInterval {
    if (_autoScrollEnabled < kMXMinTimeInterval) {
        _autoScrollEnabled = kMXMinTimeInterval;
    }
    return _autoScrollEnabled;
}

- (void)setInfiniteScrollEnabled:(BOOL)infiniteScrollEnabled {
    _infiniteScrollEnabled = infiniteScrollEnabled;
    [self reloadData];
}

#pragma mark - 初始化方法

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame type:(MXImageType)type images:(NSArray <NSString *>*)images {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        if (images) {
            if (type == MXImageTypeLocal) {
                [self setLocalImageArray:[images mutableCopy]];
            } else {
                [self setImageURLArray:[images mutableCopy]];
            }
        }
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    [self setShowPageControl:YES];
    [self setImageContentMode:UIViewContentModeScaleAspectFill];
    [self setupCollectionView];
}

- (void)setupCollectionView {
    [self setFlowLayout:[UICollectionViewFlowLayout new]];
    [[self flowLayout] setMinimumLineSpacing:0.0f];
    [[self flowLayout] setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    if ([self collectionView]) {
        [[self collectionView] removeFromSuperview];
    }
    
    [self setCollectionView:[[UICollectionView alloc] initWithFrame:[self bounds] collectionViewLayout:[self flowLayout]]];
    [[self collectionView] setBackgroundColor:[UIColor whiteColor]];
    [[self collectionView] setShowsVerticalScrollIndicator:NO];
    [[self collectionView] setShowsHorizontalScrollIndicator:NO];
    [[self collectionView] setBounces:NO];
    [[self collectionView] setPagingEnabled:YES];
    [[self collectionView] setDataSource:self];
    [[self collectionView] setDelegate:self];
//    [[self collectionView] registerClass:[MXBannerCollectionCell class] forCellWithReuseIdentifier:kMXCellID];
    [[self collectionView] registerNib:[UINib nibWithNibName:kMXCellID bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kMXCellID];
    [self addSubview:[self collectionView]];
}

- (void)setupPageControl {
    if ([self pageControl]) {
        [[self pageControl] removeFromSuperview];
    }
    if ([self imageBox] == nil ||
        ![[[self imageBox] imageArray] count]) {
        return;
    }
    if ([self showPageControl]) {
        [self setPageControl:[UIPageControl new]];
        [[self pageControl] setNumberOfPages:[[[self imageBox] imageArray] count]];
        [[self pageControl] setPageIndicatorTintColor:[self dotColor]];
        [[self pageControl] setCurrentPageIndicatorTintColor:[self selectedDotColor]];
        [[self pageControl] setUserInteractionEnabled:NO];
        [self addSubview:[self pageControl]];
    }
}

#pragma mark - 内部方法
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview == nil) {
        if ([self timer] &&
            [[self timer] isValid]) {
            [[self timer] invalidate];
        }
        [self setTimer:nil];
    }
}

- (void)reloadData {
    if ([self imageBox] != nil) {
        if ([[[self imageBox] imageArray] count] > 1) {
            if ([self isInfiniteScrollEnabled]) {
                [self setActualItemCount:[[[self imageBox] imageArray] count] * kMXImageTimes];
            } else {
                [self setActualItemCount:[[[self imageBox] imageArray] count]];
            }
        } else {
            [self setActualItemCount:1];
        }
    }
    
    if ([self collectionView]) {
        [[self collectionView] reloadData];
    }
    [self setupPageControl];
    
    if ([self isAutoScrollEnabled]) {
        [self setupTimer:nil];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([self flowLayout]) {
        [[self flowLayout] setItemSize:[self bounds].size];
    }
    if ([self collectionView]) {
        [[self collectionView] setFrame:[self bounds]];
    }
    
    [self showFirstImagePageInCollectionView:[self collectionView] animated:NO];
    
    if ([self pageControl]) {
        [self adjustPageControlPlace:[self pageControl]];
    }
}

- (void)adjustPageControlPlace:(UIPageControl *)pageControl {
    if (pageControl == nil) {
        return;
    }
    if (![pageControl isHidden]) {
        CGFloat pageW = [pageControl numberOfPages] * 15.0f;
        CGFloat pageH = 20.0f;
        CGFloat pageX;
        CGFloat pageY = [self bounds].size.height - pageH;
        switch ([self pageControlAliment]) {
        case MXBannerPageControlAlimentCenterBottom: {
            pageX = [self center].x - 0.5f * pageW;
        }
            break;
        case MXBannerPageControlAlimentLeftBottom: {
            pageX = [self bounds].origin.x;
        }
            break;
        case MXBannerPageControlAlimentRightBottom: {
            pageX = [self bounds].size.width - pageW;
        }
            break;
        default: {
            pageX = 0.0f;
        }
            break;
        }
        [pageControl setFrame:CGRectMake(pageX, pageY, pageW, pageH)];
    }
}

- (void)setupTimer:(id)userInfo {
    [self invalidateTimer];
    [self setTimer:[NSTimer timerWithTimeInterval:[self autoScrollTimeInterval] target:self selector:@selector(changeImage) userInfo:userInfo repeats:YES]];
    
    [[NSRunLoop mainRunLoop] addTimer:[self timer] forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer {
    if ([self timer] &&
        [[self timer] isValid]) {
        [[self timer] invalidate];
    }
}

- (void)changeImage {
    [self autoChangeImage:[self collectionView]];
}

- (void)autoChangeImage:(UICollectionView *)collectionView {

    if ([self actualItemCount]) {
        NSUInteger currentIndex = [[self collectionView] contentOffset].x / [[self flowLayout] itemSize].width;
        
        NSUInteger nextIndex = currentIndex + 1;
        if (nextIndex >= [self actualItemCount]) {
            [self showFirstImagePageInCollectionView:[self collectionView] animated:YES];
        } else {
            [[self collectionView] scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
    }
}

- (void)showFirstImagePageInCollectionView:(UICollectionView *)collectionView animated:(BOOL)animated {
    if ([self actualItemCount]) {
        NSUInteger newIndex = 0;
        if ([self isInfiniteScrollEnabled]) {
            newIndex = [self actualItemCount] / 2;
        }
        [[self collectionView] scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:newIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:animated];
    }
}

#pragma mark - scrollView 代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self isAutoScrollEnabled]) {
        [self invalidateTimer];
        [self setTimer:nil];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self isAutoScrollEnabled]) {
        [self setupTimer:nil];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self pageControl]) {
//        NSUInteger index = [indexPath item] % [[[self imageBox] imageArray] count];
        NSUInteger offsetIndex = [[self collectionView] contentOffset].x / [[self flowLayout] itemSize].width;
        NSUInteger currentIndex = offsetIndex % [[[self imageBox] imageArray] count];
        if (currentIndex >= [[[self imageBox] imageArray] count]) {
            [[self pageControl] setCurrentPage:0];
        } else {
            [[self pageControl] setCurrentPage:currentIndex];
        }
    }
}

#pragma mark - collectionView 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self actualItemCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MXBannerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMXCellID forIndexPath:indexPath];
    if ([self imageBox]) {
        NSUInteger actualItemIndex = 0;
        if ([self isInfiniteScrollEnabled]) {
            actualItemIndex = [indexPath item] % ([self actualItemCount] / kMXImageTimes);
        } else {
            actualItemIndex = [indexPath item];
        }
        MXImage *image = [[[self imageBox] imageArray] objectAtIndex:actualItemIndex];
        if ([[self imageBox] imageType] == MXImageTypeNetwork) {
            [[cell imageView] sd_setImageWithURL:[NSURL URLWithString:[image imageURL]] placeholderImage:[self placeholderImage]];
        } else {
            [[cell imageView] setImage:[UIImage imageNamed:[image imageName]]];
        }
    } else {
        [[cell imageView] setImage:[self placeholderImage]];
    }
    if ([indexPath item] >= [[self imageDetailArray] count]) {
        [[cell labelContentView] setHidden:YES];
    } else {
        [[cell labelContentView] setHidden:NO];
        [[cell detailLabel] setText:[[self imageDetailArray] objectAtIndex:[indexPath item]]];
        [[cell imageView] setContentMode:[self imageContentMode]];
        [[cell detailLabel] setTextColor:[self detailLableTextColor]];
        [[cell labelContentView] setBackgroundColor:[self detailLableBackgroundColor]];
        [[cell detailLabel] setFont:[self detailLableFont]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self delegate] &&
        [[self delegate] respondsToSelector:@selector(bannerView:didSelectItemAtIndex:)]) {
        
        NSUInteger index = [indexPath item] % [[[self imageBox] imageArray] count];
        [[self delegate] bannerView:self didSelectItemAtIndex:index];
    }
}

@end
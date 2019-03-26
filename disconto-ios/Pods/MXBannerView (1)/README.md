![img](https://camo.githubusercontent.com/c142c2497149a914ee06baed87bd5f319613e3cc/687474703a2f2f696d672e736869656c64732e696f2f636f636f61706f64732f702f4b444379636c6542616e6e6572566965772e737667)  ![img](https://camo.githubusercontent.com/45931151c6d3dfd9d8b4a25d46f6d7912f2b359d/687474703a2f2f696d672e736869656c64732e696f2f636f636f61706f64732f6c2f4b444379636c6542616e6e6572566965772e737667)

# MXBannerView-in-Objective-C

`MXBannerView` is a banner view for iOS.

## Installation with CocoaPods

```
pod 'MXBannerView'
```

## Usage

* You may need to disable the ATS.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
</dict>
</plist>

```

```objective-c
#import "MXBannerView.h"
```

```objective-c
@interface ViewController () <MXBannerViewDelegate>
@end
```

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSArray <NSString *>* source = @[
                                     @"http://img02.imgcdc.com/grab/img/20160907/86291473212635.jpeg",
                                     @"http://img02.imgcdc.com/grab/img/20160907/71941473212635.jpeg",
                                     @"http://i5.073img.com/160907/5808312_114823_3_lit.gif",
                                     @"http://i5.073img.com/160907/5808312_114951_1_lit.jpg",
                                     @"http://7xlvky.com1.z0.glb.clouddn.com/20160903164033644-882947694.jpg",
//                                     @"Zootopia-1",
//                                     @"Zootopia-2",
//                                     @"Zootopia-3",
//                                     @"Zootopia-4",
                                     ];

//    MXBannerView *banner = [[MXBannerView alloc] initWithFrame:CGRectZero type:MXImageTypeNetwork images:source];
    MXBannerView *banner = [[MXBannerView alloc] init];
    [banner setShowPageControl:YES];
    [banner setInfiniteScrollEnabled:YES];
    [banner setImageURLArray:[source copy]];
//    [banner setAutoScrollEnabled:YES];
//    [banner setLocalImageArray:[source mutableCopy]];
    [banner setDelegate:self];

		[[self view] addSubview:banner];
    // AutoLayout, Frame, etc.
}

- (void)bannerView:(MXBannerView *)bannerView didSelectItemAtIndex:(NSUInteger)index {
    NSLog(@"%zd", index);
}
```

//
//  DShowWebSiteController.m
//  Disconto
//
//  Created by Ross on 22.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DShowWebSiteController.h"

@interface DShowWebSiteController ()

@property NSURL *siteURL;
@property NSData *data;
@end

@implementation DShowWebSiteController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = back;
    
    if (self.siteURL) {
    
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.siteURL];
      //  [request setHTTPMethod:@"GET"];
        [request setValue:[NSString stringWithFormat:@"ios/%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"App-Version"];
        [request setValue:@"disconto" forHTTPHeaderField:@"App"];
        [self.webView loadRequest:request];
    }else{
    
        [self.webView loadData:self.data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andURL:(NSURL *)url
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.siteURL = url;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andData:(NSData *)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.data = data;
    }
    return self;
}

+ (instancetype)showWebViewWithData:(NSData *)data{

    return [[DShowWebSiteController alloc] initWithNibName:NSStringFromClass([DShowWebSiteController class]) bundle:nil andData:data];
}

+ (instancetype)showWebViewWithURL:(NSURL *)url{
    
    return [[DShowWebSiteController alloc] initWithNibName:NSStringFromClass([DShowWebSiteController class]) bundle:nil andURL:url];
}

- (void)back{

    [self.delegate exitWebView:self];
}
#pragma mark - UIWebView

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
 //   SHOW_PROGRESS;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if ([webView.request.URL.absoluteString rangeOfString:@"yandex/exit"].location != NSNotFound){
        
        [self.navigationController popViewControllerAnimated:YES];
        [[[UIAlertView alloc] initWithTitle:@"Сообщение" message:@"Вы хотите оценить приложение ?" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil] show];
        
    }
    
    if ([[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"interactive"] || [[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"complete"]) {
        
        [self.delegate startLoad];
        
        HIDE_PROGRESS;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://itunes.apple.com/ru/app/diskonto/id1003256356?mt=8"]]];
    }else{
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewWillLayoutSubviews {
    //SOME CODE
}

@end

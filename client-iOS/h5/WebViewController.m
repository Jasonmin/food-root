//
//  WebViewController.m
//  TJIMRC
//
//  Created by zhou on 2019/1/10.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "TJURLRequest.h"
#import "Masonry.h"

@interface WebViewController ()
<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) UIProgressView * progressView;
@end

NSString *const UDKey_CACHE_H5Script = @"UDKey_CACHE_H5Script";

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.baseUrl = @"https://cn.bing.com/";
    
    [self setupViews];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    TJURLRequest *request = [TJURLRequest requestWithURL:fileURL];
    [self.wkWebView loadRequest:request];
    
    [self setupTwoNavItems];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)setupViews {
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.wkWebView addSubview:self.progressView];
    //添加监测网页加载进度的观察者
    [self.wkWebView addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                      options:0
                      context:nil];
    [self.wkWebView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
}

- (void)back {
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}

//kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == _wkWebView) {
        
        NSLog(@"网页加载进度 = %f",_wkWebView.estimatedProgress);
        self.progressView.progress = _wkWebView.estimatedProgress;
        if (_wkWebView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
        
    }else if([keyPath isEqualToString:@"title"]
             && object == _wkWebView){
//        self.navigationItem.title = _wkWebView.title;
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}

#pragma mark -- WKNavigationDelegate
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}

#pragma mark - alert
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - 写稿传递
- (void)saveH5ScriptData:(NSString*)scriptData {
    [[NSUserDefaults standardUserDefaults] setObject:scriptData forKey:UDKey_CACHE_H5Script];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)deleteH5ScriptData {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UDKey_CACHE_H5Script];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)transferParam {
    NSString* paramStr = [[NSUserDefaults standardUserDefaults] objectForKey:UDKey_CACHE_H5Script];
    NSString *jsStr =  [NSString stringWithFormat:@"iOSTransfer('%@')",paramStr];
    [self.wkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"result=%@  error=%@",result, error);
    }];
}

#pragma mark - Lazy

- (WKWebView*)wkWebView {
    if (!_wkWebView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        // 实例化对象
        configuration.userContentController = [WKUserContentController new];
        // 调用JS方法
//        [configuration.userContentController addScriptMessageHandler:self name:@"startVoiceChat"];
        
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        _wkWebView.allowsBackForwardNavigationGestures = YES;
    }
    return _wkWebView;
}

- (UIProgressView *)progressView {
    if (!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, 2)];
        _progressView.tintColor = [UIColor greenColor];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

@end

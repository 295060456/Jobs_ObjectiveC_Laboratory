//
//  Notes.h
//  OC_JS
//
//  Created by Jobs on 24/10/2021.
//

#ifndef Notes_h
#define Notes_h


#endif /* Notes_h */

/*
 
 JS和OC进行交互，就是JS代码可以调用OC原生代码，以Runtime的形式进行注入（因为H5页面是随机的），所以存在一定的安全隐患
 这也是Apple Inc. 封锁JSPatch的原因之一
 
【步骤】
 
 // 协议 用WK可以上架
 <WKUIDelegate,WKScriptMessageHandler>
 
 // 属性化
 @property(strong,nonatomic)WKWebView *webView;
 
 // 注册需要监听的本地方法  @"ScanAction"
 [self.webView.configuration.userContentController addScriptMessageHandler:self
                                                                      name:@"ScanAction"];
 
 // 目标页面用完以后记得释放
 [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"ScanAction"];
 
 
 // H5页面里面需要这么写表示唤起OC 【JS->OC】
 function scanClick() {
     window.webkit.messageHandlers.ScanAction.postMessage(null);
 }
 
 // 点击H5的方法跳转进入OC的如下方法 【JS->OC】
 - (void)userContentController:(WKUserContentController *)userContentController
       didReceiveScriptMessage:(WKScriptMessage *)message;
 
 // OC本地把值传递给JS 【OC->JS】
 NSString *jsStr = [NSString stringWithFormat:@"setLocation('%@')",@"广东省深圳市南山区学府路XXXX号"];
 [self.webView evaluateJavaScript:jsStr
                completionHandler:^(id _Nullable result,
                                    NSError * _Nullable error) {
     NSLog(@"%@----%@",result, error);
 }];
 
 // OC本地处理JS响应
 - (void)webView:(WKWebView *)webView
 runJavaScriptAlertPanelWithMessage:(NSString *)message
 initiatedByFrame:(WKFrameInfo *)frame
 completionHandler:(void (^)(void))completionHandler;
 
 //OC调用js端方法
 webView.evaluateJavaScript("hi()", completionHandler: nil) //直接调用js
 webView.evaluateJavaScript("hello('liuyanwei')", completionHandler: nil) //调用js带参数
 webView.evaluateJavaScript("getName()") { (any,error) -> Void in
    NSLog("%@", any as! String)
 }//调用js获取返回值
 
 
 
 
 
 // 相关初始化
 {
     WKWebViewConfiguration *configuration = WKWebViewConfiguration.new;
     
     WKPreferences *preferences = [WKPreferences new];
     preferences.javaScriptCanOpenWindowsAutomatically = YES;
     preferences.minimumFontSize = 40.0;
     configuration.preferences = preferences;
     
     self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
     
     
 //    NSString *urlStr = @"http://www.baidu.com";
 //    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
 //    [self.webView loadRequest:request];
     
     NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
     NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
     [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
     
     self.webView.UIDelegate = self;
     [self.view addSubview:self.webView];
 }
 
 **/

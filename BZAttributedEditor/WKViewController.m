//
//  WKViewController.m
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/19.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import "WKViewController.h"
#import <WebKit/WebKit.h>
@interface WKViewController ()
@property (nonatomic, strong) WKWebView *webview;
@end

@implementation WKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    printf("%s", [self.html cStringUsingEncoding:NSUTF8StringEncoding]);
    self.webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [self.view addSubview:self.webview];
    [self.webview loadHTMLString:self.html baseURL:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

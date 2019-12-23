//
//  UITextView+AddLink.m
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/23.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import "UITextView+AddLink.h"

@implementation UITextView (AddLink)

- (void)addLink {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"插入链接" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入链接";
    }];
    
    __block typeof(self) weakSelf = self;
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UITextField *field = [alert textFields].firstObject;
        if (field.text.length) {
            [weakSelf addLinkWithURL:field.text placeText:nil];
        }
    }];
    [alert addAction:done];

    UIWindow *window = nil;
    for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
        if (windowScene.activationState == UISceneActivationStateForegroundActive) {
            window = windowScene.windows.firstObject;
            break;
        }
    }
    [window.rootViewController presentViewController:alert animated:YES completion:nil];
}
- (void)addLinkWithURL:(NSString *)url placeText:(NSString *)text {

    if (text.length == 0) {
        text = @"链接地址";
    }
    
    NSDictionary *originType = [self.typingAttributes copy];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attrStr addAttribute:NSLinkAttributeName value:[NSURL URLWithString:url] range:NSMakeRange(0, text.length)];

    NSMutableAttributedString *att = [self.attributedText mutableCopy];
    [att appendAttributedString:attrStr];
    self.attributedText = att;
    self.typingAttributes = originType;
}
@end

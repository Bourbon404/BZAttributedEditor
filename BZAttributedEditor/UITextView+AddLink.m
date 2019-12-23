//
//  UITextView+AddLink.m
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/23.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import "UITextView+AddLink.h"

@implementation UITextView (AddLink)

- (void)addLinkWithURL:(NSString *)url placeText:(nonnull NSString *)text {

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

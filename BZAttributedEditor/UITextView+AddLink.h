//
//  UITextView+AddLink.h
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/23.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (AddLink)

- (void)addLinkWithURL:(NSString *)url placeText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END

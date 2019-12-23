//
//  BZEditorManager.h
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/19.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZEditorEditType.h"
NS_ASSUME_NONNULL_BEGIN

@interface BZEditorManager : NSObject

/**
 *  富文本转html字符串
 */
+ (NSString *)attriToStrWithAttri:(NSAttributedString *)attri;

/**
 *  字符串转富文本
 */
+ (NSAttributedString *)strToAttriWithStr:(NSString *)htmlStr;


- (NSDictionary *)currentAttributeWithType:(BZEditorEditType *)currentType;
@end

NS_ASSUME_NONNULL_END

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


/// 返回特定的输入样式
/// @param currentType 当前的输入样式
- (NSDictionary *)currentAttributeWithType:(BZEditorEditType *)currentType;
@end

NS_ASSUME_NONNULL_END

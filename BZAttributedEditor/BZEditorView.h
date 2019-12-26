//
//  BZEditorView.h
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/19.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZEditorManager.h"
#import "BZEditorToolView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BZEditorView : UIView
@property (nonatomic, strong, readonly) UITextView *editor;
@property (nonatomic, strong, readonly) BZEditorToolView *tool;

@property (nonatomic, strong, readonly) BZEditorEditType *currentType;

/// 配置默认的输入样式
/// @param type type description
- (void)configDefaultStyle:(nullable NSDictionary *)type;
@end

NS_ASSUME_NONNULL_END

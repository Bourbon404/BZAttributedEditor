//
//  BZEditorToolView.h
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/19.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZEditorEditType.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^DidSelectToolWitType)(BZEditorType type);
@interface BZEditorToolView : UIView
@property (nonatomic, copy) DidSelectToolWitType selectAction;
@end

NS_ASSUME_NONNULL_END

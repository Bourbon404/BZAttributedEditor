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

typedef void(^DidSelectToolWithType)(BZEditorType type);
typedef void(^DidSelectToolWithAction)(BZEditorType type);
typedef void(^DidSelectToolWithClose) (void);

@protocol BZEditorToolViewDelegate <NSObject>

@optional
- (BOOL)toolViewCanSelectCurrentType:(BZEditorType)editType;

@end

@interface BZEditorToolView : UIView
@property (nonatomic, copy) DidSelectToolWithType selectBlock;
@property (nonatomic, copy) DidSelectToolWithAction actionBlock;
@property (nonatomic, copy) DidSelectToolWithClose closeBlock;

@property (nonatomic, weak) id <BZEditorToolViewDelegate>delegate;
@property (nonatomic, strong, readonly) NSMutableArray <UICollectionView *>*allToolArray;

@end

NS_ASSUME_NONNULL_END

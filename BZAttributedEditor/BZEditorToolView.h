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
typedef void(^DidSelectToolWitAction)(BZEditorType type);

@protocol BZEditorToolViewDelegate <NSObject>

@optional
- (BOOL)toolViewCanSelectCurrentType:(BZEditorType)editType;

@end

@interface BZEditorToolView : UIView
@property (nonatomic, copy) DidSelectToolWitType selectBlock;
@property (nonatomic, copy) DidSelectToolWitAction actionBlock;
@property (nonatomic, weak) id <BZEditorToolViewDelegate>delegate;
@property (nonatomic, strong, readonly) NSMutableArray <UICollectionView *>*allToolArray;

@end

NS_ASSUME_NONNULL_END

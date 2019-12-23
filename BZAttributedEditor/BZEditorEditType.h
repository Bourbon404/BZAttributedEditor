//
//  BZEditorType.h
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/23.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, BZEditorType) {
  
    BZEditorTypeNormal = 0,
    BZEditorTypeB,
    BZEditorTypeI,
    BZEditorTypeU,
    BZEditorTypeStrikethrough,

    BZEditorTypeFont0 = 16,
    BZEditorTypeFont1 = 18,
    BZEditorTypeFont2 = 20,
    
    BZEditorTypeBlack = 30,
    BZEditorTypeRed,
    BZEditorTypeOrange,
    BZEditorTypeYellow,
    BZEditorTypeGreen,
    BZEditorTypeCyanColor,
    BZEditorTypeBlue,
    BZEditorTypePurple,
    
    BZEditorTypeAddImage = 40,
    BZEditorTypeAddLink,
    
};

NS_ASSUME_NONNULL_BEGIN

@interface BZEditorEditType : NSObject

@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, strong) UIColor *fontColor;
@property (nonatomic, assign) BOOL useItalics;
@property (nonatomic, assign) BOOL useBold;
@property (nonatomic, assign) BOOL useUnderline;
@property (nonatomic, assign) BOOL useStrikethrough;

+ (BZEditorEditType *)defaultType;
@end

NS_ASSUME_NONNULL_END

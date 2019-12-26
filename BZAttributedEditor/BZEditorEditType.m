//
//  BZEditorType.m
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/23.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import "BZEditorEditType.h"

@implementation BZEditorEditType

+ (BZEditorEditType *)defaultType {
    BZEditorEditType *type = [[BZEditorEditType alloc] init];
    type.fontSize = BZEditorTypeFont0;
    type.fontColor = [UIColor blackColor];
    type.paragraphStyle = BZEditorTypeParagraphLeft;
    return type;
}
@end

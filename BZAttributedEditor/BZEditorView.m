//
//  BZEditorView.m
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/19.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import "BZEditorView.h"
#import "BZEditorToolView.h"
@interface BZEditorView ()
@property (nonatomic, strong) BZEditorManager *manager;
@property (nonatomic, strong, readwrite) UITextView *editor;
@property (nonatomic, strong, readwrite) BZEditorEditType *currentType;

@end
@implementation BZEditorView

- (instancetype)init {
    if (self = [super init]) {
        self.manager = [[BZEditorManager alloc] init];
        self.editor = [[UITextView alloc] init];
        self.editor.returnKeyType = UIReturnKeyDone;
        [self configDefaultStyle:nil];
        ///配置默认的输入状态
        BZEditorToolView *tool = [[BZEditorToolView alloc] init];
        tool.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 110);

        __block typeof(self) weakSelf = self;
        tool.selectAction = ^(BZEditorType type) {
          
            if (type == BZEditorTypeB) {
                weakSelf.currentType.useBold = !weakSelf.currentType.useBold;
            }
            if (type == BZEditorTypeI) {
                weakSelf.currentType.useItalics = !weakSelf.currentType.useItalics;
            }
            if (type == BZEditorTypeU) {
                weakSelf.currentType.useUnderline = !weakSelf.currentType.useUnderline;
            }
            
            if (type == BZEditorTypeFont0 || type == BZEditorTypeFont1 || type == BZEditorTypeFont2) {
                weakSelf.currentType.fontSize = type;
            }
            
            if (type == BZEditorTypeBlack) {
                weakSelf.currentType.fontColor = [UIColor blackColor];
            } else if (type == BZEditorTypeRed) {
                weakSelf.currentType.fontColor = [UIColor systemRedColor];
            } else if (type == BZEditorTypeOrange) {
                weakSelf.currentType.fontColor = [UIColor systemOrangeColor];
            } else if (type == BZEditorTypeYellow) {
                weakSelf.currentType.fontColor = [UIColor systemYellowColor];
            } else if (type == BZEditorTypeGreen) {
                weakSelf.currentType.fontColor = [UIColor systemGreenColor];
            } else if (type == BZEditorTypeCyanColor) {
                weakSelf.currentType.fontColor = [UIColor cyanColor];
            } else if (type == BZEditorTypeBlue) {
                weakSelf.currentType.fontColor = [UIColor systemBlueColor];
            } else if (type == BZEditorTypePurple) {
                weakSelf.currentType.fontColor = [UIColor systemPurpleColor];
            }
            
            if (type == BZEditorTypeNormal) {
                weakSelf.currentType = [BZEditorEditType defaultType];
            }
            
            NSDictionary *typeAttribute = [weakSelf.manager currentAttributeWithType:weakSelf.currentType];
            if (weakSelf.editor.selectedTextRange.empty) {
                weakSelf.editor.typingAttributes = typeAttribute;
            }
        };
        
        self.editor.inputAccessoryView = tool;
        [self addSubview:self.editor];
        
        self.editor.backgroundColor = [UIColor systemBackgroundColor];
        [self.editor becomeFirstResponder];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.editor.frame = self.bounds;
}

- (void)configDefaultStyle:(NSDictionary *)type {
    if (type) {

    } else {
        self.currentType = [BZEditorEditType  defaultType];
    }
    
    self.editor.typingAttributes = [self.manager currentAttributeWithType:self.currentType];
}
@end

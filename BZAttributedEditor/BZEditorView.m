//
//  BZEditorView.m
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/19.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import "BZEditorView.h"
#import "BZEditorToolView.h"
#import "UITextView+AddLink.h"
#import "UITextView+AddImage.h"
@interface BZEditorView () <UITextViewDelegate>
@property (nonatomic, strong) BZEditorManager *manager;
@property (nonatomic, strong, readwrite) UITextView *editor;
@property (nonatomic, strong, readwrite) BZEditorEditType *currentType;
@property (nonatomic, strong) BZEditorToolView *tool;
@end
@implementation BZEditorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.manager = [[BZEditorManager alloc] init];
        self.editor.inputAccessoryView = self.tool;
        [self addSubview:self.editor];
    }
    return self;
}

- (UITextView *)editor {
    if (!_editor) {

        NSTextContainer *container = [[NSTextContainer alloc] initWithSize:self.bounds.size];
        _editor = [[UITextView alloc] initWithFrame:self.bounds];
        _editor.delegate = self;
        _editor.returnKeyType = UIReturnKeyDone;
        _editor.backgroundColor = [UIColor systemBackgroundColor];
        _editor.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_editor becomeFirstResponder];
        _editor.frame = self.bounds;
        _editor.layoutManager.allowsNonContiguousLayout = NO;
        ///配置默认的输入状态
        [self configDefaultStyle:nil];
    }
    return _editor;
}

- (BZEditorToolView *)tool {
    if (!_tool) {
        _tool = [[BZEditorToolView alloc] init];
        _tool.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140);

        __block typeof(self) weakSelf = self;
        _tool.selectBlock = ^(BZEditorType type) {
          
            if (type == BZEditorTypeB) {
                weakSelf.currentType.useBold = !weakSelf.currentType.useBold;
            }
            if (type == BZEditorTypeI) {
                weakSelf.currentType.useItalics = !weakSelf.currentType.useItalics;
            }
            if (type == BZEditorTypeU) {
                weakSelf.currentType.useUnderline = !weakSelf.currentType.useUnderline;
            }
            
            if (type == BZEditorTypeStrikethrough) {
                weakSelf.currentType.useStrikethrough = !weakSelf.currentType.useStrikethrough;
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
        
        _tool.actionBlock = ^(BZEditorType type) {
          
            if (type == BZEditorTypeAddImage) {
                [weakSelf.editor addImage];
            } else if (type == BZEditorTypeAddLink) {
                [weakSelf.editor addLink];
            }
        };
    }
    return _tool;
}


#pragma mark - Method
- (void)configDefaultStyle:(NSDictionary *)type {
    if (type) {

    } else {
        self.currentType = [BZEditorEditType  defaultType];
    }
    
    self.editor.typingAttributes = [self.manager currentAttributeWithType:self.currentType];
}


#pragma mark - UITextView Delegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    return YES;
}

@end

//
//  BZEditorView.m
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/19.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import "BZEditorView.h"
#import "UITextView+AddLink.h"
#import "UITextView+AddImage.h"

@interface BZEditorView () <UITextViewDelegate, BZEditorToolViewDelegate>
@property (nonatomic, strong) BZEditorManager *manager;
@property (nonatomic, strong, readwrite) UITextView *editor;
@property (nonatomic, strong, readwrite) BZEditorEditType *currentType;
@property (nonatomic, strong, readwrite) BZEditorToolView *tool;
@end

@implementation BZEditorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.manager = [[BZEditorManager alloc] init];
        self.editor.inputAccessoryView = self.tool;
        [self addSubview:self.editor];
        [self.editor becomeFirstResponder];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.editor.frame = self.bounds;
}

- (UITextView *)editor {
    if (!_editor) {
        _editor = [[UITextView alloc] initWithFrame:self.bounds];
        _editor.delegate = self;
        _editor.textContainerInset = UIEdgeInsetsMake(15, 5, 15, 5);
        _editor.returnKeyType = UIReturnKeyDone;
        _editor.backgroundColor = [UIColor systemBackgroundColor];
        _editor.frame = self.bounds;
        _editor.allowsEditingTextAttributes = YES;
        _editor.layoutManager.allowsNonContiguousLayout = NO;
        ///配置默认的输入状态
        [self configDefaultStyle:nil];
    }
    return _editor;
}

- (BZEditorToolView *)tool {
    if (!_tool) {
        _tool = [[BZEditorToolView alloc] init];
        _tool.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (40) * _tool.allToolArray.count - 5);
        _tool.delegate = self;
        __block typeof(self) weakSelf = self;
        _tool.closeBlock = ^{
            [weakSelf.editor endEditing:YES];
        };
        
        _tool.selectBlock = ^(BZEditorType type) {
          
            BZEditorEditType *editType = nil;
            if (weakSelf.editor.selectedTextRange.empty) {
                editType = weakSelf.currentType;
            } else {
                editType = [BZEditorEditType defaultType];
            }
            
            if (type == BZEditorTypeB) {
                editType.useBold = !editType.useBold;
            }
            if (type == BZEditorTypeI) {
                editType.useItalics = !editType.useItalics;
            }
            if (type == BZEditorTypeU) {
                editType.useUnderline = !editType.useUnderline;
            }
            
            if (type == BZEditorTypeStrikethrough) {
                editType.useStrikethrough = !editType.useStrikethrough;
            }
            
            if (type == BZEditorTypeFont0 || type == BZEditorTypeFont1 || type == BZEditorTypeFont2) {
                editType.fontSize = type;
            }
            
            if (type == BZEditorTypeBlack) {
                editType.fontColor = [UIColor blackColor];
            } else if (type == BZEditorTypeRed) {
                editType.fontColor = [UIColor systemRedColor];
            } else if (type == BZEditorTypeOrange) {
                editType.fontColor = [UIColor systemOrangeColor];
            } else if (type == BZEditorTypeYellow) {
                editType.fontColor = [UIColor systemYellowColor];
            } else if (type == BZEditorTypeGreen) {
                editType.fontColor = [UIColor systemGreenColor];
            } else if (type == BZEditorTypeCyanColor) {
                editType.fontColor = [UIColor cyanColor];
            } else if (type == BZEditorTypeBlue) {
                editType.fontColor = [UIColor systemBlueColor];
            } else if (type == BZEditorTypePurple) {
                editType.fontColor = [UIColor systemPurpleColor];
            }
            
            if (type >= BZEditorTypeParagraphLeft && type <= BZEditorTypeParagraphRight) {
                editType.paragraphStyle = type;
            }
            
            if (type == BZEditorTypeNormal) {
                editType = [BZEditorEditType defaultType];
            }
            
            NSDictionary *typeAttribute = [weakSelf.manager currentAttributeWithType:editType];

            if (weakSelf.editor.selectedTextRange.empty) {
                weakSelf.editor.typingAttributes = typeAttribute;
            } else {
                NSMutableAttributedString *attribute = [weakSelf.editor.attributedText mutableCopy];
                [attribute addAttributes:typeAttribute range:weakSelf.editor.selectedRange];
                [weakSelf.editor setAttributedText:attribute];
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

#pragma mark - ToolView Delegate
- (BOOL)toolViewCanSelectCurrentType:(BZEditorType)editType {

    if (editType >= BZEditorTypeParagraphLeft && editType <= BZEditorTypeParagraphRight) {
        return !self.editor.selectedTextRange.isEmpty;
    } else {
        return YES;
    }
}

@end

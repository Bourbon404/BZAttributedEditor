//
//  BZEditorToolCollectionViewCell.m
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/19.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import "BZEditorToolCollectionViewCell.h"
@interface BZEditorToolCollectionViewCell () {
    CALayer *colorLayer;
    UILabel *textLabel;
}
@end

@implementation BZEditorToolCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor systemGray6Color];
        
        colorLayer = [[CALayer alloc] init];
        colorLayer.frame = CGRectMake(2, 2, CGRectGetWidth(frame) - 4, CGRectGetHeight(frame) - 4);
        colorLayer.masksToBounds = YES;
        colorLayer.cornerRadius = CGRectGetHeight(colorLayer.frame) / 2.0f;
        [self.contentView.layer addSublayer:colorLayer];
        colorLayer.hidden = YES;
        
        textLabel = [[UILabel alloc] init];
        textLabel.frame = self.bounds;
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:textLabel];
        textLabel.hidden = YES;
    } return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.backgroundColor = [UIColor systemGray5Color];
    } else {
        self.backgroundColor = [UIColor systemGray6Color];
    }
}

- (void)setType:(BZEditorType)type {
    _type = type;
    
    colorLayer.hidden = YES;
    textLabel.hidden = YES;
    if (type >= BZEditorTypeBlack) {
        colorLayer.hidden = NO;
        UIColor *color = [UIColor blackColor];
        if (type == BZEditorTypeRed) {
            color = [UIColor systemRedColor];
        } else if (type == BZEditorTypeOrange) {
            color = [UIColor systemOrangeColor];
        } else if (type == BZEditorTypeYellow) {
            color = [UIColor systemYellowColor];
        } else if (type == BZEditorTypeGreen) {
            color = [UIColor systemGreenColor];
        } else if (type == BZEditorTypeCyanColor) {
           color = [UIColor cyanColor];
        } else if (type == BZEditorTypeBlue) {
            color = [UIColor systemBlueColor];
        } else if (type == BZEditorTypePurple) {
            color = [UIColor systemPurpleColor];
        }
        colorLayer.backgroundColor = color.CGColor;
    }
    
    if (type >= BZEditorTypeNormal && type < BZEditorTypeFont0) {
        textLabel.hidden = NO;
        if (type == BZEditorTypeNormal) {
            textLabel.text = @"N";
        } else if (type == BZEditorTypeB) {
            textLabel.text = @"B";
        } else if (type == BZEditorTypeI) {
            textLabel.text = @"I";
        } else if (type == BZEditorTypeU) {
            textLabel.text = @"U";
        }
    }
    
    if (type >= BZEditorTypeFont0 && type < BZEditorTypeBlack) {
        textLabel.hidden = NO;
        if (type == BZEditorTypeFont0) {
            textLabel.text = @"H1";
        } else if (type == BZEditorTypeFont1) {
            textLabel.text = @"H3";
        } else if (type == BZEditorTypeFont2) {
            textLabel.text = @"H5";
        }
    }
}

@end

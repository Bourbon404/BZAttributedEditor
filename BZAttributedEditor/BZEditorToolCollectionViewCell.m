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
        
        colorLayer = [[CALayer alloc] init];
        colorLayer.frame = CGRectMake(2, 2, CGRectGetWidth(frame) - 4, CGRectGetHeight(frame) - 4);
        colorLayer.masksToBounds = YES;
        colorLayer.cornerRadius = CGRectGetHeight(colorLayer.frame) / 2.0f;
        [self.contentView.layer addSublayer:colorLayer];
        colorLayer.hidden = YES;
        
        textLabel = [[UILabel alloc] init];
        textLabel.font = [UIFont fontWithName:@"iconfont" size:14];
        textLabel.frame = self.bounds;
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:textLabel];
        textLabel.hidden = YES;
        
        UIView *selectView = [[UIView alloc] init];
        selectView.backgroundColor = [UIColor darkGrayColor];
        selectView.frame = self.bounds;
        self.selectedBackgroundView = selectView;
    } return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        textLabel.textColor = [UIColor whiteColor];
    } else {
        textLabel.textColor = [UIColor blackColor];
    }
}

- (void)setType:(BZEditorType)type {
    _type = type;
    
    colorLayer.hidden = YES;
    textLabel.hidden = YES;
    if (type >= BZEditorTypeBlack && type <= BZEditorTypePurple) {
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
            textLabel.text = @"\U0000e60e";
        } else if (type == BZEditorTypeI) {
            textLabel.text = @"\U0000e613";
        } else if (type == BZEditorTypeU) {
            textLabel.text = @"\U0000e611";
        } else if (type == BZEditorTypeStrikethrough) {
            textLabel.text = @"\U0000e610";
        }
    }
    
    if (type >= BZEditorTypeFont0 && type < BZEditorTypeBlack) {
        textLabel.hidden = NO;
        if (type == BZEditorTypeFont0) {
            textLabel.text = @"\U0000e62c";
        } else if (type == BZEditorTypeFont1) {
            textLabel.text = @"\U0000e62d";
        } else if (type == BZEditorTypeFont2) {
            textLabel.text = @"\U0000e62b";
        }
    }
    
    if (type == BZEditorTypeAddImage) {
        textLabel.hidden = NO;
        textLabel.text = @"\U0000e619";
    }
    
    if (type == BZEditorTypeAddLink) {
        textLabel.hidden = NO;
        textLabel.text = @"\U0000e612";
    }
    
    if (type == BZEditorTypeParagraphLeft) {
        textLabel.hidden = NO;
        textLabel.text = @"\U0000e628";
    }
    
    if (type == BZEditorTypeParagraphCenter) {
        textLabel.hidden = NO;
        textLabel.text = @"\U0000e626";
    }
    
    if (type == BZEditorTypeParagraphRight) {
        textLabel.hidden = NO;
        textLabel.text = @"\U0000e625";
    }
    
    if (type == BZEditorTypeClose) {
        textLabel.hidden = NO;
        textLabel.text = @"\U0000e639";
    }
}

@end

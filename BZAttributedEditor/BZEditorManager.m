//
//  BZEditorManager.m
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/19.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import "BZEditorManager.h"
#import <UIKit/UIKit.h>

@interface BZEditorManager ()
@property (nonatomic, strong) NSMutableArray *allSelectType;
@end

@implementation BZEditorManager

+ (NSString *)attriToStrWithAttri:(NSAttributedString *)attri {
    NSDictionary *dict = @{
        NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
        NSCharacterEncodingDocumentAttribute : @(NSUTF8StringEncoding)
    };
    NSError *error = nil;
    NSData *data = [attri dataFromRange:NSMakeRange(0, attri.length) documentAttributes:dict error:&error];
    NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return html;
}

+ (NSAttributedString *)strToAttriWithStr:(NSString *)htmlStr {
    NSData *data = [htmlStr dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *dict = @{
        NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
        NSCharacterEncodingDocumentAttribute : @(NSUTF8StringEncoding)
    };
    NSError *error = nil;
    NSAttributedString *att = [[NSAttributedString alloc] initWithData:data options:dict documentAttributes:nil error:&error];
    return att;
}


- (instancetype)init {
    if (self = [super init]) {
        self.allSelectType = [NSMutableArray array];

        
    } return self;
}

- (NSDictionary *)currentAttributeWithType:(BZEditorEditType *)currentType {
    NSMutableDictionary *type = [NSMutableDictionary dictionary];
    UIFont *font = [UIFont systemFontOfSize:currentType.fontSize];
    if (currentType.useBold) {
        font = [UIFont boldSystemFontOfSize:currentType.fontSize];
    }
    
    [type setObject:font forKey:NSFontAttributeName];
    
    //文字样式 U I
    if (currentType.useItalics) {
        [type setObject:@(0.5) forKey:NSObliquenessAttributeName];
    }
    if (currentType.useUnderline) {
        [type setObject:@(NSUnderlineStyleSingle) forKey:NSUnderlineStyleAttributeName];
    }
    
    if (currentType.useStrikethrough) {
        [type setObject:@(NSUnderlineStyleSingle) forKey:NSBaselineOffsetAttributeName];
        [type setObject:@(NSUnderlineStyleSingle | NSUnderlinePatternSolid) forKey:NSStrikethroughStyleAttributeName];
        [type setObject:[UIColor redColor] forKey:NSStrikethroughColorAttributeName];
    }
    
    [type setObject:currentType.fontColor forKey:NSForegroundColorAttributeName];
    
    return type;
}
@end

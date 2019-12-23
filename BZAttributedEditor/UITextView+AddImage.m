//
//  UITextView+AddImage.m
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/23.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import "UITextView+AddImage.h"
@interface UITextView () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end

@implementation UITextView (AddImage)

- (void)addImage {
    
    __block UIWindow *window = nil;
    [[UIApplication sharedApplication].connectedScenes enumerateObjectsUsingBlock:^(UIScene * _Nonnull obj, BOOL * _Nonnull stop) {
       
        if (obj.activationState == UISceneActivationStateForegroundActive) {
            window = ((UIWindowScene *)obj).windows.firstObject;
            *stop = YES;
        }
    }];
    
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        [picker setSourceType:(UIImagePickerControllerSourceTypePhotoLibrary)];
        [picker setDelegate:self];
        [window.rootViewController presentViewController:picker animated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请打开相册权限" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
        attachment.image = image;
        attachment.bounds = CGRectMake(0, 0, 100, 100 * image.size.height / image.size.width);
        NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:attachment];
        
        NSDictionary *originType = [self.typingAttributes copy];
        
        NSMutableAttributedString *originAttribute = [self.attributedText mutableCopy];
        [originAttribute appendAttributedString:att];
        self.attributedText = originAttribute;
        self.typingAttributes = originType;
    }];
}
@end

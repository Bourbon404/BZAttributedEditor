//
//  ViewController.m
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/19.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import "ViewController.h"
#import "WKViewController.h"
#import "BZEditorView.h"
@interface ViewController ()
@property (nonatomic, strong) BZEditorView *editorView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"editor";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:(UIBarButtonItemStylePlain) target:self action:@selector(action)];
    
    self.editorView = [[BZEditorView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.editorView];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"html"];
//    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    NSAttributedString *att = [BZEditorManager strToAttriWithStr:string];
//    NSLog(@"%@",att);
//    self.editorView.editor.attributedText = att;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)action {
    
    NSString *html = [BZEditorManager attriToStrWithAttri:self.editorView.editor.attributedText];
    WKViewController *web = [[WKViewController alloc] init];
    web.html = html;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)keyboardWillShow:(NSNotification *)notify {

    CGFloat keyboardHeight = [[notify.userInfo objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue].size.height;
    CGRect rect = self.view.bounds;
    rect.size.height = self.view.bounds.size.height - /*self.editorView.editor.inputAccessoryView.frame.size.height - */ keyboardHeight;
    [UIView animateWithDuration:0.25f animations:^{
        
        self.editorView.frame = rect;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notif {
    [UIView animateWithDuration:0.25f animations:^{
        self.editorView.frame = self.view.bounds;
    }];
}

@end

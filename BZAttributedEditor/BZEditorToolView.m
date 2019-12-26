//
//  BZEditorToolView.m
//  BZAttributedEditor
//
//  Created by 郑伟 on 2019/12/19.
//  Copyright © 2019 BourbonZ. All rights reserved.
//

#import "BZEditorToolView.h"
#import "BZEditorToolCollectionViewCell.h"
#import "BZEditorManager.h"
@interface BZEditorToolView () <UICollectionViewDataSource, UICollectionViewDelegate> {
}

@property (nonatomic, strong) UICollectionView *toolCollection0;
@property (nonatomic, strong) UICollectionView *toolCollection1;
@property (nonatomic, strong) UICollectionView *toolCollection2;
@property (nonatomic, strong) UICollectionView *toolCollection3;
@property (nonatomic, strong) UICollectionView *toolCollection4;
@property (nonatomic, strong, readwrite) NSMutableArray <UICollectionView *>*allToolArray;
@end
@implementation BZEditorToolView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
    
        self.allToolArray = [NSMutableArray array];
        
        self.toolCollection0 = [self createCollectoin];
        self.toolCollection0.allowsMultipleSelection = YES;
        [self addSubview:self.toolCollection0];
        [self.allToolArray addObject:self.toolCollection0];
        
        self.toolCollection1 = [self createCollectoin];
        self.toolCollection1.allowsMultipleSelection = NO;
        [self addSubview:self.toolCollection1];
        [self.allToolArray addObject:self.toolCollection1];
        
        self.toolCollection2 = [self createCollectoin];
        self.toolCollection2.allowsMultipleSelection = NO;
        [self addSubview:self.toolCollection2];
        [self.allToolArray addObject:self.toolCollection2];
        
        self.toolCollection3 = [self createCollectoin];
        self.toolCollection3.allowsMultipleSelection = NO;
        [self addSubview:self.toolCollection3];
        [self.allToolArray addObject:self.toolCollection3];
        
        self.toolCollection4 = [self createCollectoin];
        self.toolCollection4.allowsMultipleSelection = NO;
        [self addSubview:self.toolCollection4];
        [self.allToolArray addObject:self.toolCollection4];
        
        self.backgroundColor = [UIColor systemBackgroundColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat space = 5;
    CGFloat height = (self.frame.size.height - self.allToolArray.count * space) / self.allToolArray.count;
    [self.allToolArray enumerateObjectsUsingBlock:^(UICollectionView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(0, (space + height) * idx , self.frame.size.width, height);
    }];
}

- (UICollectionView *)createCollectoin {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(30, 30);
    UICollectionView *toolCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    toolCollection.backgroundColor = [UIColor systemGray4Color];
    toolCollection.dataSource = self;
    toolCollection.delegate = self;
    [toolCollection registerClass:[BZEditorToolCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    toolCollection.showsHorizontalScrollIndicator = NO;
    toolCollection.showsVerticalScrollIndicator = NO;
    return toolCollection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.toolCollection0) {
        return 5;
    } else if (collectionView == self.toolCollection1) {
        return 3;
    } else if (collectionView == self.toolCollection2) {
        return 8;
    } else if (collectionView == self.toolCollection3) {
        return 2;
    } else if (collectionView == self.toolCollection4){
        return 4;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BZEditorToolCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    if (collectionView == self.toolCollection0) {
        cell.type = BZEditorTypeNormal + indexPath.item;
    } else if (collectionView == self.toolCollection1) {
        if (indexPath.item == 0) {
            cell.type = BZEditorTypeFont0;
        } else if (indexPath.item == 1) {
            cell.type = BZEditorTypeFont1;
        } else if (indexPath.item == 2) {
            cell.type = BZEditorTypeFont2;
        }
    } else if (collectionView == self.toolCollection2) {
        cell.type = BZEditorTypeBlack + indexPath.item;
    } else if (collectionView == self.toolCollection3) {
        cell.type = BZEditorTypeAddImage + indexPath.item;
    } else if (collectionView == self.toolCollection4) {
        cell.type = BZEditorTypeParagraphLeft + indexPath.item;
    }
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(toolViewCanSelectCurrentType:)]) {
        BZEditorToolCollectionViewCell *cell = (BZEditorToolCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        return [self.delegate toolViewCanSelectCurrentType:cell.type];
    } else {
        return YES;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    BZEditorToolCollectionViewCell *cell = (BZEditorToolCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    if (self.selectBlock && (cell.type < BZEditorTypeAddImage || (cell.type >= BZEditorTypeParagraphLeft && cell.type <= BZEditorTypeParagraphRight))) {
        self.selectBlock(cell.type);
    }
    
    
    if (self.actionBlock && cell.type >= BZEditorTypeAddImage && cell.type <= BZEditorTypeAddLink) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        if (self.actionBlock) {
            self.actionBlock(cell.type);
        }
    }
    
    if (cell.type == BZEditorTypeNormal) {
        [self.allToolArray enumerateObjectsUsingBlock:^(UICollectionView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
            if (view != self.toolCollection4) {
                [view.indexPathsForSelectedItems enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [view deselectItemAtIndexPath:obj animated:YES];
                }];
            }
        }];
    }
    
    if (cell.type == BZEditorTypeClose) {
        self.closeBlock();
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BZEditorToolCollectionViewCell *cell = (BZEditorToolCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    if (self.selectBlock && cell.type < BZEditorTypeBlack) {
        self.selectBlock(cell.type);
    }
}

@end

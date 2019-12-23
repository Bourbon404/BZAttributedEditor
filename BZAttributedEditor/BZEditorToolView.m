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
    NSMutableArray *allToolArray;
}

@property (nonatomic, strong) UICollectionView *toolCollection0;
@property (nonatomic, strong) UICollectionView *toolCollection1;
@property (nonatomic, strong) UICollectionView *toolCollection2;
@property (nonatomic, strong) UICollectionView *toolCollection3;

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
    
        allToolArray = [NSMutableArray array];
        
        self.toolCollection0 = [self createCollectoin];
        self.toolCollection0.allowsMultipleSelection = YES;
        [self addSubview:self.toolCollection0];
        [allToolArray addObject:self.toolCollection0];
        
        self.toolCollection1 = [self createCollectoin];
        self.toolCollection1.allowsMultipleSelection = NO;
        [self addSubview:self.toolCollection1];
        [allToolArray addObject:self.toolCollection1];
        
        self.toolCollection2 = [self createCollectoin];
        self.toolCollection2.allowsMultipleSelection = NO;
        [self addSubview:self.toolCollection2];
        [allToolArray addObject:self.toolCollection2];
        
        self.toolCollection3 = [self createCollectoin];
        self.toolCollection3.allowsMultipleSelection = NO;
        [self addSubview:self.toolCollection3];
        [allToolArray addObject:self.toolCollection3];
        
        self.backgroundColor = [UIColor systemBackgroundColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat space = 5;
    CGFloat height = (self.frame.size.height - 4 * space) / allToolArray.count;
    self.toolCollection0.frame = CGRectMake(0, space, self.frame.size.width, height);
    self.toolCollection1.frame = CGRectMake(0, CGRectGetMaxY(self.toolCollection0.frame) + space, self.frame.size.width, height);
    self.toolCollection2.frame = CGRectMake(0, CGRectGetMaxY(self.toolCollection1.frame) + space, self.frame.size.width, height);
    self.toolCollection3.frame = CGRectMake(0, CGRectGetMaxY(self.toolCollection2.frame) + space, self.frame.size.width, height);
}

- (UICollectionView *)createCollectoin {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(30, 30);
    UICollectionView *toolCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    toolCollection.backgroundColor = [UIColor systemGray4Color];
    toolCollection.dataSource = self;
    toolCollection.delegate = self;
    toolCollection.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
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
    } else {
        return 0;
    }
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
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    BZEditorToolCollectionViewCell *cell = (BZEditorToolCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    if (self.selectBlock && cell.type < BZEditorTypeAddImage) {
        self.selectBlock(cell.type);
    }
    
    
    if (self.actionBlock && cell.type >= BZEditorTypeAddImage) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        if (self.actionBlock) {
            self.actionBlock(cell.type);
        }
    }
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BZEditorToolCollectionViewCell *cell = (BZEditorToolCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    if (self.selectBlock && cell.type < BZEditorTypeAddImage) {
        self.selectBlock(cell.type);
    }
}

@end

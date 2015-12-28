//
//  OFEmotionListView.m
//  OnFire
//
//  Created by YeZhongxiang on 15/12/22.
//  Copyright © 2015年 OnFire. All rights reserved.
//

#import "OFEmotionListView.h"
#import "OFEmotionGridView.h"
#import "OFEmotionMacro.h"

@interface OFEmotionListView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView    *scrollView;
@property (nonatomic, weak) UIPageControl   *pageControl;

@end

@implementation OFEmotionListView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
        
        // 1.显示所有表情的UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        // 滚动条是UIScrollView的子控件
        // 隐藏滚动条，可以屏蔽多余的子控件
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.显示页码的UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];

        pageControl.hidesForSinglePage = YES;
        pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"5a6572"];
        pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"959698"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions {
    
    _emotions = emotions;

    // 设置总页数
    NSInteger totalPages = (emotions.count + OFEmotionMaxCountPerPage - 1) / OFEmotionMaxCountPerPage;
    NSInteger currentGridViewCount = self.scrollView.subviews.count;
    self.pageControl.numberOfPages = totalPages;
    self.pageControl.currentPage = 0;
    
    // 决定scrollView显示多少页表情
    for (int i = 0; i<totalPages; i++) {
        // 获得i位置对应的OFEmotionGridView
        OFEmotionGridView *gridView = nil;
        if (i >= currentGridViewCount) { // 说明OFEmotionGridView的个数不够
            gridView = [[OFEmotionGridView alloc] init];
            [self.scrollView addSubview:gridView];
        } else { // 说明OFEmotionGridView的个数足够，从self.scrollView.subviews中取出OFEmotionGridView
            gridView = self.scrollView.subviews[i];
        }
        
        // 给OFEmotionGridView设置表情数据
        NSInteger loc = i * OFEmotionMaxCountPerPage;
        NSInteger len = OFEmotionMaxCountPerPage;
        if (loc + len > emotions.count) { // 对越界进行判断处理
            len = emotions.count - loc;
        }
        NSRange gridViewEmotionsRange = NSMakeRange(loc, len);
        NSArray *gridViewEmotions = [emotions subarrayWithRange:gridViewEmotionsRange];
        gridView.emotions = gridViewEmotions;
        gridView.hidden = NO;
    }
    
    // 隐藏后面的不需要用到的gridView
    for (NSInteger i = totalPages; i<currentGridViewCount; i++) {
        OFEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.hidden = YES;
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
    
    // 表情滚动到最前面
    self.scrollView.contentOffset = CGPointZero;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 1.UIPageControl的frame
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.UIScrollView的frame
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    // 3.设置UIScrollView内部控件的尺寸
    NSInteger count = self.pageControl.numberOfPages;
    CGFloat gridW = self.scrollView.width;
    CGFloat gridH = self.scrollView.height;
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    for (int i = 0; i<count; i++) {
        OFEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.width = gridW;
        gridView.height = gridH;
        gridView.x = i * gridW;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
}


@end

//
//  OFEmotionGridView.m
//  OnFire
//
//  Created by YeZhongxiang on 15/12/22.
//  Copyright © 2015年 OnFire. All rights reserved.
//  

#import "OFEmotionGridView.h"
#import "OFEmotionView.h"
#import "OFEmotion.h"
#import "OFEmotionTool.h"
#import "OFEmotionMacro.h"

@interface OFEmotionGridView ()

@property (nonatomic, weak) UIButton *deleteButton;
@property (nonatomic, strong) NSMutableArray *emotionViews;

@end

@implementation OFEmotionGridView

#pragma mark - lazy

- (NSMutableArray *)emotionViews {
    if (_emotionViews == nil) {
        self.emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        // 添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        // 给自己添加一个长按手势
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

// 根据触摸点返回对应的表情控件
- (OFEmotionView *)emotionViewWithPoint:(CGPoint)point {
    __block OFEmotionView *foundEmotionView = nil;
    [self.emotionViews enumerateObjectsUsingBlock:^(OFEmotionView *emotionView, NSUInteger idx, BOOL *stop) {
        // 没有显示的表情就不需要处理
        if (CGRectContainsPoint(emotionView.frame, point) && emotionView.hidden == NO) {
            foundEmotionView = emotionView;
            *stop = YES;
        }
    }];
    return foundEmotionView;
}

// 删除按钮点击
- (void)deleteButtonClick:(UIButton *)sender {
    DLog(@"删除--");
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:OFEmotionDidDeletedNotification object:nil userInfo:nil];
}

// 长按手势
- (void)longPress:(UILongPressGestureRecognizer *)recognizer {
    
    // 捕获触摸点
    CGPoint point = [recognizer locationInView:recognizer.view];
    
    // 检测触摸点落在哪个表情上面
    OFEmotionView *emotionView =  [self emotionViewWithPoint:point];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) { // 手松开
        [self selecteEmotion:emotionView.emotion];
    } else { // 没松开
        // 啥都不做
    }
}

// 选中表情
- (void)selecteEmotion:(OFEmotion *)emotion {
    if (emotion == nil) return;
    DLog(@"选中了%@", emotion.chs);
    // 发出选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:OFEmotionDidSelectedNotification object:nil userInfo:@{ OFSelectedEmotion : emotion  }];
}

// 重写表情setter方法
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    // 添加新的表情
    NSInteger count = emotions.count;
    NSInteger currentEmotionViewCount = self.emotionViews.count;
    for (NSInteger i = 0; i<count; i++) {
        OFEmotionView *emotionView = nil;
        
        if (i >= currentEmotionViewCount) { // emotionView不够用
            emotionView = [[OFEmotionView alloc] init];
            [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        } else { // emotionView够用
            emotionView = self.emotionViews[i];
        }
        // 传递模型数据
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
    }
    
    // 隐藏多余的emotionView
    for (NSInteger i = count; i<currentEmotionViewCount; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.hidden = YES;
    }

}

// 表情的点击
- (void)emotionClick:(OFEmotionView *)emotionView {
    // 选中表情
    [self selecteEmotion:emotionView.emotion];
}

// 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    
    // 1.排列所有的表情
    NSInteger count = self.emotionViews.count;
    CGFloat emotionViewW = (self.width - 2 * leftInset) / OFEmotionMaxCols;
    CGFloat emotionViewH = (self.height - topInset) / OFEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.x = leftInset + (i % OFEmotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / OFEmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
    
    // 2.删除按钮
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - leftInset - self.deleteButton.width;
    self.deleteButton.y = self.height - self.deleteButton.height;
}

@end
























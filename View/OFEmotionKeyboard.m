//
//  OFEmotionKeyboard.m
//  OnFire
//
//  Created by YeZhongxiang on 15/12/22.
//  Copyright © 2015年 OnFire. All rights reserved.
//

#import "OFEmotionKeyboard.h"
#import "OFEmotionListView.h"
#import "OFEmotionTool.h"

@interface OFEmotionKeyboard ()

@property (nonatomic, weak) OFEmotionListView *listView;

@end

@implementation OFEmotionKeyboard

+ (instancetype)keyboard {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kScreen_WIDTH, 216);
        
        // 添加表情列表
        OFEmotionListView *listView = [[OFEmotionListView alloc] init];
        listView.emotions = [OFEmotionTool defaultEmotions];
        [self addSubview:listView];
        self.listView = listView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.listView.width = self.width;
    self.listView.height = self.height;
}

@end

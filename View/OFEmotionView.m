//
//  OFEmotionView.m
//  OnFire
//
//  Created by YeZhongxiang on 15/12/22.
//  Copyright © 2015年 OnFire. All rights reserved.
//  

#import "OFEmotionView.h"
#import "OFEmotion.h"

@implementation OFEmotionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(OFEmotion *)emotion {
    _emotion = emotion;
    
    // 如果直接放在Bundle根目录下就不需要拼接路径了, 现在用的是文件夹引用(蓝色文件夹)
    NSString *icon = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
    
    UIImage *image = [UIImage imageNamed:icon];
    if (iOS7) { // 不需要进行蓝色的渲染
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [self setImage:image forState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateNormal];
}

@end

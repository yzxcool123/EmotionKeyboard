//
//  OFEmotionAttachment.m
//  OnFire
//
//  Created by YeZhongxiang on 15/12/23.
//  Copyright © 2015年 OnFire. All rights reserved.
//

#import "OFEmotionAttachment.h"
#import "OFEmotion.h"

@implementation OFEmotionAttachment

- (void)setEmotion:(OFEmotion *)emotion {
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png]];
}

@end

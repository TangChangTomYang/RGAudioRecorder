//
//  RGMp3AudioRecorder.h
//  RGMp3AudioRecorder
//
//  Created by yangrui on 2018/11/19.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGMp3AudioRecorder : NSObject

/** 录制成功后的文件路径*/
@property(nonatomic, copy,readonly)NSString *outputPath;
/**
 minInterval : 最短的录制时间
 */
+(instancetype)recorderWithMinInterval:(NSTimeInterval)minInterval;
-(void)start;
-(void)startAtTime:(NSTimeInterval)timeInterval;

-(void)stop;
@end

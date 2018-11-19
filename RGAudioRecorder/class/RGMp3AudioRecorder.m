//
//  RGMp3AudioRecorder.m
//  RGMp3AudioRecorder
//
//  Created by yangrui on 2018/11/19.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "RGMp3AudioRecorder.h"
#import <AVFoundation/AVFoundation.h>
#import "LameTool.h"

@interface RGMp3AudioRecorder (){
    NSString *_outputPath;
}
@property(nonatomic, strong)AVAudioRecorder *recorder;
/** 最短的录制时间
 */
@property(nonatomic, assign)NSTimeInterval minInterval;

@property(nonatomic, copy)NSString *tempPath;

@end


@implementation RGMp3AudioRecorder

/**
 minInterval : 最短的录制时间
 */
+(instancetype)recorderWithMinInterval:(NSTimeInterval)minInterval{
    RGMp3AudioRecorder *mp3Recorder = [[self alloc] init];
    mp3Recorder.minInterval = minInterval;
    return mp3Recorder;
}


-(NSString *)tempPath{
    if(_tempPath.length == 0){
        NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *name = [NSString stringWithFormat:@"%ld.caf",(long)[[NSDate date] timeIntervalSince1970]];
        
        _tempPath = [cache stringByAppendingPathComponent:name];
    }
    return _tempPath;
}

-(AVAudioRecorder *)recorder{
    if (!_recorder) {
        //存储录音文件的地址
        NSURL *url = [NSURL URLWithString:self.tempPath];
        // 音频质量参数,保证音频最小的同时满足音质的需要
        NSDictionary *setting = @{
                                  // 编码格式
                                  AVFormatIDKey : @(kAudioFormatLinearPCM),
                                  // 采样率
                                  AVSampleRateKey : @(11025.0),
                                  // 通道数
                                  AVNumberOfChannelsKey:@(2),
                                  // 录音质量
                                  AVEncoderAudioQualityKey : @(AVAudioQualityMin)
                                  
                                  };
        NSError *err = nil;
        _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:&err];
        
        // 准备录音(系统会给我们分配一些资源)
        [_recorder prepareToRecord];
        if (err) {
            _recorder = nil;
            NSLog(@"=======在创建录音工具时失败: %@",err.localizedDescription);
        }
        
    }
    
    return _recorder;
}

-(void)start{
    
    if(self.recorder != nil){
        self.recorder = nil;
    }
    [self.recorder record];
}

-(void)startAtTime:(NSTimeInterval)timeInterval{
    if(self.recorder != nil){
        self.recorder = nil;
    }
    [self.recorder recordAtTime:timeInterval];
}


-(void)stop{
    NSLog(@"结束录音");
    // 像微信等IM app 通常录音时间太短会自动取消并删除录音文件
    if(self.minInterval > 0 &&  self.recorder.currentTime < self.minInterval){
        //要删除录音文件需要做2件事
        //1. 停止正在进行的录音
        //2. 执行删除动作
        [self.recorder stop];
        [self.recorder deleteRecording];
    }
    else{ // 正常的结束录音
        [self.recorder stop];
       self.outputPath = [LameTool audioToMP3:self.tempPath isDeleteSourchFile:YES];
    }
}

-(NSString *)outputPath{
    return _outputPath;
}

-(void)setOutputPath:(NSString *)outputPath{
    
    NSLog(@"输出文件: %@",outputPath);
    _outputPath = [outputPath copy];
}

@end

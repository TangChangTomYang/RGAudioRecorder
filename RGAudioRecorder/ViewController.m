//
//  ViewController.m
//  RGAudioRecorder
//
//  Created by yangrui on 2018/11/19.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "ViewController.h"
#import "RGMp3AudioRecorder.h"

@interface ViewController ()


@property(nonatomic, strong)RGMp3AudioRecorder *recorder;
@end

@implementation ViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //1. 创建录音器
    self.recorder = [RGMp3AudioRecorder recorderWithMinInterval:2];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    //2. 开始录音
    [self.recorder start];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //3. 停止录音
    [self.recorder stop];
    
    NSLog(@"录音文件: %@",self.recorder.outputPath);
}

@end

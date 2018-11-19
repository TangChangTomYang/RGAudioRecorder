//
//  ViewController.h
//  LameTool
//
//  Created by yangrui on 2018/11/19.
//  Copyright © 2018年 yangrui. All rights reserved.

#import <Foundation/Foundation.h>

@interface LameTool : NSObject

+ (NSString *)audioToMP3: (NSString *)sourcePath isDeleteSourchFile: (BOOL)isDelete;

@end

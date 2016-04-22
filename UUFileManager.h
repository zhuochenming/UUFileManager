//
//  UUFileManager.h
//  zhuochenming
//
//  Created by zhuochenming on 14/5/11.
//  Copyright © 2014年 zhuochenming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UUFileManager : NSObject//路径NSCachesDirectory

#pragma mark - 缓存文件 设置
+ (BOOL)cacheWithName:(NSString *)fileName string:(NSString *)string;

#pragma mark - 缓存文件 设置 NSData
+ (BOOL)cacheWithName:(NSString *)fileName data:(NSData *)data;

#pragma mark - 缓存文件 读取
+ (NSString *)stringWithFileName:(NSString *)fileName;

#pragma mark - 缓存文件 读取 NSData
+ (NSData *)dataWithFileName:(NSString *)fileName;

#pragma mark - 缓存文件 是否过期 expiredSecond 过期多少秒
+ (BOOL)isExpired:(NSString *)fileName expiredSecond:(NSInteger)expiredSecond;

#pragma mark - 缓存文件 是否存在
+ (BOOL)isExist:(NSString *)fileName;

#pragma mark - 缓存文件 删除
+ (BOOL)deleteFile:(NSString *)fileName;

@end

@interface UUFileManager (OtherFileManager)

#pragma mark - 缓存文件路径
+ (NSString *)documentDicWithFileName:(NSString *)fileName;

+ (NSString *)libraryDicWithFileName:(NSString *)fileName;

+ (NSString *)documentDicWithDic:(NSString *)dicName fileName:(NSString *)fileName;

+ (NSString *)libraryDicWithDic:(NSString *)dicName fileName:(NSString *)fileName;

#pragma mark - 缓存文件 设置 NSString
+ (BOOL)cacheWithPath:(NSString *)path string:(NSString *)string;

#pragma mark - 缓存文件 设置 NSData
+ (BOOL)cacheWithPath:(NSString *)path data:(NSData *)data;

#pragma mark - 缓存文件 读取
+ (NSString *)stringWithPath:(NSString *)path;

#pragma mark - 缓存文件 读取 NSData
+ (NSData *)dataWithPath:(NSString *)path;

#pragma mark - 缓存文件 是否过期 expiredSecond 过期多少秒
+ (BOOL)isExpiredInPath:(NSString *)path expiredSecond:(NSInteger)expiredSecond;

#pragma mark - 缓存文件 是否存在
+ (BOOL)isExistInPath:(NSString *)path;

#pragma mark - 缓存文件 删除
+ (BOOL)deleteFileInPath:(NSString *)path;

@end

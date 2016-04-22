//
//  UUFileManager.m
//  zhuochenming
//
//  Created by zhuochenming on 14/5/11.
//  Copyright © 2014年 zhuochenming. All rights reserved.
//

#import "UUFileManager.h"

@implementation UUFileManager

#pragma mark - 缓存文件 路径
+ (NSString *)filePathWithName:(NSString *)fileName {
    NSString *path= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingString:@"/"];
    path = [path stringByAppendingString:fileName];
    return path;
}

#pragma mark - 缓存文件 设置
+ (BOOL)cacheWithName:(NSString *)fileName string:(NSString *)string {
    NSError *error;
    NSString *path = [self filePathWithName:fileName];
    NSFileManager *filemanmger = [NSFileManager defaultManager];
    if ([filemanmger fileExistsAtPath:path]) {
        [filemanmger removeItemAtPath:path error:&error];
    }
    return [filemanmger createFileAtPath:path contents:[string dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
}

#pragma mark - 缓存文件 设置 NSData
+ (BOOL)cacheWithName:(NSString *)fileName data:(NSData *)data {
    NSError *error;
    NSString *path = [self filePathWithName:fileName];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:path]) {
        [filemanager removeItemAtPath:path error:&error];
    }
    return [filemanager createFileAtPath:path contents:data attributes:nil];
}

#pragma mark - 缓存文件 读取
+ (NSString *)stringWithFileName:(NSString *)fileName {
    NSString *path = [self filePathWithName:fileName];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:path]) {
        return [[NSString alloc] initWithData:[filemanager contentsAtPath:path] encoding:NSUTF8StringEncoding];
    }
    return @"";
}

#pragma mark - 缓存文件 读取 NSData
+ (NSData *)dataWithFileName:(NSString *)fileName {
    NSString *path = [self filePathWithName:fileName];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:path]) {
        return [filemanager contentsAtPath:path];
    }
    return nil;
}

#pragma mark - 缓存文件 是否过期 expiredSecond 过期多少秒
+ (BOOL)isExpired:(NSString *)fileName expiredSecond:(NSInteger)expiredSecond {
    NSString *path = [self filePathWithName:fileName];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if (![filemanager fileExistsAtPath:path]) {
        return YES;
    }
    
    NSError *error;
    NSDictionary *fileAttributes = [filemanager attributesOfFileSystemForPath:path error:&error];
    NSDate *fileModDate = [fileAttributes objectForKey:NSFileModificationDate];
    if ([[NSDate date] timeIntervalSinceDate:fileModDate] > expiredSecond) {
        return  YES;
    } else {
        return NO;
    }
    return  YES;
}

#pragma mark - 缓存文件 是否存在
+ (BOOL)isExist:(NSString *)fileName {
    NSString *path = [self filePathWithName:fileName];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    return [filemanager fileExistsAtPath:path];
}

#pragma mark - 缓存文件 删除
+ (BOOL)deleteFile:(NSString *)fileName {
    NSString *path = [self filePathWithName:fileName];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:path]) {
        NSError *error;
        return [filemanager removeItemAtPath:path error:&error];
    }
    return YES;
}

@end

@implementation UUFileManager (OtherFileManager)

+ (NSString *)documentDicWithFileName:(NSString *)fileName {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@", fileName]];
    return path;
}

+ (NSString *)libraryDicWithFileName:(NSString *)fileName {
    NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [libraryPath stringByAppendingString:[NSString stringWithFormat:@"/%@", fileName]];
    return path;
}

+ (NSString *)documentDicWithDic:(NSString *)dicName fileName:(NSString *)fileName {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *plistPath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@", dicName, fileName]];
    
    NSString *dicPath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@/", dicName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dicName]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dicPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return plistPath;
}

+ (NSString *)libraryDicWithDic:(NSString *)dicName fileName:(NSString *)fileName {
    NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [libraryPath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@", dicName, fileName]];
    
    NSString *dicPath = [libraryPath stringByAppendingString:[NSString stringWithFormat:@"/%@/", dicName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dicName]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dicPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

#pragma mark - 缓存文件 设置
+ (BOOL)cacheWithPath:(NSString *)path string:(NSString *)string {
    NSError *error;
    NSFileManager *filemanmger = [NSFileManager defaultManager];
    if ([filemanmger fileExistsAtPath:path]) {
        [filemanmger removeItemAtPath:path error:&error];
    }
    return [filemanmger createFileAtPath:path contents:[string dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
}

#pragma mark - 缓存文件 设置 NSData
+ (BOOL)cacheWithPath:(NSString *)path data:(NSData *)data {
    NSError *error;
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:path]) {
        [filemanager removeItemAtPath:path error:&error];
    }
    return [filemanager createFileAtPath:path contents:data attributes:nil];
}

#pragma mark - 缓存文件 读取
+ (NSString *)stringWithPath:(NSString *)path {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:path]) {
        return [[NSString alloc] initWithData:[filemanager contentsAtPath:path] encoding:NSUTF8StringEncoding];
    }
    return @"";
}

#pragma mark - 缓存文件 读取 NSData
+ (NSData *)dataWithPath:(NSString *)path {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:path]) {
        return [filemanager contentsAtPath:path];
    }
    return nil;
}

#pragma mark - 缓存文件 是否过期 expiredSecond 过期多少秒
+ (BOOL)isExpiredInPath:(NSString *)path expiredSecond:(NSInteger)expiredSecond {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if (![filemanager fileExistsAtPath:path]) {
        return YES;
    }
    
    NSError *error;
    NSDictionary *fileAttributes = [filemanager attributesOfFileSystemForPath:path error:&error];
    NSDate *fileModDate = [fileAttributes objectForKey:NSFileModificationDate];
    if ([[NSDate date] timeIntervalSinceDate:fileModDate] > expiredSecond) {
        return  YES;
    } else {
        return NO;
    }
    return  YES;
}

#pragma mark - 缓存文件 是否存在
+ (BOOL)isExistInPath:(NSString *)path {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    return [filemanager fileExistsAtPath:path];
}

#pragma mark - 缓存文件 删除
+ (BOOL)deleteFileInPath:(NSString *)path {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:path]) {
        NSError *error;
        return [filemanager removeItemAtPath:path error:&error];
    }
    return YES;
}

@end

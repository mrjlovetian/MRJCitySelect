//
//  CityModelManger.m
//  LoveQi
//
//  Created by tops on 2018/3/1.
//  Copyright © 2018年 余洪江. All rights reserved.
//

#import "CityModelManger.h"
#import "MJExtension.h"

@implementation CityModelManger

MJExtensionCodingImplementation

/// 检测字母的读音是否
+ (NSString *)phonetic:(NSString *)sourceString {
    if ([sourceString isEqualToString:@""]) {
        return sourceString;
    }
    
    NSMutableString *source = [sourceString mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    // 多音字处理
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"长"] == NSOrderedSame) {
        [source replaceCharactersInRange:NSMakeRange(0, 5)withString:@"chang"];
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"沈"] == NSOrderedSame) {
        [source replaceCharactersInRange:NSMakeRange(0, 4)withString:@"shen"];
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"厦"] == NSOrderedSame) {
        [source replaceCharactersInRange:NSMakeRange(0, 3)withString:@"xia"];
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"地"] == NSOrderedSame) {
        [source replaceCharactersInRange:NSMakeRange(0, 3)withString:@"di"];
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"重"] == NSOrderedSame) {
        [source replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    
    return source;
}

/// 城市按字母排序
+ (void)sorterFromArray:(NSArray *)array success:(void (^)(NSArray *entryWords, NSDictionary *sorterArray))success {
    NSMutableDictionary *sorterDic = [[NSMutableDictionary alloc]init];
    NSMutableArray *entryWords = [[NSMutableArray alloc]init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (CityModelManger *city in array) {
            NSString *cityName = city.regionName;
            NSString *entryStr = [NSString stringWithFormat:@"%@", [self phonetic:cityName]];
            if ( entryStr.length  > 1 ) {
                entryStr = [entryStr substringToIndex:1];
            }
            entryStr = [entryStr uppercaseString]; // 大写
            NSMutableArray *mbArray = [[NSMutableArray alloc]initWithArray:[sorterDic objectForKey:entryStr]];
            if (mbArray.count == 0) {
                [entryWords addObject:entryStr];
            }
            [mbArray addObject:city];
            [sorterDic setObject:mbArray forKey:entryStr];
        }
        // 按字母顺序排序
        NSArray *resultkArrSort = [entryWords sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        
        /// 开启现成保存数据
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self saveAllCity:resultkArrSort];
            [self saveAllSortCity:sorterDic];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(resultkArrSort,[NSDictionary dictionaryWithDictionary:sorterDic]);
            }
        });
    });
}

/// 简单数据类型采用数据读写的方式存储
+ (void)saveAllCity:(NSArray *)citys {
    /// 此处的版本存储用做辅佐判断是否请求新数据的条件
    NSInteger version = [[ [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
    [[NSUserDefaults standardUserDefaults] setObject:@(version) forKey:@"version"];
    NSString *cachefile = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *pathFile = [cachefile stringByAppendingPathComponent:@"mrj_citys.json"];  //要保存的文件名
    [citys writeToFile:pathFile atomically:YES];  //写入文件
}

+ (NSArray *)getAllCitys {
    NSString *cachefile = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *pathFile = [cachefile stringByAppendingPathComponent:@"mrj_citys.json"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:pathFile];
    return arr;
}

/// 复杂对象类型采用归档
+ (void)saveAllSortCity:(NSDictionary *)sortCity {
    NSString *cachefile = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *pathFile = [cachefile stringByAppendingPathComponent:@"mrj_sortCity.data"];  //要保存的文件名
    [NSKeyedArchiver archiveRootObject:sortCity toFile:pathFile];
}

+ (NSDictionary *)getAllSortCity {
    NSString *cachefile = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *pathFile = [cachefile stringByAppendingPathComponent:@"mrj_sortCity.data"];
    NSDictionary *sortCity = [NSKeyedUnarchiver unarchiveObjectWithFile:pathFile];
    return sortCity;
}

@end

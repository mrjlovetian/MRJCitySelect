//
//  CityModelManger.m
//  LoveQi
//
//  Created by tops on 2018/3/1.
//  Copyright © 2018年 李琦. All rights reserved.
//

#import "CityModelManger.h"

@implementation CityModelManger

//检测字母的读音是否
+ (NSString *)phonetic:(NSString *)sourceString {
    
    if ([sourceString isEqualToString:@""]) {
        return sourceString;
    }
    
    NSMutableString *source = [sourceString mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"长"] ==NSOrderedSame) {
        [source replaceCharactersInRange:NSMakeRange(0, 5)withString:@"chang"];
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"沈"] ==NSOrderedSame) {
        [source replaceCharactersInRange:NSMakeRange(0, 4)withString:@"shen"];
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"厦"] ==NSOrderedSame) {
        [source replaceCharactersInRange:NSMakeRange(0, 3)withString:@"xia"];
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"地"] ==NSOrderedSame) {
        [source replaceCharactersInRange:NSMakeRange(0, 3)withString:@"di"];
    }
    
    if ([[(NSString *)sourceString substringToIndex:1] compare:@"重"] ==NSOrderedSame) {
        [source replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    
    return source;
}

/// 城市按字母排序
+ (void)sorterFromArray:(NSArray *)array success:(void (^)(NSArray *entryWords, NSDictionary *sorterArray))success
{
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(resultkArrSort,[NSDictionary dictionaryWithDictionary:sorterDic]);
            }
        });
    });
}

@end

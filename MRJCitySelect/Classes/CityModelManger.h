//
//  CityModelManger.h
//  LoveQi
//
//  Created by tops on 2018/3/1.
//  Copyright © 2018年 李琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModelManger : NSObject

@property (nonatomic, copy) NSString *regionName;
@property (nonatomic, copy) NSString *regionId;

//城市按字母排序
+ (void)sorterFromArray:(NSArray *)array success:(void (^)(NSArray *entryWords, NSDictionary *sorterArray))success;

+ (void)saveAllCity:(NSArray *)citys;

+ (NSArray *)getAllCitys;

+ (void)saveAllSortCity:(NSDictionary *)sortCity;

+ (NSDictionary *)getAllSortCity;

@end

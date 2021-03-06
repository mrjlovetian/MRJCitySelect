//
//  CitySelectViewController.h
//  LoveQi
//
//  Created by tops on 2018/3/1.
//  Copyright © 2018年 余洪江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModelManger.h"

typedef void(^CitySelectBlock)(CityModelManger *city);

@protocol SelectCityListVCDelegate <NSObject>

- (void)selectCityDidResults:(CityModelManger *)city;

@end

@interface CitySelectViewController : UIViewController

@property (nonatomic, weak) id<SelectCityListVCDelegate> delegate;
@property (nonatomic, copy) CitySelectBlock cityBlock;

@property (nonatomic, copy) NSString *navTitle;
@property (nonatomic, strong) UIImage *backImage;

@end

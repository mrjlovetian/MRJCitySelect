//
//  CityHeadView.h
//  MRJCitySelect
//
//  Created by MRJ 余洪江 on 2018/3/3.
//

#import <UIKit/UIKit.h>

typedef void(^HeardViewHandle)(void);

@interface CityHeadView : UIView

@property (nonatomic, copy) HeardViewHandle handleBlock;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, assign) BOOL hideBackBtn;

@end

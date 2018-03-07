//
//  CityHeadView.h
//  MRJCitySelect
//
//  Created by MRJ on 2018/3/3.
//

#import <UIKit/UIKit.h>

typedef void(^HeardViewHandle)();

@interface CityHeadView : UIView

@property (nonatomic, copy)HeardViewHandle handleBlock;

@property (nonatomic, strong)UIButton *backBtn;

@property (nonatomic, copy)NSString *titleStr;

@property (nonatomic, assign)BOOL hideBackBtn;
@end

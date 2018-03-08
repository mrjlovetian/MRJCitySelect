//
//  CityHeadView.m
//  MRJCitySelect
//
//  Created by MRJ on 2018/3/3.
//

#import "CityHeadView.h"
#import "UIColor+MRJAdditions.h"

@interface CityHeadView()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) CALayer *bottomLine;

@end

@implementation CityHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.backBtn];
    [self addSubview:self.titleLab];
    [self.layer addSublayer:self.bottomLine];
}

- (void)goBack {
    if (self.handleBlock) {
        self.handleBlock();
    }
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, 50, 44);
        NSURL *boundleUrl = [[NSBundle bundleForClass:[CityHeadView class]] URLForResource:@"MRJCitySelect" withExtension:@"bundle"];
        NSBundle *citysBundle = [NSBundle bundleWithURL:boundleUrl];
        [_backBtn setImage:[UIImage imageNamed:[citysBundle pathForResource:@"city_bar_back_blue@2x" ofType:@"png"]] forState:UIControlStateNormal];
        _backBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(44, [[UIApplication sharedApplication] statusBarFrame].size.height, [UIScreen mainScreen].bounds.size.width - 88, 44)];
        _titleLab.font = [UIFont systemFontOfSize:18.0];
        _titleLab.textColor = [UIColor colorWithHexString:@"333333"];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (CALayer *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [CALayer layer];
        _bottomLine.frame = CGRectMake(0, self.frame.size.height - 0.5, [UIScreen mainScreen].bounds.size.width, 0.5);
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"].CGColor;
    }
    return _bottomLine;
}

#pragma mark SET

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLab.text = titleStr;
}

- (void)setHideBackBtn:(BOOL)hideBackBtn {
    _hideBackBtn = hideBackBtn;
    _backBtn.hidden = hideBackBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

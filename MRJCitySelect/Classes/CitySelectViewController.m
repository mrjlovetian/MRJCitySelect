//
//  CitySelectViewController.m
//  LoveQi
//
//  Created by tops on 2018/3/1.
//  Copyright © 2018年 李琦. All rights reserved.
//

#import "CitySelectViewController.h"
#import "CityHeadView.h"
#import "BATableView.h"
#import "MJExtension.h"
#import "UIColor+MRJAdditions.h"

#define MRJ_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define MRJ_SCREEN [[UIScreen mainScreen] bounds].size
#define MRJ_NavBAR_HEIGHT (MRJ_iPhoneX ? 88 : 64)//bar的高度

@interface CitySelectViewController ()<BATableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BATableView *contactTableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDisPlayCon;
@property (nonatomic, strong) NSDictionary *DataSource;
@property (nonatomic, strong) NSMutableArray *arrayKeys;
@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, strong) CityHeadView *headView;

@end

@implementation CitySelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getData];
}

- (void)initUI {
    [self.view addSubview:self.headView];
    [self.view addSubview:self.contactTableView];
    [self.view addSubview:self.searchBar];
    [self setSearchDisPlayCon:self.searchDisPlayCon];
    self.searchArray = [[NSMutableArray alloc] initWithCapacity:1];
    __weak typeof(self) weakSelf = self;
    self.headView.handleBlock = ^{
        [weakSelf goBack];
    };
}

- (void)getData {
    NSInteger version = [[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
    if ([CityModelManger getAllCitys].count == 0 || version > [[[NSUserDefaults standardUserDefaults] objectForKey:@"version"] integerValue]) {
        NSURL *boundleUrl = [[NSBundle bundleForClass:[CitySelectViewController class]] URLForResource:@"MRJCitySelect" withExtension:@"bundle"];
        NSBundle *citysBundle = [NSBundle bundleWithURL:boundleUrl];
        NSData *data = [[NSData alloc] initWithContentsOfFile:[citysBundle pathForResource:@"city" ofType:@"json"]];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSArray *arr = [CityModelManger mj_objectArrayWithKeyValuesArray:dic[@"Data"]];
        [CityModelManger sorterFromArray:arr success:^(NSArray *entryWords, NSDictionary *sorterArray) {
            [self reloadCity:entryWords sortArray:sorterArray];
        }];
    } else {
        [self reloadCity:[CityModelManger getAllCitys] sortArray:[CityModelManger getAllSortCity]];
    }
}

- (void)reloadCity:(NSArray *)entryWords sortArray:(NSDictionary *)sorterArray {
    _arrayKeys = [[NSMutableArray alloc]initWithObjects:nil];
    
    [_arrayKeys addObjectsFromArray:entryWords];
    self.DataSource = sorterArray;
    [self.contactTableView reloadData];
}

- (void)goBack {
    if(self.navigationController == nil){
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UISearchDisplayController delegate methods

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString {
    // 输入框变化
    ((UITableView *)controller.searchResultsTableView).separatorStyle = UITableViewCellSeparatorStyleNone;
    [self filterContentForSearchText:searchString scope:[self.searchDisplayController.searchBar                                       selectedScopeButtonIndex]];
    return YES;
}

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSInteger )scopeOption {
    [self.searchArray removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchText];
    for (NSArray *array in self.DataSource.allValues) {
        for (CityModelManger *city in array) {
            if ([resultPredicate evaluateWithObject:city.regionName]) {
                [self.searchArray addObject:city];
            }
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSArray *)sectionIndexTitlesForABELTableView:(BATableView *)tableView {
    return _arrayKeys;
}

- (NSString *)titleString:(NSInteger)section {
    return _arrayKeys[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    if ([tableView isEqual:_searchDisPlayCon.searchResultsTableView]) {
        return 0.1;
    }
    return 24;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([tableView isEqual:_searchDisPlayCon.searchResultsTableView]) {
        return nil;
    }
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MRJ_SCREEN.width, 24)];
    backView.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(15, 0, MRJ_SCREEN.width - 30, 24);
    [textLayer setFontSize:13];
    [textLayer setForegroundColor:[UIColor colorWithHexString:@"999999"].CGColor];
    [textLayer setString:[NSString stringWithFormat:@"%@",_arrayKeys[section]]];
    [backView.layer addSublayer:textLayer];
    return backView;
}

- (CGFloat)tableView:( UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([tableView isEqual:_searchDisPlayCon.searchResultsTableView]) {
        return 1;
    }
    return _arrayKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_searchDisPlayCon.searchResultsTableView]) {
        return self.searchArray.count;
    }
    NSArray *array = [self.DataSource objectForKey:_arrayKeys[section]];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"CityListTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.frame = CGRectMake(15, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width, cell.textLabel.frame.size.height);
    }
    if ([tableView isEqual:_searchDisPlayCon.searchResultsTableView]) {
        CityModelManger *city = self.searchArray[indexPath.row];
        cell.textLabel.text  = city.regionName;
    } else {
        cell.imageView.image = nil;
        NSArray *array = [self.DataSource objectForKey:_arrayKeys[indexPath.section]];
        CityModelManger *city = array[indexPath.row];
        cell.textLabel.text  = city.regionName;
        cell.userInteractionEnabled = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CityModelManger *city = nil;
    if ([tableView isEqual:_searchDisPlayCon.searchResultsTableView]) {
        city = self.searchArray[indexPath.row];
    } else{
        NSArray *array = [self.DataSource objectForKey:_arrayKeys[indexPath.section]];
        city = array[indexPath.row];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCityDidResults:)]) {
        [self.delegate selectCityDidResults:city];
        [self goBack];
    }
    
    if (self.cityBlock) {
        self.cityBlock(city);
        [self goBack];
    }
}

#pragma mark UI

- (CityHeadView *)headView {
    if (!_headView) {
        _headView = [[CityHeadView alloc] initWithFrame:CGRectMake(0, 0, MRJ_SCREEN.width, MRJ_NavBAR_HEIGHT)];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

- (BATableView *)contactTableView {
    if (!_contactTableView) {
        _contactTableView = [[BATableView alloc]initWithFrame:CGRectMake(0, MRJ_NavBAR_HEIGHT + 56 , MRJ_SCREEN.width, MRJ_SCREEN.height - MRJ_NavBAR_HEIGHT - 56)];
        _contactTableView.delegate = self;
        _contactTableView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _contactTableView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, MRJ_NavBAR_HEIGHT, MRJ_SCREEN.width, 28)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索城市";
        UIView *bgdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRJ_SCREEN.height, _searchBar.frame.size.height)];
        bgdView.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        bgdView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_searchBar insertSubview:bgdView atIndex:1];
        _searchBar.tintColor = [UIColor colorWithHexString:@"0091e8"];
        if (@available(iOS 11, *)) {
            UITextField *txfSearchField = [_searchBar valueForKey:@"_searchField"];
            [txfSearchField setDefaultTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.5]}];
        }
    }
    return _searchBar;
}

- (UISearchDisplayController *)searchDisPlayCon {
    if (!_searchDisPlayCon) {
        _searchDisPlayCon = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
        _searchDisPlayCon.delegate = self;
        _searchDisPlayCon.searchResultsDataSource = self;
        _searchDisPlayCon.searchResultsDelegate = self;
    }
    return _searchDisPlayCon;
}

#pragma mark Set

- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = [navTitle copy];
    self.headView.titleStr = navTitle;
}

- (void)setBackImage:(UIImage *)backImage {
    _backImage = backImage;
    [_headView.backBtn setImage:backImage forState:UIControlStateNormal];
}

@end

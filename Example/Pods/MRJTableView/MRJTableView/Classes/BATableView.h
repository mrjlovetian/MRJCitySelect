//
//  ABELTableView.h
//  ABELTableViewDemo
//
//  Created by abel on 14-4-28.
//  Copyright (c) 2014年 abel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BATableViewDelegate;

@interface BATableView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) id<BATableViewDelegate> delegate;

- (void)reloadData;
- (void)hideFlotage;

@end

@protocol BATableViewDelegate <UITableViewDataSource, UITableViewDelegate>

- (NSArray *)sectionIndexTitlesForABELTableView:(BATableView *)tableView;
- (NSString *)titleString:(NSInteger)section;

@end

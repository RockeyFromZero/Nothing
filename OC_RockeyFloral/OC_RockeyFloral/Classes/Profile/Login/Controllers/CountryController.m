//
//  CountryController.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/9.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "CountryController.h"

@interface CountryController ()

@property (nonatomic, copy) NSArray *countryList;

@end

@implementation CountryController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDatas];
    [self setupUI];
}

- (void)getDatas {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"country" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *keys = [[dic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 > obj2;
    }];
    
    _countryList = [[[keys rac_sequence] map:^id(id value) {
        return [CountryModel mj_objectWithKeyValues:@{@"key":value,@"value":dic[value]}];
    }] array];
}

- (void)setupUI {
    self.title = @"国家/地区";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [leftBtn setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.sectionIndexColor = [UIColor blackColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.countryList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((CountryModel *)self.countryList[section]).value.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CountryModel *model = ((CountryModel *)self.countryList[indexPath.section]);
    NSString *title = model.value[indexPath.row];
    
    NSArray *titleArray = [title componentsSeparatedByString:@"+"];
    cell.textLabel.text = titleArray.firstObject;
    
    NSString *rightTitle = titleArray[1];
    UIFont *rightTitleFont = [UIFont fontWithName:@"CODE LIGHT" size:14];
    CGFloat rightW = [rightTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:rightTitleFont} context:nil].size.width;
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rightW<100?rightW:100, 40)];
    rightLabel.text = rightTitle;
    rightLabel.font = rightTitleFont;
    cell.accessoryView = rightLabel;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ((CountryModel *)self.countryList[section]).key;
}

- (NSArray <NSString *>*)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[[self.countryList rac_sequence] map:^id(CountryModel *model) {
        return model.key;
    }] array];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocalDidSelected object:@(self.loginType) userInfo:@{@"key":((CountryModel *)self.countryList[indexPath.section]).value[indexPath.row]}];
    [self.navigationController popViewControllerAnimated:YES];
}

@end


@implementation CountryModel


@end




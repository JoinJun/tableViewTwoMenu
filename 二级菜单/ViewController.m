//
//  ViewController.m
//  二级菜单
//
//  Created by chenjun on 16/7/18.
//  Copyright © 2016年 cloudssky. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *cellArray;
@property (nonatomic, strong) NSMutableArray *stateArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    [self initWithData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init
- (void)initWithData {
    self.sectionArray = [NSMutableArray arrayWithArray:@[@"小学同学", @"初中同学", @"高中同学", @"大学同学"]];
    NSArray *array1 = @[@"王小明", @"陈小红", @"李狗蛋", @"王二小"];
    NSArray *array2 = @[@"钱眼", @"肚皮", @"红豆"];
    NSArray *array3 = @[@"学霸李", @"屌丝王", @"渣男赵", @"绿茶周"];
    NSArray *array4 = @[@"网游男", @"小说朕"];
    self.cellArray = [NSMutableArray arrayWithObjects:array1, array2, array3, array4, nil];
    self.stateArray = [NSMutableArray arrayWithObjects:@"0", @"0", @"0", @"0", nil];
}

#pragma mark - private methods
- (void)sectionClick:(UIButton *)sender {
    if ([self.stateArray[sender.tag - 10] intValue] == 1) {
        self.stateArray[sender.tag - 10] = @"0";
    } else {
        self.stateArray[sender.tag - 10] = @"1";
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag - 10] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.stateArray[section] intValue] == 1) {
        return [self.cellArray[section] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ide";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.cellArray[indexPath.section][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    headView.backgroundColor = [UIColor yellowColor];
    
    UIButton *sectionBtn = [[UIButton alloc] init];
    sectionBtn.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    [headView addSubview:sectionBtn];
    [sectionBtn setTitle:self.sectionArray[section] forState:UIControlStateNormal];
    [sectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sectionBtn addTarget:self action:@selector(sectionClick:) forControlEvents:UIControlEventTouchUpInside];
    sectionBtn.tag = section + 10;
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 43, self.view.frame.size.width, 1);
    line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [headView addSubview:line];
    
    return headView;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%@", self.cellArray[indexPath.section][indexPath.row]);
}

#pragma mark - getter and setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];//关键语句
    }
    return _tableView;
}

@end

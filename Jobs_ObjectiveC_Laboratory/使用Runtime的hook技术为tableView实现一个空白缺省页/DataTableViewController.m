//
//  DataTableViewController.m
//  Test
//
//  Created by Jobs on 22/10/2021.
//

#import "DataTableViewController.h"
#import "UITableView+ReloadData.h"

@interface DataTableViewController ()<UITableViewDataSource>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) UIButton       *haveDataBtn;
@property (nonatomic, strong) UIButton       *clearDataBtn;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation DataTableViewController

#pragma mark - life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavigation];
    [self setupSubviews];
}

-(void)setupNavigation{
    self.title = @"测试空白页";
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setupSubviews{
    [self.view addSubview:self.haveDataBtn];
    [self.view addSubview:self.clearDataBtn];
    [self.view addSubview:self.tableView];
}
#pragma mark - dataSource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuserIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
#pragma mark - event
-(void)haveDataBtnAction {
    self.dataSource = @[@"第1行数据",@"第2行数据",@"第3行数据",@"第4行数据",@"第5行数据",@"第6行数据"].mutableCopy;
    [self.tableView reloadData]; //内部调用自己的xyq_reloadData
}

-(void)clearDataBtnAction {
    [self.dataSource removeAllObjects];
    [self.tableView reloadData]; //内部调用自己的xyq_reloadData
}
#pragma mark - getters
-(UITableView *)tableView {
    if (!_tableView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+50, width, height-64-50)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataSource = self;
    }return _tableView;
}

-(UIButton *)haveDataBtn {
    if (!_haveDataBtn) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _haveDataBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10+64, width/2-20, 30)];
        _haveDataBtn.backgroundColor = [UIColor redColor];
        [_haveDataBtn setTitle:@"显示数据" forState:UIControlStateNormal];
        [_haveDataBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_haveDataBtn addTarget:self action:@selector(haveDataBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }return _haveDataBtn;
}

-(UIButton *)clearDataBtn {
    if (!_clearDataBtn) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _clearDataBtn = [[UIButton alloc] initWithFrame:CGRectMake(width/2+10, 10+64, width/2-20, 30)];
        _clearDataBtn.backgroundColor = [UIColor purpleColor];
        [_clearDataBtn setTitle:@"清空数据" forState:UIControlStateNormal];
        [_clearDataBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clearDataBtn addTarget:self action:@selector(clearDataBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }return _clearDataBtn;
}

@end

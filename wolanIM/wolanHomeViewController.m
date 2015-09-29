//
//  wolanHome.m
//  wolanIM
//
//  Created by yushaojun on 15/9/18.
//  Copyright (c) 2015年 wolan. All rights reserved.
//

#import <foundation/foundation.h>
#import "QuartzCore/QuartzCore.h"
#import "PullingRefreshTableView.h"
#import "DOPNavbarMenu.h"
#import "wolanHomeViewController.h"

@interface wolanHomeViewController()<PullingRefreshTableViewDelegate,DOPNavbarMenuDelegate>

@property (nonatomic,retain) PullingRefreshTableView *myTableView;
@property (nonatomic) BOOL refreshing;
//右上角按钮菜单相关
@property (assign, nonatomic) NSInteger numberOfItemsInRow;
@property (strong, nonatomic) DOPNavbarMenu *menu;

@end

@implementation wolanHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //以下代码放在initWithStype中不起作用 begin
    //研究根源
    
    CGRect bounds = self.view.bounds;
    _myTableView = [[PullingRefreshTableView alloc] initWithFrame:bounds pullingDelegate:self];
    //不能更改self.title否则就一并修改了tabcontrol的tab文本了
    self.navigationItem.title = @"附近的消息";
    
    self.tableView = _myTableView;//这里很重要，关联上就能显示TableView
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_background"]];
    
    //以下代码放在initWithStype中不起作用 end
    
    //Navagition Controll
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"..." style:UIBarButtonItemStylePlain target:self action:@selector(openMenu:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    _numberOfItemsInRow = 1;
    
    //添加数据
    cellDataArray = [[NSMutableArray alloc] init];
    
    wolanDataModel* datasource = [[wolanDataModel alloc]init];
    datasource.id = 1;
    datasource.age = 21;
    datasource.intro = @"一个人的周末很无聊，想要找个谈得来有风趣的男生，一起吃饭，看电影，如果太晚了就不回家个，你懂的！";
    datasource.height = 175;
    datasource.weight = 110;
    datasource.city_id = 1001001;
    datasource.work_id = 1;
    datasource.gender = YES;
    datasource.gender_verify = YES;
    [cellDataArray addObject:datasource];
    datasource.date = [[NSDate alloc]initWithTimeIntervalSinceNow:1000];
    
    datasource = [[wolanDataModel alloc]init];
    datasource.id = 2;
    datasource.age = 28;
    datasource.intro = @"有没有人愿意一起去看话剧的？文艺大叔有限，没有艺术细胞的就请绕道了，本人没有兴趣做免费讲解员，要是你觉得自己比较文艺，来试试看我的题目吧！对了，颜值太差的情自觉绕道！";
    datasource.height = 172;
    datasource.weight = 125;
    datasource.city_id = 1001002;
    datasource.work_id = 1;
    datasource.gender = YES;
    datasource.gender_verify = NO;
    datasource.date = [NSDate date];
    [cellDataArray addObject:datasource];
    
    datasource = [[wolanDataModel alloc]init];
    datasource.id = 3;
    datasource.age = 31;
    datasource.intro = @"一个人的周末很无聊，想要找个谈得来有风趣的男生，一起吃饭，看电影，如果太晚了就不回家个，你懂的！";
    datasource.height = 175;
    datasource.weight = 110;
    datasource.city_id = 1001003;
    datasource.work_id = 1;
    datasource.gender = NO;
    datasource.gender_verify = YES;
    [cellDataArray addObject:datasource];
    datasource.date = [[NSDate alloc]initWithTimeIntervalSinceNow:8000];
    
    [cellDataArray addObject:datasource];
}

//目前没看出这个的作用
//-(id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if(self)
//    {
//        self.tableView.rowHeight = 60.0f;
//        self.tableView.separatorColor = [UIColor whiteColor];
//    }
//    return self;
//}

//处理Load之后Frame的变动，在Load中进行frame的变动不一定起效
-(void)viewDidAppear:(BOOL)animated
{
    //_myTableView.backgroundColor = [UIColor clearColor];//执行一下背景变成黑的了
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData
{
    [self.myTableView tableViewDidFinishedLoading];
}

#pragma mark - PullingRefreshTableViewDelegate

-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    self.refreshing = YES;
    
    if([self respondsToSelector:@selector(loadData)])
    {
        [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//获取每个Section中的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

//返回Cell需要的高度
//TODO:要改成根据实际内容进行计算，确定高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //TODO:目前以空格来居中显示，后期优化
    return @"         提示 : 向下拖动可以刷新...";
}

-(void)InitControlStyle:(UITableViewCell*)cell
{
    UIButton* answer = (UIButton*)[cell viewWithTag:10008];
    if(answer)
    {
        [answer.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [answer.layer setCornerRadius:10];//设置圆角的幅度
        [answer.layer setBorderWidth:2];//设置边界的宽度
        
        //设置按钮的边界颜色
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGColorRef color = CGColorCreate(colorSpaceRef,(CGFloat[]){1,0,0,1});
        [answer.layer setBorderColor:color];
        answer.layer.borderColor = [[UIColor grayColor]CGColor];
    }
    
    UILabel* intro = (UILabel*)[cell viewWithTag:10000];
    if(intro)
    {
        //显示UILabel的边框
        intro.layer.borderWidth = 1;
        intro.layer.borderColor = [[UIColor grayColor]CGColor];
    }
    
    UILabel* date = (UILabel*)[cell viewWithTag:10007];
    if(date)
    {
        date.textColor = [UIColor grayColor];
    }
}

- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:0.3f];
}

-(void)InitWithDataModel:(wolanDataModel*)datasource cell:(UITableViewCell*)cell
{
    UILabel* intro = (UILabel*)[cell viewWithTag:10000];
    if(intro)
    {
        intro.text = datasource.intro;
        intro.numberOfLines = 3;//最大三行
        intro.lineBreakMode = NSLineBreakByWordWrapping;
        intro.backgroundColor = [self randomColor];
    }
    
    UILabel* gender = (UILabel*)[cell viewWithTag:10001];
    if(gender)
    {
        gender.text = [NSString stringWithFormat:@"性别 : %@%@",datasource.gender?@"男":@"女",datasource.gender_verify?@" [已认证]":@""];
    }
    
    UILabel* height = (UILabel*)[cell viewWithTag:10002];
    if(height)
    {
        height.text = [NSString stringWithFormat:@"身高 : %hi",datasource.height];
    }
    
    //根据city_id获取城市
    UILabel* city = (UILabel*)[cell viewWithTag:10003];
    if(city)
    {
        city.text = [NSString stringWithFormat:@"城市 : %hi",datasource.city_id];
    }
    
    UILabel* age = (UILabel*)[cell viewWithTag:10004];
    if(age)
    {
        age.text = [NSString stringWithFormat:@"年龄 : %hi",datasource.age];
    }
    
    UILabel* weight = (UILabel*)[cell viewWithTag:10005];
    if(weight)
    {
        weight.text = [NSString stringWithFormat:@"体重 : %hi",datasource.weight];
    }
    
    //根据work_id获取工作描述
    UILabel* work = (UILabel*)[cell viewWithTag:10006];
    if(work)
    {
        work.text = [NSString stringWithFormat:@"职业 : %hi",datasource.work_id];
    }
    
    UILabel* lastLogin = (UILabel*)[cell viewWithTag:10007];
    if(lastLogin)
    {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd HH:mm";
        lastLogin.text = [NSString stringWithFormat:@"最后上线时间 : %@",[df stringFromDate:datasource.date]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //强化Section概念,故意啰嗦
    NSUInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    static NSString *cellIdentifier = @"cell_Q";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"homeCell" owner:self options:nil];
        cell = (UITableViewCell*)[array objectAtIndex:0];
    }
    //cell.frame = CGRectMake(0, 0, _myTableView.frame.size.width, _TableView_Q.frame.size.height);
    [self InitControlStyle:cell];
    
    //获取数据行并进行初始化
    wolanDataModel* datasource = [cellDataArray objectAtIndex:row];
    [self InitWithDataModel:datasource cell:cell];
    
    return cell;
}

//预测高度，可以提升Cell的显示性能,延迟世纪滚动时间成本的大部分
//不知道具体高度，暂返回UITableViewAutomaticDimension
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

#pragma mark -navagition item

- (DOPNavbarMenu *)menu {
    if (_menu == nil) {
        DOPNavbarMenuItem *man = [DOPNavbarMenuItem ItemWithTitle:@"只看男生" icon:[UIImage imageNamed:@"man"]];
        DOPNavbarMenuItem *woman = [DOPNavbarMenuItem ItemWithTitle:@"只看女生" icon:[UIImage imageNamed:@"woman"]];
        DOPNavbarMenuItem *all = [DOPNavbarMenuItem ItemWithTitle:@"显示全部" icon:[UIImage imageNamed:@"all"]];
        _menu = [[DOPNavbarMenu alloc] initWithItems:@[man,woman,all] width:self.view.dop_width maximumNumberInRow:_numberOfItemsInRow];
        _menu.backgroundColor = [UIColor blackColor];
        _menu.separatarColor = [UIColor whiteColor];
        _menu.delegate = self;
    }
    return _menu;
}

- (void)didShowMenu:(DOPNavbarMenu *)menu {
    [self.navigationItem.rightBarButtonItem setTitle:@"..."];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)didDismissMenu:(DOPNavbarMenu *)menu {
    [self.navigationItem.rightBarButtonItem setTitle:@"..."];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)didSelectedMenu:(DOPNavbarMenu *)menu atIndex:(NSInteger)index {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"you selected" message:[NSString stringWithFormat:@"number %@", @(index+1)] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [av show];
}


- (void)openMenu:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    if (self.menu.isOpen) {
        [self.menu dismissWithAnimation:YES];
    } else {
        [self.menu showInNavigationController:self.navigationController];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

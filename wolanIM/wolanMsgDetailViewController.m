//
//  wolanMessage.m
//  wolanIM
//
//  Created by yushaojun on 15/9/18.
//  Copyright (c) 2015年 wolan. All rights reserved.
//

#import "wolanMsgDetailViewController.h"


@implementation wolanMsgDetailViewController

@synthesize myTitle = _myTitle;
@synthesize numMsg = _numMsg;
@synthesize typeMsg = _typeMsg;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cellDataArray = [[NSMutableArray alloc]init];
    switch (_typeMsg) {
        case wolanMsgTypeRec://收件箱
            {
                _numMsg = 2;
                
                wolanDataModel_Msg_Rec* cell1 = [[wolanDataModel_Msg_Rec alloc]init];
                cell1.id = 1;
                cell1.name = @"雨枫";
                cell1.image = @"20150929201141144";
                cell1.content = @"收这位美女你好，很幸运通过了你的考试，我相信我们有很多共同点，可以和你交个朋友吗？我的微信是12345，QQ号67784，期待你的回音！";
                cell1.score = 80;
                cell1.credit = 255;
                cell1.numComment = 3;
                cell1.date = [NSDate date];
                [cellDataArray addObject:cell1];
                
                cell1 = [[wolanDataModel_Msg_Rec alloc]init];
                cell1.id = 2;
                cell1.name = @"路人甲";
                cell1.image = nil;
                cell1.content = @"收这位美女你好，很幸运通过了你的考试，我相信我们有很多共同点，可以和你交个朋友吗？我的微信是12345，QQ号67784，期待你的回音！";
                cell1.score = 60;
                cell1.credit = 250;
                cell1.numComment = 1;
                cell1.date = [[NSDate alloc] initWithTimeIntervalSinceNow:8000];
                [cellDataArray addObject:cell1];
            }
            break;
        case wolanMsgTypeSnd://发件箱
            {
                _numMsg = 4;
                
                wolanDataModel_Msg_Snd* cell1 = [[wolanDataModel_Msg_Snd alloc]init];
                cell1.id = 1;
                cell1.name = @"李丹丹";
                cell1.isRead = YES;
                cell1.content = @"这位美女你好，很幸运通过了你的考试，我相信我们有很多共同点，可以和你交个朋友吗？我的微信是12345，QQ号67784，期待你的回音！";
                cell1.date = [NSDate date];
                [cellDataArray addObject:cell1];
                
                cell1 = [[wolanDataModel_Msg_Snd alloc]init];
                cell1.id = 2;
                cell1.name = @"李丹丹";
                cell1.isRead = YES;
                cell1.content = @"这位美女你好，很幸运通过了你的考试，我相信我们有很多共同点，可以和你交个朋友吗？我的微信是12345，QQ号67784，期待你的回音！";
                cell1.date = [[NSDate alloc]initWithTimeIntervalSinceNow:80000];
                [cellDataArray addObject:cell1];
                
                cell1 = [[wolanDataModel_Msg_Snd alloc]init];
                cell1.id = 3;
                cell1.name = @"李丹丹";
                cell1.isRead = NO;
                cell1.content = @"这位美女你好，很幸运通过了你的考试，我相信我们有很多共同点，可以和你交个朋友吗？我的微信是12345，QQ号67784，期待你的回音！";
                cell1.date = [[NSDate alloc]initWithTimeIntervalSinceNow:5000];
                [cellDataArray addObject:cell1];
                
                cell1 = [[wolanDataModel_Msg_Snd alloc]init];
                cell1.id = 4;
                cell1.name = @"李丹丹";
                cell1.isRead = NO;
                cell1.content = @"这位美女你好，很幸运通过了你的考试，我相信我们有很多共同点，可以和你交个朋友吗？我的微信是12345，QQ号67784，期待你的回音！";
                cell1.date = [[NSDate alloc]initWithTimeIntervalSinceNow:7000];
                [cellDataArray addObject:cell1];
            }
            break;
        default://草稿箱
            {
                _numMsg = 0;
            }
            break;
    }
    
    CGRect bounds = self.view.bounds;
    _myTableView = [[UITableView alloc] initWithFrame:bounds style:UITableViewStylePlain];
    self.navigationItem.title = _myTitle;//不能更改self.title否则就一并修改了tabcontrol的tab文本了
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"自定义返回按钮";
    
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    //[self.navigationItem.backBarButtonItem setTitle:@"<-"];
    
    self.tableView = _myTableView;//这里很重要，关联上就能显示TableView
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_background"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:0.3f];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//获取每个Section中的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _numMsg;
}

//返回Cell需要的高度
//TODO:要改成根据实际内容进行计算，确定高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_typeMsg) {
        case wolanMsgTypeRec:
            return 200;
        case wolanMsgTypeSnd:
            return 145;
        default:
            return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(void)InitWithDataModel_Snd:(wolanDataModel_Msg_Snd*)datasource cell:(UITableViewCell*)cell
{
    //收件人 : 雨枫      发送时间 : 2015-8-30
    UILabel* labSnd = (UILabel*)[cell viewWithTag:10001];
    if(labSnd)
    {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd HH:mm";
        NSString* date = [NSString stringWithFormat:@"发送时间 : %@",[df stringFromDate:datasource.date]];

        NSString* content = [NSString stringWithFormat:@"收件人 : %@      %@",datasource.name,date];
        labSnd.text = content;
    }
    
    UILabel* labContent = (UILabel*)[cell viewWithTag:10003];
    if(labContent)
    {
        labContent.text = datasource.content;
        labContent.numberOfLines = 3;//最大三行
        labContent.lineBreakMode = NSLineBreakByWordWrapping;
        labContent.backgroundColor = [self randomColor];
    }
}

-(void)InitWithDataModel_Rec:(wolanDataModel_Msg_Rec*)datasource cell:(UITableViewCell*)cell
{
    //发件人 : 雨枫      发送时间 : 2015-8-30 [有照片]
    UILabel* labSnd = (UILabel*)[cell viewWithTag:10000];
    if(labSnd)
    {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd HH:mm";
        NSString* date = [NSString stringWithFormat:@"发送时间 : %@",[df stringFromDate:datasource.date]];
        
        NSString* havePhoto = [NSString stringWithFormat:@"%@",datasource.image?@"[有照片]":@""];
        NSString* sendContent = [NSString stringWithFormat:@"发件人 : %@      %@ %@",datasource.name,date,havePhoto];
        labSnd.text = sendContent;
    }
    
    if(datasource.image)
    {
        UIImageView* photo = (UIImageView*)[cell viewWithTag:10001];
        if(photo)
        {
            photo.image = [UIImage imageNamed:datasource.image];
        }
    }
    
    UILabel* labContent = (UILabel*)[cell viewWithTag:10002];
    if(labContent)
    {
        labContent.text = datasource.content;
        labContent.numberOfLines = 3;//最大三行
        labContent.lineBreakMode = NSLineBreakByWordWrapping;
        labContent.backgroundColor = [self randomColor];
    }
    
    UILabel* score = (UILabel*)[cell viewWithTag:10003];
    if(score)
    {
        score.text = [NSString stringWithFormat:@"测试成绩 : %hi",datasource.score];
    }
    
    UILabel* credit = (UILabel*)[cell viewWithTag:10005];
    if(credit)
    {
        credit.text = [NSString stringWithFormat:@"信用等级 : %hi %hi条点评",datasource.credit,datasource.numComment];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //强化Section概念,故意啰嗦
    NSUInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    UITableViewCell *cell = nil;
    
    switch (_typeMsg) {
        case wolanMsgTypeRec://收件箱
            {
                static NSString *cellIdentifier = @"cell_Msg_Rec";
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if(cell == nil)
                {
                    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"msgDetailCell_Rec" owner:self options:nil];
                    cell = (UITableViewCell*)[array objectAtIndex:0];
                }
                
                //获取数据行并进行初始化
                wolanDataModel_Msg_Rec* datasource = [cellDataArray objectAtIndex:row];
                if(datasource!=nil)
                {
                    [self InitWithDataModel_Rec:datasource cell:cell];
                }
            }
            break;
        case wolanMsgTypeSnd://发件箱
            {
                static NSString *cellIdentifier = @"cell_Msg_Snd";
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if(cell == nil)
                {
                    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"msgDetailCell_Snd" owner:self options:nil];
                    cell = (UITableViewCell*)[array objectAtIndex:0];
                }
                                      
                //获取数据行并进行初始化
                wolanDataModel_Msg_Snd* datasource = [cellDataArray objectAtIndex:row];
                if(datasource!=nil)
                {
                    [self InitWithDataModel_Snd:datasource cell:cell];
                }
            }
            break;
        default://草稿箱
            {

            }
            break;
    }
    
    return cell;
}

//预测高度，可以提升Cell的显示性能,延迟世纪滚动时间成本的大部分
//不知道具体高度，暂返回UITableViewAutomaticDimension
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)refresh
{
    [self.myTableView reloadData];
}

#pragma mark --buton

- (void)buttonTapped:(UIButton *)button
{
    [self didSelectedMenu:button.tag];
}

- (void)didSelectedMenu:(NSInteger)index
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"you selected" message:[NSString stringWithFormat:@"number %@", @(index+1)] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [av show];
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

//
//  wolanMy.m
//  wolanIM
//
//  Created by yushaojun on 15/9/18.
//  Copyright (c) 2015年 wolan. All rights reserved.
//

#import "wolanMyInfoViewController.h"

@interface wolanMyInfoViewController()

@property (nonatomic,retain) UITableView* myTableView;

@end

@implementation wolanMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect bounds = self.view.bounds;
    _myTableView = [[UITableView alloc] initWithFrame:bounds style:UITableViewStylePlain];
    self.navigationItem.title = @"我的";//不能更改self.title否则就一并修改了tabcontrol的tab文本了
    
    self.tableView = _myTableView;//这里很重要，关联上就能显示TableView
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_background"]];
    
    cellDataArray = [[NSMutableArray alloc]init];
    wolanDataModel_MyInfo* cell = [[wolanDataModel_MyInfo alloc]init];
    cell.id = 1;
    cell.type = wolanMyInfoCellTypeComplex;
    cell.myTitle = @"李丹丹";
    cell.image = @"2015092811251114211.jpg";
    cell.numAnswer = 245;
    cell.numAnswerPass = 2;
    cell.numAnswer_History = 1533;
    cell.numAnswerPass_History = 12;
    cell.isVerify = YES;
    cell.isVIP = YES;
    [cellDataArray addObject:cell];
    
    cell = [[wolanDataModel_MyInfo alloc]init];
    cell.id = 2;
    cell.type = wolanMyInfoCellTypeSimple;
    cell.numQuestion = 2;
    cell.image = @"MyInfo_Question_32";
    NSString* myTitle = [NSString stringWithFormat:@"我的考题    共%hi套",cell.numQuestion];
    cell.myTitle = myTitle;
    [cellDataArray addObject:cell];
    
    cell = [[wolanDataModel_MyInfo alloc]init];
    cell.id = 3;
    cell.type = wolanMyInfoCellTypeSimple;
    cell.numAnswerPass = 12;
    cell.image = @"MyInfo_Answer_32";
    myTitle = [NSString stringWithFormat:@"我的答卷    及格%hi张",cell.numAnswerPass];
    cell.myTitle = myTitle;
    [cellDataArray addObject:cell];

    cell = [[wolanDataModel_MyInfo alloc]init];
    cell.id = 4;
    cell.type = wolanMyInfoCellTypeSimple;
    cell.myTitle = @"软件设置";
    cell.image = @"MyInfo_Settings_32";
    [cellDataArray addObject:cell];
    
    cell = [[wolanDataModel_MyInfo alloc]init];
    cell.id = 5;
    cell.type = wolanMyInfoCellTypeSimple;
    cell.myTitle = @"身份认证";
    cell.image = @"MyInfo_Verify_32";
    [cellDataArray addObject:cell];
    
    cell = [[wolanDataModel_MyInfo alloc]init];
    cell.id = 6;
    cell.type = wolanMyInfoCellTypeSimple;
    cell.myTitle = @"照片管理";
    cell.image = @"MyInfo_Photo_32";
    [cellDataArray addObject:cell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//获取每个Section中的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

//返回Cell需要的高度
//TODO:要改成根据实际内容进行计算，确定高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if(row==0)
    {
        return 153;
    }
    else
    {
        return 58;
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

-(void)InitWithDataModel:(wolanDataModel_MyInfo*)datasource cell:(UITableViewCell*)cell
{
    switch (datasource.type) {
        case wolanMyInfoCellTypeComplex:
        {
            UIImageView* image = (UIImageView*)[cell viewWithTag:10003 ];
            if(image)
            {
                //image.image = [UIImage imageNamed:datasource.image];
                image.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@",datasource.image]];
            }
            
            UILabel* labName = (UILabel*)[cell viewWithTag:10004];
            if(labName)
            {
                NSString* isVerify = datasource.isVerify?@"[已认证]":@"";
                NSString* isVip = datasource.isVIP?@"[VIP会员]":@"";
                labName.text = [NSString stringWithFormat:@"%@  %@%@",datasource.myTitle,isVip,isVerify];
            }
            
            UILabel* labToday = (UILabel*)[cell viewWithTag:10005];
            if(labToday)
            {
                float passPercent = (float)datasource.numAnswerPass/(float)datasource.numAnswer*100.0;
                labToday.text = [NSString stringWithFormat:@"今日参与%hi人 及格%hi人 及格率%.2f%%",datasource.numAnswer,datasource.numAnswerPass,passPercent];
            }
            
            UILabel* labHistory = (UILabel*)[cell viewWithTag:10006];
            if(labHistory)
            {
                float passPercent = (float)datasource.numAnswerPass_History/(float)datasource.numAnswer_History * 100.0;
                labHistory.text = [NSString stringWithFormat:@"及格/参与 : %hi/%hi    历史及格率%.2f%%",datasource.numAnswerPass_History,datasource.numAnswer_History,passPercent];
            }

        }
            break;
        default:
        {
            UIImageView* background = (UIImageView*)[cell viewWithTag:10000 ];
            if(background)
            {
                //TODO:参数都是手动调节，有更优化的方案时一定进行优化
                UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:datasource.image]];
                if(icon)
                {
                    CGFloat imgHeight = background.bounds.size.height;
                    CGFloat imgWidth = background.bounds.size.width;
                    CGFloat imgX = background.frame.origin.x+icon.frame.size.height;
                    CGFloat imgY = background.frame.origin.y + imgHeight/2;
                    icon.center = CGPointMake(imgX,imgY);
                    icon.tag = 10003;
                    [cell addSubview:icon];
                    
                    CGFloat labX = imgX + icon.bounds.size.width/1.3;
                    CGFloat labY = icon.frame.origin.y;
                    CGFloat labWidth = imgWidth-icon.frame.size.width;
                    CGFloat labHeight = imgHeight-icon.frame.size.height/2;
                    
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labX,labY,labWidth, labHeight)];
                    if(label)
                    {
                        label.text = datasource.myTitle;
                        label.textAlignment = NSTextAlignmentLeft;
                        label.font = [UIFont boldSystemFontOfSize:14];
                        label.textColor = [UIColor blackColor];
                        label.tag = 10004;
                        [cell addSubview:label];
                    }
                }
            }
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    //强化Section概念,故意啰嗦
    NSUInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    UITableViewCell *cell = nil;
    
    //获取数据行并进行初始化
    wolanDataModel_MyInfo* datasource = [cellDataArray objectAtIndex:row];
    if(datasource!=nil)
    {
        static NSString *cellIdentifier = @"cell_MyInfo";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            NSArray* array = nil;
            if(datasource.type==wolanMyInfoCellTypeComplex)
            {
                array = [[NSBundle mainBundle] loadNibNamed:@"myInfoComplexCell" owner:self options:nil];
            }
            else
            {
                array = [[NSBundle mainBundle] loadNibNamed:@"myInfoCommonCell" owner:self options:nil];
            }
            cell = (UITableViewCell*)[array objectAtIndex:0];
        }
        
        [self InitWithDataModel:datasource cell:cell];
    }

    return cell;
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

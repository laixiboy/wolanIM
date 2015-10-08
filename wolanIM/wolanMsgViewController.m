//
//  wolanMessage.m
//  wolanIM
//
//  Created by yushaojun on 15/9/18.
//  Copyright (c) 2015年 wolan. All rights reserved.
//

#import "wolanMsgDetailViewController.h"
#import "wolanMsgViewController.h"

@interface wolanMsgViewController ()

@property (nonatomic,retain) UITableView* myTableView;
@property (assign, nonatomic) NSInteger numOfReceive;

@end

@implementation wolanMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _numOfReceive = 12;
    CGRect bounds = self.view.bounds;
    _myTableView = [[UITableView alloc] initWithFrame:bounds style:UITableViewStylePlain];
    
    NSString* title = [[NSString alloc]initWithFormat:@"消息 ( %ld )",(long)_numOfReceive];
    self.navigationItem.title = title;//不能更改self.title否则就一并修改了tabcontrol的tab文本了
    
    self.tableView = _myTableView;//这里很重要，关联上就能显示TableView
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_background"]];
    
    wolanDataModel_Msg* cell1 = [[wolanDataModel_Msg alloc]init];
    cell1.id = 1;
    cell1.value = 12;
    cell1.image = @"Msg_Receive_32";
    cell1.title = @"收件箱";
    
    wolanDataModel_Msg* cell2 = [[wolanDataModel_Msg alloc]init];
    cell2.id = 2;
    cell2.value = 3;
    cell2.image = @"Msg_Send_32";
    cell2.title = @"发件箱";
    
    wolanDataModel_Msg* cell3 = [[wolanDataModel_Msg alloc]init];
    cell3.id = 3;
    cell3.value = 0;
    cell3.image = @"MyInfo_Answer_32";
    cell3.title = @"草稿箱";
    
    cellDataArray = [[NSArray alloc] initWithObjects:cell1,cell2,cell3, nil];
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
    
    return 3;
}

//返回Cell需要的高度
//TODO:要改成根据实际内容进行计算，确定高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(void)InitWithDataModel:(wolanDataModel_Msg*)datasource cell:(UITableViewCell*)cell
{
    //TODO:临时用tag存储消息数量，后期有更好的方案，则进行优化
    cell.tag = datasource.value;
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
            CGFloat labY = icon.frame.origin.y;// + icon.frame.size.height/4;
            CGFloat labWidth = imgWidth-icon.frame.size.width;
            CGFloat labHeight = imgHeight-icon.frame.size.height/2;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labX,labY,labWidth, labHeight)];
            if(label)
            {
                NSString* title = [NSString stringWithFormat:@"%@ ( %d )",datasource.title,datasource.value];
                label.text = title;
                label.textAlignment = NSTextAlignmentLeft;
                label.font = [UIFont boldSystemFontOfSize:14];
                label.textColor = [UIColor blackColor];
                label.tag = 10004;
                [cell addSubview:label];
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //强化Section概念,故意啰嗦
    NSUInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    static NSString *cellIdentifier = @"cell_Msg";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"msgCell" owner:self options:nil];
        cell = (UITableViewCell*)[array objectAtIndex:0];
    }
    
    //获取数据行并进行初始化
    wolanDataModel_Msg* datasource = [cellDataArray objectAtIndex:row];
    if(datasource!=nil)
    {
        [self InitWithDataModel:datasource cell:cell];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    wolanMsgDetailViewController *vc = [[wolanMsgDetailViewController alloc] init];
    if(vc)
    {
        switch(indexPath.row)
        {
            case 0:
                vc.typeMsg = wolanMsgTypeRec;
                break;
            case 1:
                vc.typeMsg = wolanMsgTypeSnd;
                break;
            default:
                vc.typeMsg = wolanMsgTypeDraft;
                break;
        }
        
        UITableViewCell* cell = [_myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
        if(cell)
        {
            vc.numMsg = cell.tag;
            
            UILabel* labMsg = (UILabel*)[cell viewWithTag:10004];
            if(labMsg)
            {
                vc.myTitle = labMsg.text;
            }
        }
        else
        {
            NSLog(@"wolanMsgViewController didSelectRowAtIndexPath cell=nil %ld,%ld",(long)indexPath.row,(long)indexPath.section);
        }
    }
    [self.navigationController pushViewController:vc animated:YES];
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

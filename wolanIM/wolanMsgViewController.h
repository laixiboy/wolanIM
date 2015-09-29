//
// @brief: “消息”
// @author:wolan
//

#import <UIKit/UIKit.h>
#import "wolanDataModel_Msg.h"

@interface wolanMsgViewController : UITableViewController
{
    //保存DataModel列表
    NSArray* cellDataArray;
}

//设置数据进行显示
-(void)InitWithDataModel:(wolanDataModel_Msg*)datasource cell:(UITableViewCell*)cell;

@end

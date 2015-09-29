//
// @brief: “主页”
// @author:wolan
//

#import <UIKit/UIKit.h>
#import "TTUITableViewZoomController.h"
#import "wolanDataModel.h"

@interface wolanHomeViewController : TTUITableViewZoomController
{
    //保存DataModel列表
    NSMutableArray* cellDataArray;
}

//设置数据进行显示
-(void)InitWithDataModel:(wolanDataModel*)datasource cell:(UITableViewCell*)cell;
//设置控件样式
-(void)InitControlStyle:(UITableViewCell*)cell;

@end
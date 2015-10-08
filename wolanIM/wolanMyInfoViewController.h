//
// @brief: “我的”
// @author:wolan
//

#import <UIKit/UIKit.h>
#import "wolanDataModel_MyInfo.h"

typedef NS_ENUM(NSInteger,wolanMyInfoCellType){
    wolanMyInfoCellTypeComplex = 1,//复杂的我的信息界面
    wolanMyInfoCellTypeSimple,//纯标题界面
};

@interface wolanMyInfoViewController : UITableViewController
{
    //保存DataModel列表
    NSMutableArray* cellDataArray;
}

//设置数据进行显示
-(void)InitWithDataModel:(wolanDataModel_MyInfo*)datasource cell:(UITableViewCell*)cell;

@end

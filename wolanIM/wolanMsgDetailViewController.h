//
// @brief: “消息”
// @author:wolan
//

#import <UIKit/UIKit.h>
#import "wolanDataModel_Msg_Snd.h"
#import "wolanDataModel_Msg_Rec.h"

//定义信息的类型
typedef NS_ENUM(NSInteger,wolanMsgType){
    wolanMsgTypeRec = 1,
    wolanMsgTypeSnd,
    wolanMsgTypeDraft,
};

@interface wolanMsgDetailViewController : UITableViewController
{
    //保存DataModel列表
    NSMutableArray* cellDataArray;
}

@property (nonatomic,retain) UITableView* myTableView;
@property (assign,nonatomic) NSInteger numMsg;
@property (nonatomic,assign) wolanMsgType typeMsg;
@property (nonatomic,copy) NSString* myTitle;

//设置数据进行显示
-(void)InitWithDataModel_Rec:(wolanDataModel_Msg_Rec*)datasource cell:(UITableViewCell*)cell;
-(void)InitWithDataModel_Snd:(wolanDataModel_Msg_Snd*)datasource cell:(UITableViewCell*)cell;

@end

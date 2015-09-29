//
// @brief:登陆UI
// @author:wolan
//

#import <UIKit/UIKit.h>

@interface wolanLogin : UIViewController

@property (nonatomic,retain)IBOutlet UIButton *btn_Login;
@property (nonatomic,retain)IBOutlet UIButton *btn_Register;
@property (nonatomic,retain)IBOutlet UITextField *txt_User;
@property (nonatomic,retain)IBOutlet UITextField *txt_Pwd;

//登陆按钮点击
-(IBAction)login_clicked:(id)sender;
//背景点击
-(IBAction)background_clicked:(id)sender;
//帐号输入完成
-(IBAction)uidDidEndOnExit_clicked:(id)sender;
//密码输入完成
-(IBAction)pwdDidEndOnExit_clicked:(id)sender;
//注册点击
-(IBAction)register_clicked:(id)sender;
//登陆成功后切dao主界面
-(void)initNavigate:(NSString*)pid;

@end

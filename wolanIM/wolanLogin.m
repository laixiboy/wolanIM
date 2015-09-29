//
// @func:登陆UI
// @author:wolan
//

#import "wolanAppDelegate.h"
#import "wolanHomeViewController.h"
#import "wolanMsgViewController.h"
#import "wolanLogin.h"

@implementation wolanLogin


@synthesize btn_Login = _btn_Login;
@synthesize btn_Register = _btn_Register;
@synthesize txt_User = _txt_User;
@synthesize txt_Pwd = _txt_Pwd;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //UITabBarItem* item = self.tabBarItem;
    //[item setImage:[UIImage imageNamed:@"replies.png"]];
    //[item setTitle:@"我的"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//登陆按钮点击
-(IBAction)login_clicked:(id)sender
{
    [self initNavigate:@"Test Login Success"];
}

//背景点击
-(IBAction)background_clicked:(id)sender
{
    //点击背景，隐藏输入框
    [_txt_Pwd resignFirstResponder];
    [_txt_User resignFirstResponder];
}

//帐号输入完成
-(IBAction)uidDidEndOnExit_clicked:(id)sender
{
     [_txt_Pwd becomeFirstResponder];
}

//密码输入完成
-(IBAction)pwdDidEndOnExit_clicked:(id)sender
{
    //点击go的时候，相当于点击了登陆按钮
    [self login_clicked:sender];
}

//注册点击
-(IBAction)register_clicked:(id)sender
{
    
}

//登陆成功后切dao主界面
-(void)initNavigate:(NSString*)pid
{
    }

@end

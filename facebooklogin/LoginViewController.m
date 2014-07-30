//
//  LoginViewControler.m
//  facebooklogin
//
//  Created by Gwen Brinsmead on 6/17/14.
//  Copyright (c) 2014 Gwen Brinsmead. All rights reserved.
//

#import "LoginViewController.h"
#import "MoreViewController.h"
#import "FeedViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIView *loginForms;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *signupLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)login:(id)sender;
- (IBAction)onTap:(id)sender;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;
- (void)loginSuccess;
- (void)checkPassword;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.signupLabel.frame = CGRectMake(76, self.view.frame.size.height - kbSize.height - self.signupLabel.frame.size.height - 20, self.signupLabel.frame.size.width, self.signupLabel.frame.size.height);
                     }
                     completion:nil];
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.loginForms.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.loginForms.frame.size.height - 50, self.loginForms.frame.size.width, self.loginForms.frame.size.height);
                     }
                     completion:nil];

    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.logo.frame = CGRectMake(73, self.view.frame.size.height - kbSize.height - self.logo.frame.size.height - 250, self.logo.frame.size.width, self.logo.frame.size.height);
                     }
                     completion:nil];
    
}

- (void)willHideKeyboard:(NSNotification *)notification {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    
    NSString *emailText = self.emailField.text;
    NSString *passwordText = self.passwordField.text;
    
    if ([emailText isEqualToString:@""] && [passwordText isEqualToString:@""]) {
        NSLog(@"empty fields");
    } else {
        NSLog(@"checking password...");
        [self.activityIndicator startAnimating];
        [self.loginButton setSelected:YES];
        [self performSelector:@selector(checkPassword) withObject:nil afterDelay:2];
    }
    

}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:(YES)];
}

- (void)checkPassword {

    NSString *passwordText = self.passwordField.text;
    
    if ([passwordText isEqualToString:@"password"]) {
        NSLog(@"verified password");
        [self performSelector:@selector(loginSuccess) withObject:nil afterDelay:0];
    } else {
        NSLog(@"else");
        [self.activityIndicator stopAnimating];
        [self.loginButton setSelected:NO];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wrong Password" message:@"Try Again!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)loginSuccess {
    NSLog(@"login succeeded");
   
    FeedViewController *feedViewController = [[FeedViewController alloc] init];
    UINavigationController *feedNavigationController = [[UINavigationController alloc] initWithRootViewController:feedViewController];
    feedNavigationController.tabBarItem.title = @"First";
    feedNavigationController.tabBarItem.image = [UIImage imageNamed:@"House"];
    feedNavigationController.navigationBar.translucent = NO;
    
    MoreViewController *moreViewController = [[MoreViewController alloc] init];
    UINavigationController *moreNavigationController = [[UINavigationController alloc] initWithRootViewController:moreViewController];
    moreNavigationController.tabBarItem.title = @"First";
    moreNavigationController.tabBarItem.image = [UIImage imageNamed:@"House"];
    moreNavigationController.navigationBar.translucent = NO;
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[feedNavigationController, moreNavigationController];
    
    tabBarController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:tabBarController animated:YES completion:nil];
    
}



@end

//
//  FeedViewController.m
//  facebooklogin
//
//  Created by Gwen Brinsmead on 6/17/14.
//  Copyright (c) 2014 Gwen Brinsmead. All rights reserved.
//

#import "FeedViewController.h"
#import "LoginViewController.h"

@interface FeedViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *feedView;
@property (weak, nonatomic) IBOutlet UIButton *actionBar;

- (void)loadContent;


@end

@implementation FeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Feed";
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *leftButtonImage = [[UIImage imageNamed:@"search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    // Configure the right button
    UIImage *rightButtonImage = [[UIImage imageNamed:@"messages"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:rightButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    [self.activityIndicator startAnimating];
    [self performSelector:@selector(loadContent) withObject:nil afterDelay:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadContent {
    NSLog(@"load content");
    [self.activityIndicator stopAnimating];
    self.scrollView.hidden = NO;
    
}



@end

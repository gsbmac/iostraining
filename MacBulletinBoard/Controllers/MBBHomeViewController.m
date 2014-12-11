//
//  MBBHomeViewController.m
//  MacBulletinBoard
//
//  Created by Mac on 12/9/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBHomeViewController.h"

@interface MBBHomeViewController (){
    NSMutableArray *titles;
    NSMutableArray *posts;
    NSMutableArray *users;
}
@end

@implementation MBBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"isFirstRun"] == nil) {
        NSLog(@"First Run");
        [defaults setObject:@"YES" forKey:@"isFirstRun"];
        
        // init arrays
        titles = [[NSMutableArray alloc] initWithObjects:@"Calamities due to #RubyPH", @"Codesignate New Hires", @"MacBook Case",nil];
        posts = [[NSMutableArray alloc] initWithObjects:@"Ruby, a certified super typhoon stayed in the Philippines for almost a week. Many casualties have been reported.", @"For the year 2014, the company has reached its goal of hiring around 30 employees", @"Many employees of Codesignate were enthralled by cool designs for their MacBooks.", nil];
        users = [[NSMutableArray alloc] initWithObjects:@"mac", @"bey", @"mac", nil];
        
        // store arrays to NSUserDefaults
        [defaults setObject:titles forKey:@"titles"];
        [defaults setObject:posts forKey:@"posts"];
        [defaults setObject:users forKey:@"users"];
    
        [defaults synchronize];
    }
    
    [self initializeContents];
}

- (void)initializeContents {
    
    self.homeView = (MBBHomeView*)[self getCustomXibUsingXibName:@"HomeView"];
    self.homeView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.navigationItem.hidesBackButton = YES; // hides the back button
    
    // Set delegates
    self.homeView.delegate = self;
    self.homeView.postTableView.delegate = self;
    self.homeView.postTableView.dataSource = self;
    
    // Init nsuserdefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults objectForKey:@"username"];
    
    self.homeView.usernameLabel.text = username;
    if ([username isEqualToString:@"mac"]) {
        self.homeView.profilePicture.image = [UIImage imageNamed:@"icon"];
        self.homeView.profilePicture.layer.cornerRadius = self.homeView.profilePicture.frame.size.height/2;
        self.homeView.profilePicture.layer.masksToBounds = YES;
        self.homeView.profilePicture.layer.borderWidth = 2.0f;
        self.homeView.profilePicture.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    else {
        self.homeView.profilePicture.image = [UIImage imageNamed:@"user"];
        self.homeView.profilePicture.layer.cornerRadius = 44;
        self.homeView.profilePicture.layer.borderWidth = 2.0f;
        self.homeView.profilePicture.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    
    [self.view addSubview:self.homeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addPostButtonPressed{
    [self performSegueWithIdentifier:@"HomeToAddPostSegue" sender:self];
}

- (void)logoutButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *persistentTitles = [[defaults arrayForKey:@"titles"] mutableCopy];
    return persistentTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // check which tableView is currently using this delegate method
    if (tableView == self.homeView.postTableView) {
        MBBPostTableViewCell *postCell = (MBBPostTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PostCell"];
        
        if (postCell == nil) {
            postCell = [[[NSBundle mainBundle] loadNibNamed:@"PostTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        
        // init userdefaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        // retrieve users, posts, titles from userdefaults
        NSMutableArray *persistentTitles = [[defaults arrayForKey:@"titles"] mutableCopy];
        NSMutableArray *persistentPosts = [[defaults arrayForKey:@"posts"] mutableCopy];
        NSMutableArray *persistentUsers = [[defaults arrayForKey:@"users"] mutableCopy];
    
        postCell.titleLabel.text = [persistentTitles objectAtIndex:indexPath.row];
        postCell.postLabel.text = [persistentPosts objectAtIndex:indexPath.row];
        postCell.userLabel.text = [persistentUsers objectAtIndex:indexPath.row];
        
        return postCell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // init userdefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // retrieve users, posts, titles from userdefaults
    NSMutableArray *persistentTitles = [[defaults arrayForKey:@"titles"] mutableCopy];
    NSMutableArray *persistentPosts = [[defaults arrayForKey:@"posts"] mutableCopy];
    NSMutableArray *persistentUsers = [[defaults arrayForKey:@"users"] mutableCopy];
    
    NSString *title = [persistentTitles objectAtIndex:indexPath.row];
    NSString *post = [persistentPosts objectAtIndex:indexPath.row];
    NSString *user = [persistentUsers objectAtIndex:indexPath.row];
    
    [defaults setObject:title forKey:@"title"];
    [defaults setObject:post forKey:@"post"];
    [defaults setObject:user forKey:@"user"];
    
    [self performSegueWithIdentifier:@"HomeToPostSegue" sender:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  SettingViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "SettingViewController.h"
#import "FavoriteListViewController.h"
#import "CategoryListViewController.h"
#import "CommonWebViewController.h"
#import "Constants.h"
#import "GAManager.h"

#import <VTAcknowledgementsViewController/VTAcknowledgementsViewController.h>

@interface SettingViewController ()

@property (nonatomic, strong) NSMutableArray *menuArray;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [GAManager trackWithView:NSStringFromClass(self.class)];

    self.menuArray = [[NSMutableArray alloc] initWithObjects:
                      NSLocalizedString(@"FAVORITES", @"FAVORITES"),
                      NSLocalizedString(@"NOTICE", @"NOTICE"),
                      NSLocalizedString(@"CONTACTUS", @"CONTACTUS"),
                      NSLocalizedString(@"OPENSOURCE", @"OPENSOURCE"),
                      NSLocalizedString(@"VERSION", @"VERSION"),
                      nil];
    [self.menuTableview setScrollsToTop:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect rect = [self.view frame];
    rect.size.height -= HEIGHT_BANNER;
    
    [self.view setFrame:rect];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%ld_%ld",(long) indexPath.section, (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        [cell.textLabel setText:[self.menuArray objectAtIndex:indexPath.row]];
        [cell.textLabel setTextColor:[UIColor blackColor]];
        if([cell.textLabel.text isEqualToString:NSLocalizedString(@"VERSION", @"VERSION")])
            [cell.detailTextLabel setText:@"1.0.0"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        [self callFavoritesViewController];
    if(indexPath.row == 1)
        [self callNoticeWebviewController];
    else if(indexPath.row == 2)
        [self callMailto];
    else if(indexPath.row == 3)
        [self callOpenLibraryLicensseViewController];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

// 메일 쓰기
- (void)callMailto
{
    NSString *recipients = @"mailto:starcrafttvapp@gmail.com?subject=";
    NSString *body = @"&body=";
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:email]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
        [GAManager trackWithView:@"Mail to Administrator"];
    }
}

// 오픈 라이브러리 페이지
- (void)callOpenLibraryLicensseViewController
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Pods-StarCraftTV-acknowledgements" ofType:@"plist"];
    VTAcknowledgementsViewController *viewController = [[VTAcknowledgementsViewController alloc] initWithPath:path];
    [self.navigationController pushViewController:viewController animated:YES];
    
    [GAManager trackWithView:@"VTAcknowledgementsViewController"];
}

// 공지사항(Google Site) 페이지
- (void)callNoticeWebviewController
{
    CommonWebViewController *viewController = [[CommonWebViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

// 즐겨찾기 페이지
- (void)callFavoritesViewController
{
    FavoriteListViewController *viewController = [[FavoriteListViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

//
//  SettingViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "SettingViewController.h"
#import "CategoryListViewController.h"
#import "Constants.h"

@interface SettingViewController ()

@property (nonatomic, strong) NSMutableArray *menuArray;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menuArray = [[NSMutableArray alloc] initWithObjects:@"공지사항",@"버전",@"오픈소스",@"문의사항", nil];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        [cell.textLabel setText:[self.menuArray objectAtIndex:indexPath.row]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryListViewController *category = [[CategoryListViewController alloc] init];
    [self.navigationController pushViewController:category animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.f;
}

@end

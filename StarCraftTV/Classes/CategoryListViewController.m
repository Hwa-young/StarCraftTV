//
//  CategoryListViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "CategoryListViewController.h"
#import "PlayListTableViewController.h"
#import "CategoryManager.h"
#import "Constants.h"

@interface CategoryListViewController ()

@property (nonatomic, strong) NSMutableArray *categotyArray;

@end

@implementation CategoryListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.categotyArray = [[NSMutableArray alloc] initWithArray:[CATEGORY_MANAGER getLeagueArray]];
    
    [self.menuTableview setScrollsToTop:YES];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect rect = [self.view frame];
    rect.size.height -= HEIGHT_BANNER;
    
    [self.view setFrame:rect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categotyArray count];
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
        
//        [cell.textLabel setText:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
//        [cell.textLabel setTextColor:[UIColor whiteColor]];
        
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setText:[self.categotyArray objectAtIndex:indexPath.row][@"year"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PlayListTableViewController *collectionView =[storyboard instantiateViewControllerWithIdentifier:@"PlayListTableViewController"];
    [self.navigationController pushViewController:collectionView animated:TRUE];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.f;
}

@end

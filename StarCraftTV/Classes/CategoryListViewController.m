//
//  CategoryListViewController.m
//  StarCraftTV
//
//  Created by 고화영 on 2017. 5. 24..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "CategoryListViewController.h"
#import "PlayListTableViewController.h"

@interface CategoryListViewController ()

@property (nonatomic, strong) NSMutableArray *categotyArray;

@end

@implementation CategoryListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.categotyArray = [[NSMutableArray alloc] init];
    [self.categotyArray addObject:@"2012"];
    [self.categotyArray addObject:@"2011"];
    [self.categotyArray addObject:@"2010"];
    [self.categotyArray addObject:@"2009"];
    [self.categotyArray addObject:@"2008"];
    [self.categotyArray addObject:@"2007"];
    [self.categotyArray addObject:@"2006"];
    [self.categotyArray addObject:@"2005"];
    [self.categotyArray addObject:@"2004"];
    [self.categotyArray addObject:@"2003"];
    [self.categotyArray addObject:@"2002"];
    [self.categotyArray addObject:@"2001"];
    [self.categotyArray addObject:@"2000"];
    [self.categotyArray addObject:@"1999"];
    
    [self.menuTableview setScrollsToTop:YES];
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
        [cell.textLabel setText:[self.categotyArray objectAtIndex:indexPath.row]];
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

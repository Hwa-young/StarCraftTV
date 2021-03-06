//
//  YTTableViewCell.m
//  StarCraftTV
//
//  Created by 고화영 on 6/30/16.
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import "YTTableViewCell.h"
#import "YouTubeAPIHelper.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface YTTableViewCell ()

@property (strong, nonatomic) YouTubeAPIHelper *youtubeAPI;

@end

@implementation YTTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    
    [self.dateLabel sizeToFit];
    self.dateLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.dateLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setTabelviewCell:(YTItem*)item
{
    if(!item) return;
    if(!self.youtubeAPI)
        self.youtubeAPI = [[YouTubeAPIHelper alloc] init];
    
    [self.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:item.snippet.thumbnails[@"default"][@"url"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    [self getVideoInformation:item cell:self];
    
    NSString * newReplacedString = @"";
    newReplacedString = item.snippet.title;
    
    self.titleLabel.text = newReplacedString;
}

- (void)setTableviewWithSnippet:(YTSnippetItem*)item
{
    if(!item) return;
    if(!self.youtubeAPI)
        self.youtubeAPI = [[YouTubeAPIHelper alloc] init];
    
    [self.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:item.thumbnails[@"default"][@"url"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    [self getVideoInformationWithItem:item cell:self];
    
    NSString * newReplacedString = @"";
    newReplacedString = item.title;
    
    self.titleLabel.text = newReplacedString;
}

- (void)getVideoInformation:(YTItem*)item cell:(YTTableViewCell*)tCell
{
    if(!item.id[@"videoId"]) return;
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    // Test Code
    if(item.id[@"videoId"])
        [param setObject:item.id[@"videoId"] forKey:@"videoId"];
    
    [self.youtubeAPI.paramaters addEntriesFromDictionary:param];
    [self.youtubeAPI getVideoInfo:item.id[@"videoId"] completion:^(BOOL success, NSError *error) {
        if (success) {
            
            if(self.youtubeAPI.statisticsItem)
            {
                NSNumber  *viewCount = [NSNumber numberWithInteger: [[self.youtubeAPI.statisticsItem objectForKey:@"viewCount"] integerValue]];
                if([[ UIScreen mainScreen ] bounds ].size.height == 568)
                {
                    [tCell.dateLabel setText:[NSString stringWithFormat:@"조회수 : %@ / %@",
                                              [NSNumberFormatter localizedStringFromNumber:viewCount numberStyle:NSNumberFormatterDecimalStyle],
                                              [self parseDuration:[self.youtubeAPI.videoInfoItem objectForKey:@"duration"]]]];
                }
                else
                {
                    [tCell.dateLabel setText:[NSString stringWithFormat:@"조회수 : %@ / 재생시간 : %@",
                                              [NSNumberFormatter localizedStringFromNumber:viewCount numberStyle:NSNumberFormatterDecimalStyle],
                                              [self parseDuration:[self.youtubeAPI.videoInfoItem objectForKey:@"duration"]]]];
                }
            }
        }
    }];
}

- (void)getVideoInformationWithItem:(YTSnippetItem*)item cell:(YTTableViewCell*)tCell
{
    if(!item.resourceId[@"videoId"]) return;
    
    NSMutableDictionary *param = [NSMutableDictionary new];
    // Test Code
    if(item.resourceId[@"videoId"])
        [param setObject:item.resourceId[@"videoId"] forKey:@"videoId"];
    
    [self.youtubeAPI.paramaters addEntriesFromDictionary:param];
    [self.youtubeAPI getVideoInfo:item.resourceId[@"videoId"] completion:^(BOOL success, NSError *error) {
        if (success) {
            
            if(self.youtubeAPI.statisticsItem)
            {
                NSNumber  *viewCount = [NSNumber numberWithInteger: [[self.youtubeAPI.statisticsItem objectForKey:@"viewCount"] integerValue]];
                
                if([[ UIScreen mainScreen ] bounds ].size.height == 568)
                {
                    [tCell.dateLabel setText:[NSString stringWithFormat:@"조회수 : %@ / %@",
                                              [NSNumberFormatter localizedStringFromNumber:viewCount numberStyle:NSNumberFormatterDecimalStyle],
                                              [self parseDuration:[self.youtubeAPI.videoInfoItem objectForKey:@"duration"]]]];
                }
                else
                {
                    [tCell.dateLabel setText:[NSString stringWithFormat:@"조회수 : %@ / 재생시간 : %@",
                                              [NSNumberFormatter localizedStringFromNumber:viewCount numberStyle:NSNumberFormatterDecimalStyle],
                                              [self parseDuration:[self.youtubeAPI.videoInfoItem objectForKey:@"duration"]]]];
                }
            }
        }
    }];
}


- (NSString *)parseDuration:(NSString *)duration
{
    if(!duration) return @"-";
    
    NSInteger hours = 0;
    NSInteger minutes = 0;
    NSInteger seconds = 0;
    
    NSRange timeRange = [duration rangeOfString:@"T"];
    duration = [duration substringFromIndex:timeRange.location];
    
    while (duration.length > 1) {
        duration = [duration substringFromIndex:1];
        
        NSScanner *scanner = [NSScanner.alloc initWithString:duration];
        NSString *part = [NSString.alloc init];
        [scanner scanCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&part];
        
        NSRange partRange = [duration rangeOfString:part];
        
        duration = [duration substringFromIndex:partRange.location + partRange.length];
        
        NSString *timeUnit = [duration substringToIndex:1];
        if ([timeUnit isEqualToString:@"H"])
            hours = [part integerValue];
        else if ([timeUnit isEqualToString:@"M"])
            minutes = [part integerValue];
        else if ([timeUnit isEqualToString:@"S"])
            seconds = [part integerValue];
    }
    if(hours==0.f)
        return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    else
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}


@end

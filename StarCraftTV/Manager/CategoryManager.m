//
//  CategoryManager.m
//  tving
//
//  Created by mandolin on 2014. 7. 28..
//  Copyright (c) 2016년 CJ E&M. All rights reserved.
//

#import "CategoryManager.h"

@implementation CategoryManager
DEF_SINGLETON(CategoryManager);


- (id)init
{
	self = [super init];
	if (self) {
		_userDefaults = [NSUserDefaults standardUserDefaults];
        [self loadFromUserDefault];
	}
	return self;
}

- (void) loadFromUserDefault
{
    arrLeagueCategoty = [self arrayFromData:[_userDefaults objectForKey:CATEGORY_LEAGUE]];
}

- (void) saveToUserDefault
{
    [_userDefaults setObject:[self dataFromArray:arrLeagueCategoty] forKey:CATEGORY_LEAGUE];

    [_userDefaults synchronize];
}

- (NSData*) dataFromArray:(NSArray*) arr
{
    NSData* resultData = [NSKeyedArchiver archivedDataWithRootObject:arr];
    return resultData;
}

- (NSArray*) arrayFromData:(NSData*) data
{
    NSMutableArray* arr = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];

    return arr;
}

- (void) clearArray
{
    arrLeagueCategoty = nil;
}

// Save Boot API Dictionary to NSDictionary
- (void) saveCategoryDataWithDictionary:(NSDictionary*)dic
{
    [self clearArray];
    
    arrLeagueCategoty = [[NSMutableArray alloc] init];
    arrLeagueCategoty = [[self getSubCategoryArrayWithSubArray:[dic arrayAtPath:@"league"]] copy];
    
//    arrCategoryMainLogin = [[self getSubCategoryArrayWithSubArray:[dic arrayAtPath:@"category.main_login"]] copy];
    
    [self saveToUserDefault];
}

// 공통 함수 : Array내에서 항목에 맞는 Dictionary찾아서 리턴
- (NSDictionary*) getDictionaryWithArray:(NSArray*)arr withKey:(NSString*)keyStr
{
    if (arr == nil || [arr count] == 0 || keyStr == nil)
        return nil;
    NSString* trimKeyStr = [keyStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([trimKeyStr isEqualToString:@""]) return nil;
    
    for (NSDictionary* item in arr)
    {
        NSString* categoryKey = [item stringAtPath:@"category_key"];
        if ([categoryKey isEqualToString:trimKeyStr])
        {
            return item;
        }
        
        NSArray* subCategoryArray = [item arrayAtPath:@"sub_category"];
        if (subCategoryArray != nil && [subCategoryArray count]>0)
        {
            for (NSDictionary* subItem in subCategoryArray)
            {
                NSString* subCategoryKey = [subItem stringAtPath:@"category_key"];
                if ([subCategoryKey isEqualToString:trimKeyStr])
                {
                    return subItem;
                }
            }
        }
    }
    return nil;
}


- (NSDictionary*) getSubItemArray:(NSDictionary*) itemDic
{
    NSArray* subCategoryArray = [itemDic arrayAtPath:@"sub_category"];
    if (subCategoryArray != nil && [subCategoryArray count]>0)
    {
        return [subCategoryArray objectAtIndex:0];
    } else
    {
        return itemDic;
    }
}

// 공통 함수 : KeyList String으로 부터 Array 리턴
- (NSArray*) getKeyArrayWithString:(NSString*)keyStr
{
    if (keyStr == nil || [keyStr isEqualToString:@""]) return nil;
    return [keyStr componentsSeparatedByString:@","];
}

- (NSArray*) getSubCategoryArrayWithSubArray:(NSArray*) itemArray
{
    NSMutableArray* resultArray=[NSMutableArray array];
    for (NSDictionary* item in itemArray)
    {
        NSArray* subItemArray = [item arrayAtPath:@"competition"];
        NSMutableDictionary* dummyDic;
        if (subItemArray == nil || [subItemArray count]==0)
        {
            dummyDic = [NSMutableDictionary dictionary];
//            [dummyDic setObject:@"" forKey:@"category_name"];
            [dummyDic setObject:[NSArray arrayWithObject:item] forKey:@"competition"];
        } else
        {
            dummyDic = [item mutableCopy];
        }
        [resultArray addObject:dummyDic];
    }
    return resultArray;
}

- (NSArray*) getTitleCategoryArrayWithSubArray:(NSString*)keyStr withCategoryArray:(NSArray*)cateArray
{
    NSArray* keyArray =  [self getKeyArrayWithString:keyStr];
    NSMutableArray* resultArray = [NSMutableArray array];
    for (NSString* item in keyArray)
    {
        NSDictionary* resultDic = [self getDictionaryWithArray:cateArray withKey:item];
        
        
        if (resultDic != nil)
            [resultArray addObject:resultDic];
    }
    
    return resultArray;
}

- (NSArray*) getSubCategoryArrayWithSubArrayDomestic:(NSArray*) itemArray
{
    NSMutableArray* resultArray=[NSMutableArray array];
    for (NSDictionary* item in itemArray)
    {
        NSArray* subItemArray = [item arrayAtPath:@"sub_category"];
        NSMutableDictionary* dummyDic;
        if (subItemArray == nil || [subItemArray count]==0)
        {
            dummyDic = [NSMutableDictionary dictionary];
            [dummyDic setObject:@"" forKey:@"category_name"];
            [dummyDic setObject:[NSArray arrayWithObject:item] forKey:@"sub_category"];
        } else
        {
            dummyDic = [item mutableCopy];
        }
        [resultArray addObject:dummyDic];
    }
    return resultArray;
}

- (NSArray*) getTitleCategoryArrayWithSubArrayDomestic:(NSString*)keyStr withCategoryArray:(NSArray*)cateArray
{
    NSArray* keyArray =  [self getKeyArrayWithString:keyStr];
    NSMutableArray* resultArray = [NSMutableArray array];
    for (NSString* item in keyArray)
    {
        NSDictionary* resultDic = [self getDictionaryWithArray:cateArray withKey:item];
        
        if (resultDic != nil)
            [resultArray addObject:resultDic];
    }
    
    return resultArray;
}

- (NSArray*) getLeagueArray
{
    return arrLeagueCategoty;
}

@end

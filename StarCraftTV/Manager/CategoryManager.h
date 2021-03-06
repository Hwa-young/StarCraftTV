//
//  CategoryManager.h
//  tving
//
//  Created by mandolin on 2014. 7. 28..
//  Copyright (c) 2016년 CJ E&M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TF_Core.h"
#import "Constants.h"

#define CATEGORY_MANAGER	[CategoryManager sharedInstance]

@interface CategoryManager : NSObject
{
    NSMutableArray* arrLeagueCategoty;
    NSMutableArray* arrProgamerList;
    
    NSMutableArray* arrZergProgamerList;       // ZERG_PROGAMER_LIST
    NSMutableArray* arrProtossProgamerList;    // PROTOSS_PROGAMER_LIST
    NSMutableArray* arrTerranProgamerList;     // TERRAN_PROGAMER_LIST
}

AS_SINGLETON(CategoryManager);

@property (nonatomic, strong) NSUserDefaults *userDefaults;

- (void) loadFromUserDefault;
- (void) saveToUserDefault;
- (void) clearArray;

- (NSMutableArray*) getLeagueArray;

- (NSMutableArray*) getZergProgamerList;        // ZERG_PROGAMER_LIST
- (NSMutableArray*) getProtossProgamerList;     // PROTOSS_PROGAMER_LIST
- (NSMutableArray*) getTerranProgamerList;      // TERRAN_PROGAMER_LIST

- (NSMutableArray*) getProgamerList;            // PROGAMER_LIST


// Save Boot API Dictionary to NSDictionary
- (void) saveCategoryDataWithDictionary:(NSDictionary*)dic;

// 공통 함수 : Array내에서 항목에 맞는 Dictionary찾아서 리턴
- (NSDictionary*) getDictionaryWithArray:(NSArray*)arr withKey:(NSString*)keyStr;

// 공통 함수 : KeyList String으로 부터 Array 리턴
- (NSArray*) getKeyArrayWithString:(NSString*)keyStr;

// 공통 함수 : SubCategory의 아이템 조절 및 추출하기
- (NSArray*) getSubCategoryArrayWithSubArray:(NSArray*) itemArray;

// 공통 함수 : 카테고리의 타이틀에 노출될 항목 추출하기
- (NSArray*) getTitleCategoryArrayWithSubArray:(NSString*)keyStr withCategoryArray:(NSArray*)cateArray;

// NSArray <> NSData (직렬화,병렬화처리)
- (NSData*) dataFromArray:(NSArray*) arr;
- (NSArray*) arrayFromData:(NSData*) data;

@end

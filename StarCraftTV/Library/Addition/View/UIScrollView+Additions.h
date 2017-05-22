//
//  UIScrollView+Additions.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 11. 20..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Additions)

/**
 @brief 가로로 현재 페이지 번호를 반환한다. 페이지 번호는 0부터 시작한다.
 @author HYKo
 */
- (NSInteger)pageNumberByHorizontal;

- (NSInteger)totalPageNumberByHorizontal;

/**
 @brief 세로로 현재 페이지 번호를 반환한다. 페이지 번호는 0부터 시작한다.
 @author HYKo
 */
- (NSInteger)pageNumberByVertical;

/**
 @brief 페이지 번호에 해당하는 위치로 가로로 이동한다.
 @author HYKo
 */
- (void)scrollHorizontalToPageNo:(NSInteger)pageNo animated:(BOOL)animated;

/**
 @brief 페이지 번호에 해당하는 위치로 세로로 이동한다.
 @author HYKo
 */
- (void)scrollVerticalToPageNo:(NSInteger)pageNo animated:(BOOL)animated;


@end

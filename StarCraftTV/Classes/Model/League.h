//
//  League.h
//  StarCraftTV
//
//  Created by 고화영 on 2017. 6. 20..
//  Copyright © 2017년 HYKo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Competition : NSObject

@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSArray* tournaments;

@end

@interface League : NSObject

@property(strong,nonatomic) NSString *year;
@property(strong,nonatomic) Competition* competition;

@end

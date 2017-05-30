//
//  HTTPRequestHandler.h
//  YoutubeApp
//
//  Created by Robert Shrestha on 4/21/17.
//  Copyright © 2017 Robert Shrestha. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTTPRequesthandlerDelegate <NSObject>

@required
-(void) requestErr:(NSDictionary*)errorParams;
-(void)requestError:(NSError*)error;

@optional
-(void) requestSuccess:(id) dict;
@end

@interface HTTPRequestHandler : NSObject
+(void)HTTPGetMethod:(NSString *) stringURL andParameter:(NSDictionary *) parameter andSelector:(SEL) selector andTarget:(id)target;

@end

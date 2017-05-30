//
//  HTTPRequestHandler.m
//  YoutubeApp
//
//  Created by Robert Shrestha on 4/21/17.
//  Copyright © 2017 Robert Shrestha. All rights reserved.
//

#import "HTTPRequestHandler.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@implementation HTTPRequestHandler

+(void)HTTPGetMethod:(NSString *) stringURL andParameter:(NSDictionary *) parameter andSelector:(SEL) selector andTarget:(id)target{
    
    NSLog(@"Sending Request to:%@ with parameter:%@",stringURL, parameter);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:stringURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        //NSLog(@"HTTP Respons :%@",[self convertToString:responseObject]);
        
        [target performSelectorOnMainThread:selector withObject:responseObject waitUntilDone:YES];
        NSLog(@"===========Sucess Block HTTPGet=============");
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [target performSelectorOnMainThread:@selector(requestError:) withObject:error waitUntilDone:YES];
        NSLog(@"===========Failure Block=============");
        
    }];

    
}

+(NSString *) convertToString:(id) object{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString;
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


@end

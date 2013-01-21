//
//  ARCloud.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/11/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ARCloud;
@protocol CloudResponse <NSObject>
-(void)OnDownload:(NSData*)data:(int)ref;
@end

@interface ARCloud : NSObject{
    NSMutableData *responseData;
    int refe;
    __weak id<CloudResponse> delegate;
}
@property(nonatomic,weak)id<CloudResponse> delegate;

- (void)requestwithArray:(NSMutableDictionary*)json:(NSString*)url;
-(void)request:(NSString*)url:(int)ref;
@end

//
//  ARCloud.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/11/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "ARCloud.h"

@implementation ARCloud
@synthesize delegate;
-(id)init{

    return self;
}

- (void)requestwithArray:(NSMutableDictionary*)json : (NSString*)url
{
    NSURL *myURL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    NSString *uid=[NSString stringWithFormat:@"%@",[UIDevice currentDevice].identifierForVendor.UUIDString];
    [json setObject:uid forKey:@"uid"];
      NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonData];
   // NSLog(@"%@",json);
   (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
   
}
-(void)request:(NSString*)url : (int)ref{
    refe=ref;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    (void)[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                    message:@"You must be connected to the internet to use this app."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [delegate OnDownload:responseData:refe];
}
@end
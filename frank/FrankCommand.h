#import <Foundation/Foundation.h>

@protocol FrankCommand

@required
- (NSString *)handleCommandWithRequestBody:(NSString *)requestBody;
@end


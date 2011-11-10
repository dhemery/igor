//
//  Created by Dale on 11/8/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol FrankCommand
@required
- (NSString *)handleCommandWithRequestBody:(NSString *)requestBody;
@end

@interface MapOperationCommand : NSObject<FrankCommand>
@end

@interface MapOperationCommand (IgorAdditions)
- (NSArray *)selectViewsUsingUIQueryWithSelector:(NSString *)queryString;
@end
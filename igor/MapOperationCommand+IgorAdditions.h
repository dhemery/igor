//
//  Created by Dale on 11/8/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "MapOperationCommand.h"

@interface MapOperationCommand (IgorAdditions)
- (NSString *)handleCommandWithRequestBody:(NSString *)requestBody;
@end
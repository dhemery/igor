//
//  Created by Dale on 11/3/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Selector.h"


@interface ExactClassSelector : Selector
- (ExactClassSelector *)initWithClass:(Class)exactClass;
@end
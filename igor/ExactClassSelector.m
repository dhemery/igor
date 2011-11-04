//
//  Created by Dale on 11/3/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ExactClassSelector.h"
#import "UniversalClassSelector.h"


@implementation ExactClassSelector {
    Class requiredClass;
}

- (ExactClassSelector *)initWithClass:(Class)exactClass {
    if (self = [super init]) {
        requiredClass = exactClass;
    }
    return self;
}

-(BOOL)matches:(UIView *)view {
    return [view class] == requiredClass;
}
@end
//
//  Created by Dale on 11/3/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "InheritsClassSelector.h"


@implementation InheritsClassSelector {
    Class requiredSuperclass;
}

- (InheritsClassSelector *)initWithClass:(Class)superclass {
    if (self = [super init]) {
        requiredSuperclass = superclass;
    }
    return self;
}

-(BOOL)matches:(UIView *)view {
    return [view isKindOfClass:requiredSuperclass];
}

@end
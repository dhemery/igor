//
//  Created by Dale Emery on 11/3/11.
//


#import "ClassEqualsSelector.h"
#import "Igor.h"
#import "Selector.h"
#import "UniversalSelector.h"

@implementation Igor

- (void)selectViewsWithSelector:(id<Selector>)selector fromRoot:(UIView *)root intoSet:(NSMutableSet*)selectedViews {
    if ([selector matchesView:root]) {
        [selectedViews addObject:root];
    }
    for(id subview in [root subviews]) {
        [self selectViewsWithSelector:selector fromRoot:subview intoSet:selectedViews];
    }
}

-(id<Selector>) selectorForSelectorString:(NSString*)selectorString {
    if([selectorString isEqualToString:@"*"]) {
        return [UniversalSelector new];
    } else {
        Class matchClass = NSClassFromString(selectorString);
        return [[ClassEqualsSelector alloc] initWithClass:matchClass];
    }
}

-(NSArray*) selectViewsWithSelector:(NSString*)selectorString fromRoot:(UIView *)root {
    id<Selector> selector = [self selectorForSelectorString:selectorString];
    NSMutableSet* selectedViews = [NSMutableSet set];
    [self selectViewsWithSelector:selector fromRoot:root intoSet:selectedViews];
    return [selectedViews allObjects];
}

-(NSArray*) selectViewsWithSelector:(NSString*)selectorString {
    return [self selectViewsWithSelector:selectorString
                                fromRoot:[[UIApplication sharedApplication] keyWindow]];
}

@end
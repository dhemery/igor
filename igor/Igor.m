//
//  Created by Dale Emery on 11/3/11.
//


#import "ClassEqualsSelector.h"
#import "Igor.h"
#import "IgorParser.h"
#import "Selector.h"

@implementation Igor {
    IgorParser* parser;
}
-(Igor*) init {
    if(self = [super init]) {
        parser = [IgorParser new];
    }
    return self;
}

- (void)selectViewsWithSelector:(id<Selector>)selector fromRoot:(UIView *)root intoSet:(NSMutableSet*)selectedViews {
    if ([selector matchesView:root]) {
        [selectedViews addObject:root];
    }
    for(id subview in [root subviews]) {
        [self selectViewsWithSelector:selector fromRoot:subview intoSet:selectedViews];
    }
}

-(NSArray*) selectViewsWithSelector:(NSString*)selectorString fromRoot:(UIView *)root {
    id<Selector> selector = [parser parse:selectorString];
    NSMutableSet* selectedViews = [NSMutableSet set];
    [self selectViewsWithSelector:selector fromRoot:root intoSet:selectedViews];
    return [selectedViews allObjects];
}

-(NSArray*) selectViewsWithSelector:(NSString*)selectorString {
    return [self selectViewsWithSelector:selectorString
                                fromRoot:[[UIApplication sharedApplication] keyWindow]];
}

@end
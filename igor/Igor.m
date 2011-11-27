//
//  Created by Dale Emery on 11/3/11.
//

#import "Igor.h"
#import "IgorParser.h"
#import "Matcher.h"

@implementation Igor

- (void)findViewsThatMatch:(id<Matcher>)matcher fromRoot:(UIView *)root intoSet:(NSMutableSet*)matchingViews {
    if ([matcher matchesView:root]) {
        [matchingViews addObject:root];
    }
    for(id subview in [root subviews]) {
        [self findViewsThatMatch:matcher fromRoot:subview intoSet:matchingViews];
    }
}

-(NSArray*) findViewsThatMatchPattern:(NSString*)pattern fromRoot:(UIView *)root {
    id<Matcher> matcher = [[IgorParser new] parse:pattern];
    NSMutableSet* matchingViews = [NSMutableSet set];
    [self findViewsThatMatch:matcher fromRoot:root intoSet:matchingViews];
    return [matchingViews allObjects];
}


-(NSArray*) selectViewsUsingShelleyWithSelector:(NSString*)pattern {
    return [self selectViewsWithSelector:pattern];
}

-(NSArray*) selectViewsWithSelector:(NSString*)pattern {
    return [self findViewsThatMatchPattern:pattern
                                  fromRoot:[[UIApplication sharedApplication] keyWindow]];
}

@end
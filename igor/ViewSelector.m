//
//  Created by Dale on 11/3/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ViewSelector.h"


@implementation ViewSelector {
    @private
    NSString *selector;
}
- (void) gatherView:(UIView *)view intoSet:(NSMutableSet *)set {
    [set addObject:view];
}

- (void)gatherSubviewsOf:(UIView *)root intoSet:(NSMutableSet *)selectedViews {
    for(id view in [root subviews]) {
        [self gatherView:view intoSet:selectedViews];
    }
}

- (void)selectFromRoot:(UIView *)root intoSet:(NSMutableSet *)selectedViews {
    [self gatherView:root intoSet:selectedViews];
    for(id view in [root subviews]) {
        [self gatherView:view intoSet:selectedViews];
        [self gatherSubviewsOf:view intoSet:selectedViews];
    }
}

- (ViewSelector *)initWithSelector:(NSString *)aSelector {
    if (self = [super init]) {
        selector = aSelector;
    }
    return self;
}

- (NSMutableSet *)selectViewsFromRoot:(UIView *)root {
    NSMutableSet *selectedViews = [NSMutableSet set];
    [self selectFromRoot:root intoSet:selectedViews];
    return selectedViews;
}

+ (ViewSelector *)selectorFor:(NSString *)selectorString {
    return [[ViewSelector alloc] initWithSelector:selectorString];
}
@end
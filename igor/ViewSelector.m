//
//  Created by Dale on 11/3/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ViewSelector.h"

@interface Selector : NSObject
- (BOOL)matchesView:(UIView *)view;
@end

@implementation Selector
-(BOOL)matchesView:(UIView *)view {
    return NO;
}
@end

@interface UniversalClassSelector : Selector
@end

@implementation UniversalClassSelector
- (BOOL)matchesView:(UIView *)view {
    return YES;
}

@end

@interface ClassEqualsSelector : Selector
-(ClassEqualsSelector*) initWithClass:(Class)matchClass;
@end

@implementation ClassEqualsSelector {
    @private
    Class matchClass;
}

-(ClassEqualsSelector*) initWithClass:(Class)aClass {
    if(self = [super init]) {
        matchClass = aClass;
    }
    return self;
}

-(BOOL)matchesView:(UIView *)view {
    if(matchClass == [view class]) {
        NSLog(@"Class is %@, matches", [view class]);
        return YES;
    } else {
        NSLog(@"Class is %@, does not match", [view class]);
        return NO;
    };
}
@end

@implementation ViewSelector {
    @private
    Selector *selector;
}

- (ViewSelector *)initWithSelector:(NSString *)aSelector {
    if (self = [super init]) {
        if([aSelector isEqualToString:@"*"]) {
            selector = [UniversalClassSelector new];
            NSLog(@"Universal class selector");
        } else {
            Class matchClass = NSClassFromString(aSelector);
            NSLog(@"Class equals: %@", matchClass);
            selector = [[ClassEqualsSelector alloc] initWithClass:matchClass];
        }
    }
    return self;
}

+ (ViewSelector *)selectorFor:(NSString *)selectorString {
    return [[ViewSelector alloc] initWithSelector:selectorString];
}

- (void)selectFromRoot:(UIView *)root intoSet:(NSMutableSet *)selectedViews {
    if ([selector matchesView:root]) {
        [selectedViews addObject:root];
    }
    for(id subview in [root subviews]) {
        [self selectFromRoot:subview intoSet:selectedViews];
    }
}

- (NSMutableSet *)selectViewsFromRoot:(UIView *)root {
    NSMutableSet *selectedViews = [NSMutableSet set];
    [self selectFromRoot:root intoSet:selectedViews];
    return selectedViews;
}

@end
//
//  Created by Dale Emery on 11/3/11.
//


#import "ClassEqualsSelector.h"
#import "Igor.h"
#import "Selector.h"
#import "UniversalClassSelector.h"

@implementation Igor {
    @private
    id<Selector> selector;
}

- (Igor *)initWithSelectorString:(NSString *)selectorString {
    if (self = [super init]) {
        if([selectorString isEqualToString:@"*"]) {
            selector = [UniversalClassSelector new];
        } else {
            Class matchClass = NSClassFromString(selectorString);
            selector = [[ClassEqualsSelector alloc] initWithClass:matchClass];
        }
    }
    return self;
}

+ (Igor *)igorFor:(NSString *)selectorString {
    return [[Igor alloc] initWithSelectorString:selectorString];
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

+ (NSMutableSet*) selectViewsThatMatchQuery:(NSString*)queryString {
    Igor* igor = [Igor igorFor:queryString];
    UIView *root = [[UIApplication sharedApplication] keyWindow] ;
    return [igor selectViewsFromRoot:root];
}


@end
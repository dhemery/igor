//
//  Created by Dale Emery on 11/3/11.
//


#import "ClassEqualsSelector.h"
#import "Igor.h"
#import "Selector.h"
#import "UniversalSelector.h"

@implementation Igor {
    @private
    id<Selector> selector;
}

- (Igor *)initWithSelectorString:(NSString *)selectorString {
    if (self = [super init]) {
        if([selectorString isEqualToString:@"*"]) {
            selector = [UniversalSelector new];
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

- (void)selectFromRoot:(UIView *)root intoArray:(NSMutableArray *)selectedViews {
    if ([selector matchesView:root]) {
        [selectedViews addObject:root];
    }
    for(id subview in [root subviews]) {
        [self selectFromRoot:subview intoArray:selectedViews];
    }
}

- (NSArray *)selectViewsFromRoot:(UIView *)root {
    NSMutableArray *selectedViews = [NSMutableSet set];
    [self selectFromRoot:root intoArray:selectedViews];
    return selectedViews;
}

+ (NSArray*) selectViewsThatMatchQuery:(NSString*)queryString {
    Igor* igor = [Igor igorFor:queryString];
    UIView *root = [[UIApplication sharedApplication] keyWindow] ;
    return [igor selectViewsFromRoot:root];
}


@end
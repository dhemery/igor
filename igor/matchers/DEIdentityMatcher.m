#import "DEIdentityMatcher.h"

@implementation DEIdentityMatcher {
    NSString *descriptionString;
}

@synthesize targetView;


+ (DEIdentityMatcher *)matcherWithView:(id)view description:(NSString *)description {
     return [[self alloc] initWithView:view description:description];
}

+ (DEIdentityMatcher *)matcherWithView:(id)view {
    NSString *description = [NSString stringWithFormat:@"{%@}", [view description]];
    return [self matcherWithView:view description:description];
}

- (NSString *)description {
    return descriptionString;
}

- (DEIdentityMatcher *)initWithView:(id)view description:(NSString *)description {
    self = [super init];
    if (self) {
        descriptionString = description;
        targetView = view;
    }
    return self;
}


- (BOOL)matchesView:(id)view {
    return self.targetView == view;
}

@end

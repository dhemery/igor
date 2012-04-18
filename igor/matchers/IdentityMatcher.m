#import "IdentityMatcher.h"

@implementation IdentityMatcher {
    NSString *descriptionString;
}

@synthesize targetView;


+ (IdentityMatcher *)matcherWithView:(UIView *)view description:(NSString *)description {
     return [[self alloc] initWithView:view description:description];
}

+ (IdentityMatcher *)matcherWithView:(UIView *)view {
    NSString *description = [NSString stringWithFormat:@"{%@}", [view description]];
    return [self matcherWithView:view description:description];
}

- (NSString *)description {
    return descriptionString;
}

- (IdentityMatcher *)initWithView:(UIView *)view description:(NSString *)description {
    self = [super init];
    if (self) {
        descriptionString = description;
        targetView = view;
    }
    return self;
}


- (BOOL)matchesView:(UIView *)view {
    return self.targetView == view;
}

@end

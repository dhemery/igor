#import "MemberOfClassMatcher.h"

@implementation MemberOfClassMatcher

@synthesize matchClass;

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", self.matchClass];
}

+ (MemberOfClassMatcher *)matcherForExactClass:(Class)exactClass {
    return [[self alloc] initForExactClass:exactClass];
}

- (MemberOfClassMatcher *)initForExactClass:(Class)exactClass {
    if (self = [super init]) {
        matchClass = exactClass;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view {
    return [view isMemberOfClass:self.matchClass];
}

@end

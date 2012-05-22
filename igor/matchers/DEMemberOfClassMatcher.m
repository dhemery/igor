#import "DEMemberOfClassMatcher.h"

@implementation DEMemberOfClassMatcher

@synthesize matchClass;

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", self.matchClass];
}

+ (DEMemberOfClassMatcher *)matcherForExactClass:(Class)exactClass {
    return [[self alloc] initForExactClass:exactClass];
}

- (DEMemberOfClassMatcher *)initForExactClass:(Class)exactClass {
    self = [super init];
    if (self) {
        matchClass = exactClass;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view {
    return [view isMemberOfClass:self.matchClass];
}

@end

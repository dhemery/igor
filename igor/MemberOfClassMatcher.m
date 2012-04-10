#import "MemberOfClassMatcher.h"

@implementation MemberOfClassMatcher

@synthesize matchClass = _matchClass;

- (NSString *)description {
    return [NSString stringWithFormat:@"[MemberOfClass:%@]", _matchClass];
}

+ (MemberOfClassMatcher *)forClass:(Class)matchClass {
    return [[self alloc] initForClass:matchClass];
}

- (MemberOfClassMatcher*)initForClass:(Class)matchClass {
    if (self = [super init]) {
        _matchClass = matchClass;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view {
    return [view isMemberOfClass:self.matchClass];
}

@end

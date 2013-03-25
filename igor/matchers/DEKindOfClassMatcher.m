#import "DEKindOfClassMatcher.h"

@implementation DEKindOfClassMatcher

@synthesize matchClass;

- (NSString *)description {
    return [NSString stringWithFormat:@"%@*", self.matchClass];
}

+ (DEKindOfClassMatcher *)matcherForBaseClass:(Class)baseClass {
    return [[self alloc] initForBaseClass:baseClass];
}

- (DEKindOfClassMatcher *)initForBaseClass:(Class)baseClass {
    self = [super init];
    if (self) {
        matchClass = baseClass;
    }
    return self;
}

- (BOOL)matchesView:(id)view {
    return [view isKindOfClass:self.matchClass];
}

@end

#import "EmptySetCombinator.h"

@implementation EmptySetCombinator

- (NSString *)description {
    return @"{empty.combinator}";
}

- (NSArray *)relativesOfView:(id)view {
    return [NSArray array];
}

- (NSArray *)inverseRelativesOfView:(id)subject {
    return [NSArray array];
}

@end

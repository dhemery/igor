#import "PredicateMatcher.h"

@implementation PredicateMatcher

@synthesize predicate;

- (NSString *)description {
    return [NSString stringWithFormat:@"[Predicate:%@]", self.expression];
}

- (PredicateMatcher *)initWithPredicate:(NSPredicate *)aPredicate {
    self = [super init];
    if (self) {
        predicate = aPredicate;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view {
    @try {
        return [self.predicate evaluateWithObject:view];
    }
    @catch (NSException *e) {
        return NO;
    }
}

- (NSString *)expression {
    return [self.predicate predicateFormat];
}

+ (PredicateMatcher *)matcherForPredicateExpression:(NSString *)expression {
    return [[PredicateMatcher alloc] initWithPredicate:[NSPredicate predicateWithFormat:expression]];
}

@end

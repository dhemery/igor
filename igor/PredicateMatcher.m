
#import "PredicateMatcher.h"

@implementation PredicateMatcher {
    NSPredicate* predicate;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"[PredicateMatcher:[predicate:%@]]", predicate];
}

-(PredicateMatcher*) initWithPredicateExpression:(NSString*)expression {
    self = [super init];
    if(self) {
        predicate = [NSPredicate predicateWithFormat:expression];
    }
    return self;
}

-(BOOL) matchesView:(UIView*)view {
    @try {
        return [predicate evaluateWithObject:view];
    }
    @catch (NSException* e) {
        return NO;
    }
}

-(NSString*) matchExpression {
    return [predicate predicateFormat];
}

+(PredicateMatcher*) withPredicateExpression:(NSString*)expression {
    return [[PredicateMatcher alloc] initWithPredicateExpression:expression];
}

@end

#import <OCHamcrestIOS/HCDescription.h>
#import "PredicateMatcherForExpression.h"
#import "PredicateMatcher.h"

@implementation PredicateMatcherForExpression {
    NSString *_expression;
}

+ (id) forExpression:(NSString *)expression{
    return [[self alloc] initWithClass:expression];
}

- (id) initWithClass:(NSString *)expression {
    if (self = [super init]) {
        _expression = [[NSPredicate predicateWithFormat:expression] predicateFormat];
    }
    return self;
}

- (BOOL) matches:(id)item {
    if ([item class] != [PredicateMatcher class]) {
        return NO;
    }
    return [[((PredicateMatcher*) item) matchExpression] isEqualToString:_expression];
}

- (void) describeTo:(id<HCDescription>)description; {
    [[description appendText:@"Predicate matcher for expression "] appendText:_expression];
}

@end

id<HCMatcher> predicateMatcherForExpression(NSString *expression) {
    return [PredicateMatcherForExpression forExpression:expression];
}

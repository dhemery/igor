#import "ClassPattern.h"
#import "InstanceMatcher.h"
#import "InstancePattern.h"
#import "PredicatePattern.h"
#import "PredicateMatcher.h"

@implementation InstancePattern

+ (InstancePattern *)forScanner:(PatternScanner *)scanner {
    return (InstancePattern *) [[self alloc] initWithScanner:scanner];
}

- (InstanceMatcher *)parse {
    id<ClassMatcher> classMatcher = [[ClassPattern forScanner:self.scanner] parse];
    id<SimpleMatcher> predicateMatcher = [[PredicatePattern forScanner:self.scanner] parse];
    return [InstanceMatcher withClassMatcher:classMatcher predicateMatcher:predicateMatcher];
}

@end

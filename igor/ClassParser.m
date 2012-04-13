#import "ClassParser.h"
#import "KindOfClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "IgorQueryScanner.h"
#import "UniversalMatcher.h"


@implementation ClassParser {
    id <IgorQueryScanner> scanner;
}

- (id <SimplePatternParser>)initWithScanner:(id <IgorQueryScanner>)theScanner {
    if (self = [super init]) {
        scanner = theScanner;
    }
    return self;
}

- (BOOL)parseSimpleMatcherIntoArray:(NSMutableArray *)simpleMatchers {
    if ([scanner skipString:@"*"]) {
        [simpleMatchers addObject:[UniversalMatcher new]];
        return YES;
    }

    NSString *className;
    if (![scanner scanNameIntoString:&className]) return NO;

    Class targetClass = NSClassFromString(className);
    if ([scanner skipString:@"*"]) {
        [simpleMatchers addObject:[KindOfClassMatcher matcherForBaseClass:targetClass]];
    } else {
        [simpleMatchers addObject:[MemberOfClassMatcher matcherForExactClass:targetClass]];
    }
    return YES;
}

+ (id <SimplePatternParser>)parserWithScanner:(id <IgorQueryScanner>)scanner {
    return [[self alloc] initWithScanner:scanner];
}
@end

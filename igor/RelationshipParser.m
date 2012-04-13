#import "InstanceParser.h"
#import "RelationshipParser.h"
#import "IgorQueryStringScanner.h"

@implementation RelationshipParser {
    id <IgorQueryScanner> scanner;
}

@synthesize subjectPatternParsers;

- (id <SubjectChainParser>)initWithScanner:(id <IgorQueryScanner>)theScanner {
    if (self = [super init]) {
        scanner = theScanner;
    }
    return self;
}

- (BOOL)parseSubjectMatcherIntoArray:(NSMutableArray *)subjectMatchers {
    for (id <SubjectPatternParser>parser in subjectPatternParsers) {
        if ([parser parseSubjectMatcherIntoArray:subjectMatchers]) return YES;
    }
    return NO;
}

- (BOOL)parseCombinator {
    return [scanner skipWhiteSpace];
}

- (BOOL)parseSubjectMatchersIntoArray:(NSMutableArray *)subjectMatchers {
    if (![self parseSubjectMatcherIntoArray:subjectMatchers]) return NO;
    while([self parseCombinator] && [self parseSubjectMatcherIntoArray:subjectMatchers]);
    return YES;
}

+ (id <SubjectChainParser>)parserWithScanner:(id <IgorQueryScanner>)scanner {
    return [[self alloc] initWithScanner:scanner];
}

@end

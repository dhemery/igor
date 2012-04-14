#import "BranchParser.h"
#import "ComplexMatcher.h"
#import "IgorQueryScanner.h"
#import "SubjectChainParser.h"
#import "UniversalMatcher.h"

@implementation BranchParser {
    id <IgorQueryScanner> scanner;
    id <SubjectChainParser> instanceChainParser;
}
- (id <SubjectPatternParser>)initWithScanner:(id <IgorQueryScanner>)aScanner subjectChainParser:(id <SubjectChainParser>)theSubjectChainParser {
    self = [super init];
    if (self) {
        scanner = aScanner;
        instanceChainParser = theSubjectChainParser;
    }
    return self;
}

- (BOOL)parseSubjectMatcherIntoArray:(NSMutableArray *)subjectMatchers {
    if (![scanner skipString:@"("]) return NO;

    NSMutableArray *branchSubjectChain = [NSMutableArray array];
    if (![instanceChainParser parseSubjectMatchersIntoArray:branchSubjectChain]) {
        [scanner failBecause:@"Expected instance pattern"];
    }
    if (![scanner skipString:@")"]) {
        [scanner failBecause:@"Expected ')'"];
    }

    id <SubjectMatcher> subject = [branchSubjectChain objectAtIndex:0];
    [branchSubjectChain removeObjectAtIndex:0];

    id <SubjectMatcher> tail = [self subjectMatcherFromMatcherChain:branchSubjectChain];
    [subjectMatchers addObject:[ComplexMatcher matcherWithSubject:subject tail:tail]];
    return YES;
}

- (id <SubjectMatcher>)subjectMatcherFromMatcherChain:(NSArray *)matcherChain {
    if ([matcherChain count] == 0) {
        return [UniversalMatcher new];
    }
    if ([matcherChain count] == 1) {
        return [matcherChain lastObject];
    }
    id <SubjectMatcher> matcher = [matcherChain objectAtIndex:0];
    for (NSUInteger i = 1; i < [matcherChain count]; i++) {
        matcher = [ComplexMatcher matcherWithHead:matcher subject:[matcherChain objectAtIndex:i]];
    }
    return matcher;
}

+ (id <SubjectPatternParser>)parserWithScanner:(id <IgorQueryScanner>)scanner subjectChainParser:(id <SubjectChainParser>)subjectChainParser {
    return [[self alloc] initWithScanner:scanner subjectChainParser:subjectChainParser];
}
@end
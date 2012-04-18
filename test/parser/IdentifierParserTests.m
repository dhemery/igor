#import "PatternParser.h"
#import "IdentifierMatcher.h"
#import "IdentifierParser.h"
#import "QueryScanner.h"
@interface IdentifierParserTests : SenTestCase
@end

@implementation IdentifierParserTests {
    id <QueryScanner> scanner;
    id <PatternParser> parser;
}

- (void)setUp {
    parser = [IdentifierParser new];
}

- (void)testNoMatcherIfNextCharacterIsNotPound {
    scanner = [QueryScanner scannerWithString:@"notpound"];

    assertThat([parser parseMatcherFromScanner:scanner], is(nilValue()));
}

- (void)testParsesLettersAsName {
    NSString *allLetters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSString *allLettersIdentifier = [NSString stringWithFormat:@"#%@", allLetters];
    scanner = [QueryScanner scannerWithString:allLettersIdentifier];

    IdentifierMatcher *matcher = (IdentifierMatcher *)[parser parseMatcherFromScanner:scanner];

    assertThat(matcher, instanceOf([IdentifierMatcher class]));
    assertThat(matcher.targetAccessibilityIdentifier, equalTo(allLetters));
}

- (void)testNamesMayIncludeDigits {
    NSString *withDigits = @"a01234567890";
    NSString *identifierWithDigits = [NSString stringWithFormat:@"#%@", withDigits];
    scanner = [QueryScanner scannerWithString:identifierWithDigits];

    IdentifierMatcher *matcher = (IdentifierMatcher *)[parser parseMatcherFromScanner:scanner];

    assertThat(matcher, instanceOf([IdentifierMatcher class]));
    assertThat(matcher.targetAccessibilityIdentifier, equalTo(withDigits));
}

@end
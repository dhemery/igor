#import "DEPatternParser.h"
#import "DEIdentifierMatcher.h"
#import "DEIdentifierParser.h"
#import "DEQueryScanner.h"
@interface IdentifierParserTests : XCTestCase
@end

@implementation IdentifierParserTests {
    id <DEQueryScanner> scanner;
    id <DEPatternParser> parser;
}

- (void)setUp {
    parser = [DEIdentifierParser new];
}

- (void)testNoMatcherIfNextCharacterIsNotPound {
    scanner = [DEQueryScanner scannerWithString:@"notpound"];

    assertThat([parser parseMatcherFromScanner:scanner], is(nilValue()));
}

- (void)testParsesLettersAsName {
    NSString *allLetters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSString *allLettersIdentifier = [NSString stringWithFormat:@"#%@", allLetters];
    scanner = [DEQueryScanner scannerWithString:allLettersIdentifier];

    DEIdentifierMatcher *matcher = (DEIdentifierMatcher *)[parser parseMatcherFromScanner:scanner];

    assertThat(matcher, instanceOf([DEIdentifierMatcher class]));
    assertThat(matcher.targetAccessibilityIdentifier, equalTo(allLetters));
}

- (void)testNamesMayIncludeDigits {
    NSString *withDigits = @"a01234567890";
    NSString *identifierWithDigits = [NSString stringWithFormat:@"#%@", withDigits];
    scanner = [DEQueryScanner scannerWithString:identifierWithDigits];

    DEIdentifierMatcher *matcher = (DEIdentifierMatcher *)[parser parseMatcherFromScanner:scanner];

    assertThat(matcher, instanceOf([DEIdentifierMatcher class]));
    assertThat(matcher.targetAccessibilityIdentifier, equalTo(withDigits));
}

@end
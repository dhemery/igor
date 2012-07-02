#import "DEPatternParser.h"
#import "DEAccessibilityIdentifierMatcher.h"
#import "DEIdentifierParser.h"
#import "DEQueryScanner.h"
#import "DETagMatcher.h"

@interface IdentifierParserTests : SenTestCase
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

    DEAccessibilityIdentifierMatcher *matcher = (DEAccessibilityIdentifierMatcher *)[parser parseMatcherFromScanner:scanner];

    assertThat(matcher, instanceOf([DEAccessibilityIdentifierMatcher class]));
    assertThat(matcher.targetAccessibilityIdentifier, equalTo(allLetters));
}

- (void)testNamesMayIncludeDigits {
    NSString *withDigits = @"a01234567890";
    NSString *identifierWithDigits = [NSString stringWithFormat:@"#%@", withDigits];
    scanner = [DEQueryScanner scannerWithString:identifierWithDigits];

    DEAccessibilityIdentifierMatcher *matcher = (DEAccessibilityIdentifierMatcher *)[parser parseMatcherFromScanner:scanner];

    assertThat(matcher, instanceOf([DEAccessibilityIdentifierMatcher class]));
    assertThat(matcher.targetAccessibilityIdentifier, equalTo(withDigits));
}

- (void)testParsesDigitsAsTag {
    NSInteger aNumber = 1234;
    NSString *allDigitsIdentifier = [NSString stringWithFormat:@"#%d", aNumber];
    scanner = [DEQueryScanner scannerWithString:allDigitsIdentifier];

    DETagMatcher *matcher = (DETagMatcher *)[parser parseMatcherFromScanner:scanner];
    assertThat(matcher, instanceOf([DETagMatcher class]));

    equalToInt(aNumber);
    assertThatInt(matcher.targetTag, equalToInt(aNumber));
}

@end

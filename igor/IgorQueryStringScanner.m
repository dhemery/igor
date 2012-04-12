#import "IgorQueryStringScanner.h"
#import "IgorParserException.h"


@implementation IgorQueryStringScanner {
    NSScanner *scanner;
}

- (NSString *)description {
    return [scanner string];
}

- (void)failBecause:(NSString *)reason {
    @throw [IgorParserException exceptionWithReason:reason scanner:scanner];
}

- (void)failIfNotAtEnd {
    if (![scanner isAtEnd]) {
        [self failBecause:@"Unexpected characters"];
    }
}

- (IgorQueryStringScanner *)initWithPattern:(NSString *)query {
    self = [super init];
    if (self) {
        NSString *stripped = [query stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        scanner = [NSScanner scannerWithString:stripped];
        [scanner setCharactersToBeSkipped:nil];
    }
    return self;
}

- (BOOL)nextStringIs:(NSString*)string {
    NSUInteger originalLocation = [scanner scanLocation];
    if ([scanner scanString:string intoString:nil]) {
        [scanner setScanLocation:originalLocation];
        return YES;
    }
    return NO;
}

- (BOOL)scanNameIntoString:(NSString **)destination {
    return [scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:destination];
}

- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)destination {
    return [scanner scanUpToString:string intoString:destination];
}

- (BOOL)skipString:(NSString *)string {
    return [scanner scanString:string intoString:nil];
}

- (BOOL)skipWhiteSpace {
    return [scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:nil];
}

+ (IgorQueryStringScanner *)withQuery:(NSString *)query {
    return [[self alloc] initWithPattern:query];
}

@end
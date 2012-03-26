@interface PatternScanner : NSObject

- (void)failBecause:(NSString *)string;
- (void)failIfNotAtEnd;
- (BOOL)scanNameIntoString:(NSString **)destination;
- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)destination;
- (BOOL)skipString:(NSString *)string;
- (BOOL)skipWhiteSpace;

+ (PatternScanner *)withPattern:(NSString *)pattern;

@end

@protocol DEQueryScanner <NSObject>

- (void)failBecause:(NSString *)string;

- (void)failIfNotAtEnd;

- (BOOL)scanDigitsIntoString:(NSString **)destination;

- (BOOL)scanNameIntoString:(NSString **)destination;

- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)destination;

- (BOOL)skipString:(NSString *)string;

- (BOOL)skipWhiteSpace;

@end

@interface DEQueryScanner : NSObject <DEQueryScanner>

@property (strong) NSScanner *scanner;

+ (id <DEQueryScanner>)scannerWithString:(NSString *)queryString;

@end

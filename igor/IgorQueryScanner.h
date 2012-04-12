@protocol IgorQueryScanner <NSObject>

- (void)failBecause:(NSString *)string;
- (void)failIfNotAtEnd;
- (BOOL)nextStringIs:(NSString *)string;
- (BOOL)scanNameIntoString:(NSString **)destination;
- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)destination;
- (BOOL)skipString:(NSString *)string;
- (BOOL)skipWhiteSpace;

@end

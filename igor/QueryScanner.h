@protocol QueryScanner <NSObject>

- (void)failBecause:(NSString *)string;

- (void)failIfNotAtEnd;

- (BOOL)scanNameIntoString:(NSString **)destination;

- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)destination;

- (void)setQuery:(NSString *)query;

- (BOOL)skipString:(NSString *)string;

- (BOOL)skipWhiteSpace;

@end

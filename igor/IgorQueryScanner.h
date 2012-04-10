@interface IgorQueryScanner : NSObject

- (void)backUp;
- (void)failBecause:(NSString *)string;
- (void)failIfNotAtEnd;
- (BOOL)scanNameIntoString:(NSString **)destination;
- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)destination;
- (BOOL)skipString:(NSString *)string;
- (BOOL)skipWhiteSpace;

+ (IgorQueryScanner *)withQuery:(NSString *)query;

@end

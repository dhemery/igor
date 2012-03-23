
@interface Pattern : NSObject

@property(retain, readonly) NSScanner *scanner;

- (Pattern *)initWithScanner:(NSScanner *)scanner;

@end
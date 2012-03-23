@class PatternScanner;

@interface Pattern : NSObject

@property(retain, readonly) PatternScanner *scanner;

- (Pattern *)initWithScanner:(PatternScanner *)scanner;

@end
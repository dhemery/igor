#import "Pattern.h"
#import "PatternScanner.h"

@implementation Pattern

@synthesize scanner = _scanner;

- (Pattern *)initWithScanner:(PatternScanner *)scanner {
    self = [super init];
    if (self) {
        _scanner = scanner;
    }
    return self;
}

@end
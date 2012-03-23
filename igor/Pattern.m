#import "Pattern.h"

@implementation Pattern

@synthesize scanner = _scanner;

- (Pattern *)initWithScanner:(NSScanner *)scanner {
    self = [super init];
    if (self) {
        _scanner = scanner;
    }
    return self;
}

@end
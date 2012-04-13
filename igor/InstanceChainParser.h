@protocol IgorQueryScanner;

@protocol InstanceChainParser <NSObject>

- (void)parseInstanceMatchersIntoArray:(NSMutableArray *)array;

@end
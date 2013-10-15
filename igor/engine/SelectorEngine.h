@protocol SelectorEngine
- (NSArray *)selectViewsWithSelector:(NSString *)query;
- (NSArray *)selectViewsWithSelector:(NSString *)selector inWindows:(NSArray *)windows;
@end

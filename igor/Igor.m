
#import "Igor.h"
#import "IgorParser.h"
#import "TreeWalker.h"

@implementation Igor

-(NSArray*) findViewsThatMatchPattern:(NSString*)pattern fromRoot:(UIView*)root {
    Matcher* matcher = [[IgorParser new] parse:pattern];
    NSMutableSet* matchingViews = [NSMutableSet set];
    void (^collectMatches)(UIView*) = ^(UIView* view) {
        if([matcher matchesView:view]) {
            [matchingViews addObject:view];
        }
    };
    [TreeWalker walkTree:root withVisitor:collectMatches];
    return [matchingViews allObjects];
}

-(NSArray*) selectViewsWithSelector:(NSString*)pattern {
    return [self findViewsThatMatchPattern:pattern
                                  fromRoot:[[UIApplication sharedApplication] keyWindow]];
}

@end
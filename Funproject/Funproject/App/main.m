//
//  main.m
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

//
//  Jobs_ObjectiveC_LaboratoryUITestsLaunchTests.m
//  Jobs_ObjectiveC_LaboratoryUITests
//
//  Created by Jobs on 22/10/2021.
//

#import <XCTest/XCTest.h>

@interface Jobs_ObjectiveC_LaboratoryUITestsLaunchTests : XCTestCase

@end

@implementation Jobs_ObjectiveC_LaboratoryUITestsLaunchTests

+ (BOOL)runsForEachTargetApplicationUIConfiguration {
    return YES;
}

- (void)setUp {
    self.continueAfterFailure = NO;
}

- (void)testLaunch {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // Insert steps here to perform after app launch but before taking a screenshot,
    // such as logging into a test account or navigating somewhere in the app

    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:XCUIScreen.mainScreen.screenshot];
    attachment.name = @"Launch Screen";
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    [self addAttachment:attachment];
}

@end

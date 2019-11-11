//
//  ViewController.m
//  CardValidator
//
//  Created by Sergey Krasnogorov on 11/10/19.
//  Copyright © 2019 Sergey Krasnogorov. All rights reserved.
//

#import "ViewController.h"
#import <CardValidatorFramework/CardValidatorFramework.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputField;
@end

@implementation ViewController

/**
    Callback for "Validate" button
 */
- (IBAction)OnButtonValidateClicked:(id)sender {
    [CardValidator ValidateCardFull:self.inputField.text callback:^(Card *result, NSString *errorMessage) {
        
        NSString *alertMessage;
        if (result) {
            alertMessage = [NSString stringWithFormat:NSLocalizedString(@"Card with number %@ is valid! Brand of this card is %@.", ""),
                            result.cardNumber,
                            result.brand];
        }
        else {
            alertMessage = errorMessage;
        }
        [self performSelectorOnMainThread:@selector(displayMessage:) withObject:alertMessage waitUntilDone:NO];
    }];
}
/**
    Private method for displaying message from another thread
    @param message - message to display
 */
- (void)displayMessage:(NSString*)message {

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                               message:message
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];

}
@end

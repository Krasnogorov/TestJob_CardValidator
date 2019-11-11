Task: Credit Card Number Evaluator
We work with different types of data on a daily basis. An example of data we process is user
credit card information. One of the common tasks is filtering lists of numbers based on two
factors:
- the validity of the number
- the network the number belongs to
Your task is to design and implement a Swift/Objective-C framework which provides methods to
perform this filtering. The Project must be compilable and executable. Do not use any 3rd party
Libraries.
You can use code from your previous projects. All the details of the API design are up to you.
Please pay attention to the code quality, its architecture and test components.
Definitions
Assume that a credit card number is valid if:
- it contains only numbers and no leading 0
- it is 12-19 digits long
- it passes the Luhn check https://en.wikipedia.org/wiki/Luhn_algorithm. For credit
card numbers, the Luhn check digit is the last digit of the sequence.
In addition, connect to https://binlist.net API and put additional information about credit card in
response to user of your framework. You are free to choose information about the card number,
which you consider necessary to return to the user.
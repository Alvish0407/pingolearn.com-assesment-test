### An E-commerce app _(eShop)_ built with Flutter & Firebase



https://github.com/user-attachments/assets/bc066ae5-30fe-426f-b4b8-f91f5951fe69


<details>
<summary>Assignmnet: An e-commerce app</summary>
  
**The Challenge**:
You have to build an e-commerce app which uses Firebase Authentication, Firebase Remote Config and will fetch products from https://dummyjson.com/products as per the specified designs.

**What is expected:**
- Firebase Authentication (email only)
- Collect details (name, email) [Store details collected in Firestore in user
collection]
- A products feed showing the all the products from
(https://dummyjson.com/products)
- The products from the API will have a discountPercentage field, you will
need to use discountPercentage to calculate the discountedPrice from the
actual price field and display it accordingly in the UI.
- Create a boolean in Firebase Remote Config to decide whether we display
the discountedPrice or the original price. [if boolean in Firebase Remote Config is true we calculate the discountedPrice from the discountPercentage for each product and display it or else we only display the original price]

**Design specs:**
https://www.figma.com/proto/plVEnYXYi6CMsCSZdrsPRf/products?node-id=7%3A3&scaling=scale-down&page-id=0%3A1&starting-point-node-id=7%3A3
or
https://tinyurl.com/bdcwr4ah

**Must Haves:**
- Flutter >= v2.2.0
- Error Handling for Backend Services ex: API/Firebase interaction exceptions and errors
- Form validation
- State management [Provider only]
     
**Bonus Points:**
- Keep the app size as small as possible
- Following the latest design guidelines
- Follow any well-known architecture pattern
- Surprise us with your creativity!
- Feel free to use any third-party dependencies that may solve the problem

**Evaluation Criteria:**
1. Code quality - The code should be well structured
2. Completeness - All the features listed above should work as expected 3. Presentability - The user interface must be clean and usable
</details>

## Prerequisite
1. Download [fvm](https://fvm.app/) and follow the [instructions](https://fvm.app/documentation/guides/basic-commands#examples-1)
2. [Setup](https://github.com/Alvish0407/kaam-hiring-test/blob/main/README.md#running-the-project-with-firebase) Firebase Project

## Features

- [x] Implement user login and registration using Firebase Authentication (Email and Password)
- [x] Include basic form validation (e.g., email format, password strength)
- [x] API call to fetch products from server
- [x] Firebase Remote Config to dynamically display the product price along with the discount

## Packages in use

These are the main packages used in the app:

- [Provider](https://pub.dev/packages/provider) A wrapper around InheritedWidget to make them easier to use and more reusable.
- [GoRouter](https://pub.dev/packages/go_router) for navigation
- [Firebase Auth](https://pub.dev/packages/firebase_auth) for authentication
- [Cloud Firestore](https://pub.dev/packages/cloud_firestore) as a realtime database
- [Build Runner](https://pub.dev/packages/build_runner) is concrete way of generating files using Dart code
- [Firebase Remote Config](https://pub.dev/packages/firebase_remote_config)
- [Dio](https://pub.dev/packages/dio) A powerful HTTP networking package.

See the [pubspec.yaml](pubspec.yaml) file for the complete list.

## Running the project with Firebase

To use this project with Firebase, follow these steps:

- Create a new project with the Firebase console
- Enable Firebase Authentication, along with the Email/Password Authentication Sign-in provider in the Firebase Console (Authentication > Sign-in method > Email/Password > Edit > Enable > Save)
- Enable Cloud Firestore
- Enable Firebase Remote Config

### Using the CLI

Make sure you have the Firebase CLI and [FlutterFire CLI](https://pub.dev/packages/flutterfire_cli) installed.

Then run this on the terminal from the root of this project:

- Run `firebase login` so you have access to the Firebase project you have created
- Run `flutterfire configure` and follow all the steps

That's it. Have fun!

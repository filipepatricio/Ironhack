# Ironhack-Testing

# Introduction #

Understand how to unit test a separate component of our app, creating the fake objects that are necessary.

# Exercises #

## Basic Testing ##

### Open project ###

Learn the basics.

1. Clone the project
2. Take your time to run and have a look at the different components of the app. Specially the sectioned array data source and the cell adapter.
3. See which dependencies have each component and have a look at their header files and documentations.

### Setting up the test case ###

1. Create a new test case class for the sectioned array data source: New File -> Source -> Test Case Class -> and name your class SectionedArrayDataSourceTests
2. Our system under test will be the SectionedArrayDataSource
3. Add the appropiate methods on setup` and `tearDown`
3. Think about the dependencies this class has on other classes. Do we need fake objects? Why?
4. Add fake objects for the cell adapter and the table view. Remember that these objects must have the minimum implementation to make the sut work
5. Add a simple test that checks that the SUT is not nil and run it. You've passed your first unit test!

### Going deeper ###

We need to test the public interface of the sectioned array data source. This means, we mainly need to test the `UITableViewDataSource` methods as well as the `itemAtIndexPath:` method and `items` property.

1. Add a test that checks that both the SUT and the table view's data source are the same
2. Add a test that checks that if there's no items in the data source there are not sections nor rows
3. Add a test that checks that, if the items property of the data source is an array containing an array of three strings, the number of sections and number of rows is the correct one
4. Add a test that checks that, if the items property is an array containing two arrays of three strings each one, the number of sections is the correct one
5. Add a test that checks that, if the items property is an array containing two arrays of two strings the first one and six strings the second one, the number of sections is the correct one
6. Add a tests that checks that, changing the items property of the data source three times asserts each time the correct items in each section.
7. Add a test that checks that, for an items property that is an array of three strings, the sut should give a non nil item for a valid index path.
8. Add a test that checks that, for an items property that is an array of three strings, the sut should give a nil item for an invalid index path.
9. Add a test that checks that for an invalid value of items, the sut should throw a NSInvalidArgumentException (check the header file for the sectioned array data source for the details on this)
9. Do you think we need more tests to prove the correctness of this system under test?
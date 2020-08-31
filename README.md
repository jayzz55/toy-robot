# Toy Robot Challenge

## Description

- The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement
  that would result in the robot falling from the table must be prevented, however further valid movement commands must still
  be allowed.

Create an application that can read in commands of the following form:

```plain
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

- PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
- The origin (0,0) can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed.
- MOVE will move the toy robot one unit forward in the direction it is currently facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- REPORT will announce the X,Y and orientation of the robot.
- A robot that is not on the table can choose to ignore the MOVE, LEFT, RIGHT and REPORT commands.
- Provide test data to exercise the application.

## Constraints

The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.
Any move that would cause the robot to fall must be ignored.

Example Input and Output:

```plain
PLACE 0,0,NORTH
MOVE
REPORT
Output: 0,1,NORTH
```

```plain
PLACE 0,0,NORTH
LEFT
REPORT
Output: 0,0,WEST
```

```plain
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
Output: 3,3,NORTH
```

## Dev Setup

* Install Ruby at least version 2.6.6
* Install Ruby libraries by running `bundle install`

## Running the app

The app can be run with:

```
./bin/run
```

The app uses the `$stdin.gets` to prompt user to input the valid command.

alternatively, the app can also be run by redirecting a text file like following:

```
./bin/run < spec/fixtures/input_3.txt
```

## Design

The design of this app is heavily influenced by the ["Railway Oriented Programming" style](https://fsharpforfunandprofit.com/rop/). To help achieve this, I mainly use [Dry::Monads](https://dry-rb.org/gems/dry-monads/1.3/) as the interface of the result value.

### General flow of the App

The general high level flow of the App follows:
```
input_string
  |> validate_input_string
  |> validate_command
  |> parse_input_into_command
  |> execute_command
```

### Error Handling

Error Handling in this App is very explicit and avoid raising exception where possible. In the case where an exception does occur, it is deemed to be an unexpected and unrecoverrable error. In general, an explicit error as a value is returned when an error due to bad data or violation of business logic.

The following are list of errors considered in this app:

* invalid_placement
* invalid_movement
* invalid_direction
* missing_robot
* invalid_input
* Unexpected Exception


### Thoughts on modules

The following explains the thought process on the file or module namespace used in this app:

* App - This file is the main application that is decoupled from the IO. The interface of App takes a simple string, then validate, parse, and execute command. This will return either a Success or Failure.
* Main - This file is the glue that binds the App with the relevant IO to be able to run the application on the bin file.
* Commands - These follows the Command Pattern and are used to execute the side effect - mutating state. These will return either a Success or Failure.
* Constants - These are placeholder for storing constants.
* Handlers - These are a collection of objects that heavily interact with the IO. These normally sit outside the App and are the glue between the `Main` and the `App`.
* Models - These are collection of model that represents a domain model and carry state.
* Representers - These are simple objects that represent a domain model into a different representation.
* Services - Theses are pure simple helper objects that are used to calculate things and return values.
* Validators - These are objects that are responsible in helping validating the incoming input. These will return either a Success or Failure.

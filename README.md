# Software Development Roles and Practices (or How to solve the Rubik's cube)

Software development is not just coding, like many may think (just update your code to do this, and it is done! 😩)
It involves many roles and practices in the complete development process if you want to avoid common software issues.
We will develop an application to solve Rubik's code using all the practices defined in a formal software development process (OPEN UP) and show why all roles are needed to create maintainable and usable software.
All these roles and practices are needed in any software development process (SCRUM, KANBAN...).
The same person can perform different roles, but you must seek the role's objectives as acting in any relo.
To make a clear relationship with this presentation and the OPEN UP, we will follow their terminology.

![Open UP EPF generated website](img.png)

Software development is a team process. Sorry coders, you are just 20% off the business 😁

# The Project

Let's start our project, we will skip the Project Manager Role and focus on
the development part only. We will start with the Analyst who received a request
to solve the Rubik's cube from a very large customer!

## Role: Analyst

![Analyst](img_2.png)

Given the Rubik Cube, we need step-by-step instructions on how to solve it. 
The faster, the better, but speed is not an issue.

### USE CASE
We want to use the app this way:

- We open the app
- describe how my cube is now (color disposition on each face)
- when finished describing it, hit a button to show me the solution
- If I need another solution, repeat the process.
- It would be very nice to show the solution visually, if possible.

### WIREFRAME

![show](img_8.png)

![solve](img_9.png)

## Role: Architect

![Architect](img_3.png)


### Envision the Architecture

As an architect, to start we always look for existing solutions for similar problems.
The time you spent in discovery, is a well spent time, because we will save much more in the full development.
Searching the internet, you can find a lot of stuff about the cube, tutorials, competitions, movement's notation, algorithms...,
In our case, we are interested in how to solve. We find a very complet site about is at https://ruwix.com

About automatiing the solution, we are interested in libraries to give you the steps to solve it?
We searched: "Rubik code solution",  "Rubik code solution in ruby", "Rubik code solution in javascript".
In the end, we foud these options:

### How to solve the cube
There are many option, form the simplest to more complex ones. Here are some:
- https://rubikscu.be/#tutorial
- https://ruwix.com/the-rubiks-cube/how-to-solve-the-rubiks-cube-beginners-method/step-1-first-layer-edges/

## Automated solutions
We serached for automated solutions in any language, we found many and selected these ones:

### Gem wit a an easy two-cycle solution
In our tests, tt generates too many stesp (+400) or do not return at all.
It was our first option, since it is a gem and our app is in Rails, but we discarded it.
https://github.com/chrishunt/rubiks-cube

### JS to solve the cube
Very fast, fewer movements ~25 for any state. Lets use it!
https://www.npmjs.com/package/cubejs

### Library to display the cube Movements
Very nice and easy to use 3D widget created and used by Ruwik site everywhere.

[Example](https://ruwix.com/widget/3d/?label=teste&alg=U%20R2%20F%27%20D%27%20R%20U%20R2%20F%20R%20B%27%20L%20F2%20U2%20R2%20D%20R2%20U%27%20R2%20D%20F2%20B2%20D%20L2%20F2&flags=showalg)

After the research, we decide to make a solution like this:

## Refine the Architecture

- Create the APP in ROR: One main screen to receive the cube description, send to a solution library, and show the solution on the same screen.
(1 controller: cube, 1 action: setup, 1 model:cube)
- Use the RUBJS javascript component to solve the cube: The cube description must follow the guideline defined by the CUBEJS solver
- On another screen show the solution animation, Using the 3D widget to display the found solution.
- For demonstration we host and deploy the application on Heroku in a free account


# Role: Developer
![Developer](img_4.png)

Using ROR this implementation is very straigh forward

    rails new cube --database=postgresql
    rake db:setup
    rails g controller Cube solve show
    rails s

Start by your Views:

Solve
Here we will receive the input from the user and call the cube solver 
using javascript, as defined in the wireframe
[app/views/cube/solve.html.erb]
 
Show
we in include the cube 3D widget that will display the 
cube and animate its solution
[app/views/cube/solve.html.erb]

The cube controller
[app/controllers/cube_controller.erb]

Test it!

    rails s

### Solving the cube

    yarn add cubejs

in app/javascript/packs/application.js
add this code to create cube state sample [scramble]
and solve the provided cube and display the solution 
with the movements notation

```javascript
// using cubejs to solve the cube, linked to two buttons
const Cube = require('cubejs');
// This takes 4-5 seconds on a modern computer
Cube.initSolver();

function solveCube(colorString) {
    var faceString = color_to_face(colorString)
    let cube = Cube.fromString(faceString);
    let solution = cube.solve(50)
    return solution
}

function color_to_face(color_string) {
    const conv = {"W": "D", "O": "B", "R": "F", "G": "R", "Y": "U", "B": "L"};
    let face_string = "";
    color_string.split('').forEach(function(c) {
        face_string = face_string + conv[c]
    })
    return face_string
}

function face_to_color(face_string) {
    const conv = {"F": "R", "R": "G", "L": "B", "U": "Y", "B": "O", "D": "W"};
    let color_string = "";
    face_string.split('').forEach(function(c) {
        color_string = color_string + conv[c]
    })
    return color_string
}

addEventListener("turbolinks:load", function (_event) {
    $("#btn_scramble").click(function(){
        let cube = Cube.random()
        let faceString = cube.asString()
        let colorString = face_to_color(faceString)
        $('#initial_state').val(colorString)
    });
    $("#btn_solve").click(function(){
        if ($('#initial_state').length > 0) {
            let initialState = $('#initial_state').val()
            initialState = initialState.replace(/\s/g, '')
            initialState = initialState.replace(/\n/g, '')
            let solution = solveCube(initialState)
            $('#solution').val(solution)
        }
    })
})
```
### Eat your own dog food!
Run you application until it is good enough to show to others!
```
rails s
```

# Role: Tester

![Tester](img_5.png)

Lets creata an automated test providng this cube state

    BBORYYRGBWBGWGBGYWWOORRBYWOGGYGWOBOGOWBRBYRYRWOYROGRWY

and expected result should be

    R' D F2 L' F B R' B' D' B U F2 U' R2 F2 R2 U' F2 R2 F2 D2 R2 U

and we expect to show the cube image on the show screen exactly like defined in the fists page.
after all movement the cube must be solved.

First we run it manually!


```
rails s
```

To create such test we will use Capybara to reproduce the use case defined in it's DSL.

```


```

Run the tests!

```
rake
rspec
```


# Role: Deployment Engineer

![img_6.png](img_6.png)

To deploy to heroku, create your account there and install the heroku client
    
```terminal
    heroku create
    git push heroku master
    heroku run rake db:migrate   
```

Visit your app
```terminal
    heroku open    
```
or https://mighty-gorge-83383.herokuapp.com


## Other Roles

We did not cover all the roles, just the main ones, but you have all roles in the Open Up process.

![Other Roles](img_7.png)

# REFERENCES

- https://medium.com/@LucianeS/openup-um-processo-integrado-e-agil-a4400c17ce62
- https://www.eclipse.org/epf/
- https://www.eclipse.org/downloads/download.php?file=/technology/epf/PracticesLibrary/published/epf_practices_published_1.5.1.5_20121212.zip
- https://www.eclipse.org/downloads/download.php?file=/technology/epf/OpenUP/published/openup_published_1.5.1.5_20121212.zip

# Software Development Roles and Practices (or How to solve the Rubik's cube)

Software development is not just coding, like many may think (just update your code to do this, and it is done! 😩)
It involves many roles and practices in the complete development process if you want to avoid common software issues.

We will develop an application to solve Rubik's code using all the practices defined in a formal software development process (OPEN UP) 
and show why all roles are needed to create maintainable and usable software.

All these roles and practices are needed in any software development process (SCRUM, KANBAN...).
The same person can perform different roles, but you must seek the role's objectives while acting in any role.
To make a clear relationship between this presentation and the OPEN UP, we will follow their terminology.

![Open UP EPF generated website](img.png)

Software development is a team process. Sorry coders, you are just 20% off the business 😁

# The Project

Let's start our project, we will skip the Project Manager Role and focus on
the development part only. We will start with the Analyst who received a request
to solve the Rubik's cube from a very strategic customer ASAP!

## Role: Analyst

![Analyst](img_2.png)

Given the Rubik Cube, we need a web application that provide the user step-by-step instructions on how to solve it. 
The faster, the better, but speed is not an issue. No need to teach how to solve, just to provide the solution.

As an Analyst, I always look for existing solutions for similar problems, specially when I suspect I am not the only one with a similar problem.
The time you spent in discovery, is a well spent time, we will save much more in the later development.

Searching the internet, you can find a lot of stuff about the cube, tutorials, competitions, movement's notation, algorithms...,
In our case, we are interested in how to solve. We find a very complete site about is at https://ruwix.com which I used a main reference.

We also found this very nice app that does exactly what we need!

[[Asolver video on YouTube](img_10.png)](https://youtu.be/XRHKbgQ0Dj0)


*Disclaimer: Any coincidence with features, screens, or use cases was pure similarity*

### USE CASE
Understanding the problem, we defined along with the customer how this app should look like and defined
the following use case for it:

- We open the app
- describe how my cube is now (color disposition on each face)
- when finished describing it, hit a button to show me the solution in the same page
- If I need another solution, repeat the process.
- It would be very nice to show the solution visually in a 3D animation, if possible.

### WIREFRAME
After a lot of research ans considering some contraints of knowledge and time, we defined a simpler solution:

![show](img_8.png)

![solve](img_9.png)

## Role: Architect

![Architect](img_3.png)

### Envision the Architecture

The problem is very clearly defined, so we nedd to find the most effective way to provide this app.

### How to solve the cube
There are many options, form the simplest to more complex ones. Here are some:
- https://rubikscu.be/#tutorial
- https://ruwix.com/the-rubiks-cube/how-to-solve-the-rubiks-cube-beginners-method/step-1-first-layer-edges/

To make our own algorithim to solve it will be very difficult and time consuming, and for sure someone else has already did that.
We are interested in existing libraries that provide all the steps to solve a Rubik's cube, there must be ready a solution for it.
We searched: "Rubik code solution",  "Rubik code solution in ruby", "Rubik code solution in javascript".
In the end, we foud these options:

## Automated solutions
We searched for automated solutions in any language, we found many and selected these ones:

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

After the research, we decide how to make it with our familiar tools:

## Refine the Architecture

- Create the APP in ROR: One main screen to receive the cube description, send to a solution library, and show the solution on the same screen.
(1 controller: cube, 1 action: setup, 1 model:cube)
- Use the RUBJS javascript component to solve the cube: The cube description must follow the guideline defined by the CUBEJS solver
- On another screen show the solution animation, Using the 3D widget to display the found solution.
- For demonstration we host and deploy the application on Heroku in a free account



### Obs:
The analyst/Architecure tasks are very linked, we may change the desired outcome base on the 
available technology or resources, so its very common to both work together in many interactions 
until you get a satisfactory solution for business and technology.

![img_13.png](img_13.png)

![img_11.png](img_11.png)

![img_12.png](img_12.png)

(slides from Chris Alvarez’s presentation about Design)

# Role: Developer
![Developer](img_4.png)

Using ROR this implementation is very straigh forward

```bash
rails new cube --database=postgresql
rake db:setup
rails s
```

To have these two screens we need a controller with two actions: solve and show

```bash
rails g controller Cube solve show
```

The cube controller has these 2 actions:

[controller source code](https://github.com/jlneto/cube/blob/master/app/controllers/cube_controller.rb)

The Solve action we will receive the input from the user and call the cube solver 
using javascript, as defined in the wireframe

[solve source code](https://github.com/jlneto/cube/blob/master/app/views/cube/solve.html.erb)
 
The Show action we will show the cube 3D widget that will display the 
cube and animate its solution

[show source code](https://github.com/jlneto/cube/blob/master/app/views/cube/show.html.erb)

Test it!

```bash
rails s
```

### Solving the cube

```bash
yarn add cubejs
```

in app/javascript/packs/application.js
add this code to create cube state sample [scramble]
and solve the provided cube and display the solution 
with the movements notation

[application.js](https://github.com/jlneto/cube/blob/master/app/javascript/packs/application.js)


### Eat your own dog food!
Run you application until it is good enough to show to others!
```bash
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


```bash
rails s
```

To create such test we will use Capybara to reproduce the use case defined in it's DSL.
Add these lines to the [Gemfile](https://github.com/jlneto/cube/blob/master/Gemfile)

```ruby
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'capybara'
end
```
run these commands:
```bash
bundle install
rails generate rspec:install
```

add the following lines to [rails_helper.rb](https://github.com/jlneto/cube/blob/master/spec/rails_helper.rb)

```ruby
require 'capybara'
require 'capybara/rspec'
require 'webdrivers'
require 'capybara/rails'
```
Make sure rspec is working

```bash
rspec
```

Write the following test in rspec/features/solve_spec.rb

[solve_spec.rb](https://github.com/jlneto/cube/blob/master/spec/features/solve_spec.rb)

Run the test!

```bash
rspec
```


# Role: Deployment Engineer

![img_6.png](img_6.png)

If the app is working fine, all automated tests are ok, time to deploy to production, and the more automated the better.
We will deploy it to heroku as an example. Create your account there and install the heroku client if you alreay do not have it.
    
After that, run the following commands:

```bash
    heroku create
    git push heroku master
```
Heroku will deploy your app automatically as soon as it is commited to it's repository.
If it is deployed correctly. Visit your app

```bash
    heroku open    
```
or you can see an example [here](https://mighty-gorge-83383.herokuapp.com)


### Other Roles

We did not cover all the roles, just the main ones, but you have all roles in the Open Up process.

![Other Roles](img_7.png)

# REFERENCES

- https://www.ibm.com/developerworks/rational/library/content/03July/1000/1251/1251_bestpractices_TP026B.pdf
- https://en.wikipedia.org/wiki/Rational_Unified_Process
- https://www.eclipse.org/epf/
- https://www.eclipse.org/downloads/download.php?file=/technology/epf/PracticesLibrary/published/epf_practices_published_1.5.1.5_20121212.zip
- https://www.eclipse.org/downloads/download.php?file=/technology/epf/OpenUP/published/openup_published_1.5.1.5_20121212.zip
- https://medium.com/@LucianeS/openup-um-processo-integrado-e-agil-a4400c17ce62
  
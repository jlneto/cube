// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import Cube from "cubejs"

var initialState = document.getElementById('initial_state')
var solveButton = document.getElementByName('commit')
function solveCube(initial_state) {
    const cube = Cube.fromString(initialState.value)
    Cube.initSolver()
    cube.solve(50)
    alert(cube.inspect)
}
solveButton.onClick(solveCube)





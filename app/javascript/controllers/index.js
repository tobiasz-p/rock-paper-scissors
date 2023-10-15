// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Probably in app/javascript/controllers/index.js
import { Application } from '@hotwired/stimulus'

// import HelloController from "./controllers/hello_controller"
import ContentLoader from 'stimulus-content-loader'

window.Stimulus = Application.start()

// Stimulus.register("hello", HelloController)
Stimulus.register('content-loader', ContentLoader)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

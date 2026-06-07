import { Controller } from "@hotwired/stimulus"

// Keeps the page-progress slider, number input, and large display in sync,
// and powers the quick "+N pages" buttons on the update-progress screen.
export default class extends Controller {
  static targets = ["input", "slider", "display"]

  sync(event) {
    this.update(event.target.value)
  }

  add(event) {
    const max = Number(this.inputTarget.max) || Infinity
    const current = Number(this.inputTarget.value) || 0
    this.update(Math.min(current + Number(event.params.amount), max))
  }

  update(value) {
    this.inputTarget.value = value
    if (this.hasSliderTarget) this.sliderTarget.value = value
    if (this.hasDisplayTarget) this.displayTarget.textContent = value
  }
}

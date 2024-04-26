import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static get targets() {
    return ["form"];
  }

  toggle(event) {
    event.preventDefault();
    this.formTarget.classList.toggle("d-none");
  }
}

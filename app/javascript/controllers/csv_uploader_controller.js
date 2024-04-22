import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "output"];

  displayFileName() {
    this.outputTarget.innerHTML = this.inputTarget.files[0].name;
  }
  selectFile() {
    this.inputTarget.click();
  }
}

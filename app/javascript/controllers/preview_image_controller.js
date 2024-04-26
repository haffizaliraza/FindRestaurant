import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["output", "input", "slider"];

  displayImagePreview() {
    var input = this.inputTarget;
    var output = this.outputTarget;

    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function () {
        output.src = reader.result;
      };

      reader.readAsDataURL(input.files[0]);
    }
  }

  displayMenuPreview() {
    let preview = document.querySelector("#menu-preview");
    preview.innerHTML = "";
    for (let i = 0; i < this.sliderTarget.files.length; i++) {
      let file = this.sliderTarget.files[i];
      let reader = new FileReader();
      reader.onload = function (e) {
        let img = document.createElement("img");
        img.src = e.target.result;
        img.classList.add("image-preview");
        img.classList.add("col-3");
        preview.appendChild(img);
      };
      reader.readAsDataURL(file);
    }
  }

  displaySliderPreview() {
    let preview = document.querySelector("#image-preview");
    preview.innerHTML = "";
    for (let i = 0; i < this.sliderTarget.files.length; i++) {
      let file = this.sliderTarget.files[i];
      let reader = new FileReader();
      reader.onload = function (e) {
        let img = document.createElement("img");
        img.src = e.target.result;
        img.classList.add("image-preview");
        img.classList.add("col-3");
        preview.appendChild(img);
      };
      reader.readAsDataURL(file);
    }
  }

  selectImage() {
    this.inputTarget.click();
  }
}

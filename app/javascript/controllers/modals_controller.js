import { Controller } from "@hotwired/stimulus";
import { Modal } from "bootstrap";

export default class extends Controller {
  connect() {
    this.modal = new Modal(this.element);
    this.modal.show();
    const that = this;
    document.addEventListener("click", function (e) {
      if (
        !document.querySelector(".modal-content")?.contains(e.target) &&
        document.querySelector("#shareRecipeModal")?.contains(e.target)
      ) {
        that.closeModal();
      }
    });
  }

  hideBeforeRender(event) {
    if (this.isOpen()) {
      event.preventDefault();
      this.element.addEventListener("hidden.bs.modal", event.detail.resume);
      this.modal.hide();
    }
  }

  closeModal() {
    document.querySelector("#remote_modal").innerHTML = " ";
    const body = document.querySelector(".modal-open");
    body?.removeAttribute("style");
    body?.removeAttribute("class");
  }

  isOpen() {
    return this.element.classList.contains("show");
  }

  disconnect() {
    document.querySelector(".modal-backdrop").remove();
    document.querySelector(".modal-open")?.classList.remove("modal-open");
  }
}

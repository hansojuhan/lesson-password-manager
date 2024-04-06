import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    content: String
  }

  connect() {
    this.originalText = this.element.textContent
  }

  copy() {
    navigator.clipboard.writeText(this.contentValue).then(
      () => {
        // Success
        this.element.textContent = "Copied!"
      },
      () => {
        // Fail
        alert("Failed to copy to clipboard.")
      }
    )
  }
}

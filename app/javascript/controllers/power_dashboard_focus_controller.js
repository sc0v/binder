import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.scrollToFocus()
  }

  scrollToFocus() {
    const banner = document.querySelector(".flash[role='alert']")
    if (banner) {
      requestAnimationFrame(() => {
        banner.scrollIntoView({ block: "start", behavior: "auto" })
      })
      return
    }

    const title = this.element.querySelector("h1")
    if (title) {
      requestAnimationFrame(() => {
        title.scrollIntoView({ block: "start", behavior: "auto" })
      })
    }
  }
}

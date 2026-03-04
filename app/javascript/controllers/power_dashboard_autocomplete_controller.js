import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "menu"]
  static values = { url: String, examples: Array }

  connect() {
    this.timeoutId = null
    this.abortController = null
    this.activeIndex = -1
    this.handleDocumentClick = (event) => {
      if (!this.element.contains(event.target)) this.clearMenu()
    }
    document.addEventListener("click", this.handleDocumentClick)
    this.hideTimeoutId = null
  }

  disconnect() {
    document.removeEventListener("click", this.handleDocumentClick)
  }

  queue() {
    if (this.timeoutId) clearTimeout(this.timeoutId)
    this.timeoutId = setTimeout(() => this.fetchSuggestions(), 300)
  }

  async fetchSuggestions() {
    const query = this.inputTarget.value.trim()
    if (query.length < 2) {
      this.showExamples()
      return
    }

    if (this.abortController) this.abortController.abort()
    this.abortController = new AbortController()

    const url = new URL(this.urlValue, window.location.origin)
    url.searchParams.set("q", query)

    try {
      const response = await fetch(url.toString(), { signal: this.abortController.signal })
      if (!response.ok) return
      const data = await response.json()
      this.renderMenu(Array.isArray(data.suggestions) ? data.suggestions : [])
    } catch (error) {
      if (error.name !== "AbortError") this.clearMenu()
    }
  }

  renderMenu(suggestions) {
    this.menuTarget.textContent = ""
    this.activeIndex = -1

    if (suggestions.length === 0) {
      this.menuTarget.classList.remove("is-open")
      return
    }

    const list = document.createElement("ul")
    list.className = "power-autocomplete__list"

    suggestions.forEach((suggestion, index) => {
      const item = document.createElement("li")
      item.className = "power-autocomplete__item"

      const button = document.createElement("button")
      button.type = "button"
      button.className = "power-autocomplete__button"
      button.dataset.index = index
      button.dataset.value = suggestion.value

      const label = document.createElement("span")
      label.className = "power-autocomplete__label"
      label.textContent = suggestion.label

      const meta = document.createElement("span")
      meta.className = "power-autocomplete__meta"
      meta.textContent = suggestion.type || ""

      button.appendChild(label)
      button.appendChild(meta)
      button.addEventListener("mousedown", (event) => {
        event.preventDefault()
        this.applySuggestion(button.dataset.value)
      })

      item.appendChild(button)
      list.appendChild(item)
    })

    this.menuTarget.appendChild(list)
    this.menuTarget.classList.add("is-open")
  }

  navigate(event) {
    const list = this.menuTarget.querySelector(".power-autocomplete__list")
    if (!list) return

    const items = Array.from(list.querySelectorAll(".power-autocomplete__button"))
    if (items.length === 0) return

    switch (event.key) {
      case "ArrowDown":
        event.preventDefault()
        this.activeIndex = (this.activeIndex + 1) % items.length
        break
      case "ArrowUp":
        event.preventDefault()
        this.activeIndex = (this.activeIndex - 1 + items.length) % items.length
        break
      case "Enter":
        if (this.activeIndex >= 0) {
          event.preventDefault()
          this.applySuggestion(items[this.activeIndex].dataset.value)
        }
        return
      case "Escape":
        this.clearMenu()
        return
      default:
        return
    }

    items.forEach((item, index) => {
      if (index === this.activeIndex) {
        item.classList.add("is-active")
      } else {
        item.classList.remove("is-active")
      }
    })
  }

  applySuggestion(value) {
    this.inputTarget.value = value || ""
    this.inputTarget.focus()
    this.clearMenu()
    if (this.inputTarget.form) this.inputTarget.form.requestSubmit()
  }

  showExamples() {
    const query = this.inputTarget.value.trim()
    if (query.length >= 2) return
    if (!this.hasExamplesValue || this.examplesValue.length === 0) {
      this.clearMenu()
      return
    }
    this.renderMenu(this.examplesValue)
  }

  scheduleHide() {
    if (this.hideTimeoutId) clearTimeout(this.hideTimeoutId)
    this.hideTimeoutId = setTimeout(() => this.clearMenu(), 150)
  }

  clearMenu() {
    this.menuTarget.textContent = ""
    this.menuTarget.classList.remove("is-open")
    this.activeIndex = -1
  }

}

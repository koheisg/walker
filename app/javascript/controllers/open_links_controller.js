import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "links" ]

  open() {
    const links = this.linksTarget.value.split(' ')

    if (window.confirm(`Opening ${links.length} links! Are you sure?`)) {
      links.forEach((link) => {
        window.open(link, '_blank')
      })
    }
  }
}

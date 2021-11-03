import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['link']

  open() {
    navigator.share({
      title: this.linkTarget.title,
      url: this.linkTarget.href,
    }).then(() => {
      console.log('share');
    });
  }
}
